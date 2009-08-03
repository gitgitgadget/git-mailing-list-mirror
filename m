From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5] Add Gitweb support for XZ compressed snapshots
Date: Mon, 3 Aug 2009 02:27:45 +0200
Message-ID: <200908030227.46550.jnareb@gmail.com>
References: <B05AF655-7430-420A-A22E-389601558B0D@uwaterloo.ca> <200908030125.53534.jnareb@gmail.com> <9b18b3110908021655r18203816u2864ffb95aabb354@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J.H." <warthog19@eaglescrag.net>,
	Mark A Rada <marada@uwaterloo.ca>, git@vger.kernel.org
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 02:28:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXlPJ-0002RA-CP
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 02:28:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753679AbZHCA1s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Aug 2009 20:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753426AbZHCA1s
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Aug 2009 20:27:48 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:62842 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146AbZHCA1r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2009 20:27:47 -0400
Received: by ewy10 with SMTP id 10so2699116ewy.37
        for <git@vger.kernel.org>; Sun, 02 Aug 2009 17:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=lbK1B1DJy8ZYCrIvc46hA39h8dHge/qVrMaT5gJxNZw=;
        b=Kmz2s+oeGEndyZ7IoTnqd6iGa87c3aQwVcaF1kQ1CqyldaAqQWlPUtbo9hYQ4trZ8O
         EaDRhgmSLKSzc3EFs61599AcvQAJ4v/TOYM5Er8IjCmx9kzdiY/RRNKmULnC42Px4ADd
         VfEMYhTjMZ8qvcsFQKCSo+tnGj0phVZ6Tosq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=RZTviEcNH3PEeZe764Woo5hN1aUl8F6DiXcTaBog1RvZ+xi9y3ZjSbJaU7LivhzX/A
         WjiVdhXR/ssvY2M1fwQm92lgrqvZIBBhnqiNp20KJKC/ZYwIR+r4SZYc84aiuW6+wN/Z
         C2W1rto8C1buNf5wIacVXwwYtbOzpiN+1/hMo=
Received: by 10.210.82.18 with SMTP id f18mr2607244ebb.38.1249259267102;
        Sun, 02 Aug 2009 17:27:47 -0700 (PDT)
Received: from ?192.168.1.13? (abwm214.neoplus.adsl.tpnet.pl [83.8.236.214])
        by mx.google.com with ESMTPS id 28sm6009802eye.34.2009.08.02.17.27.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 Aug 2009 17:27:46 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <9b18b3110908021655r18203816u2864ffb95aabb354@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124680>

On Mon, 3 August 2009, demerphq wrote:
> 2009/8/3 Jakub Narebski <jnareb@gmail.com>:
>> On Sat, 1 Aug 2009, demerphq wrote:
>>> 2009/8/1 Jakub Narebski <jnareb@gmail.com>:

>>>> Do you mean gitweb serving http://perl5.git.perl.org/ ?
>>>
>>> Yes. I updated it to a relatively recent version just the other wee=
k.
>>
>> By the way, if you don't mind, how do you keep your changes on top
>> of changing target, i.e. on top of updating baseline to recent
>> versions?
>=20
> Things broke. I fixed them. :-)

Err... I meant here to ask if you use merging into your branch, rebasin=
g
your branch on top of upstream, using some patch management interface l=
ike
StGIT, Guilt ot Quilt, or topic branch management tool namely TopGit?
=20
>>> Also probably there are one or two patches that should be pushed ba=
ck
>>> to you.
>>
>> What do those patches consist of?
>=20
> One has to do with layout problems in the blame, and I think one deal=
s
> with broken line number anchor links.
>=20
> Ill look closer when i have more time.

About the one with broken 'linenr' links: you should look at patch whic=
h
makes gitweb use information in "previous" header from git-blame -p,=20
which was send to git mailing list and is currently in 'pu':
  [PATCHv2 03/10] gitweb: Use "previous" header of git-blame -p in 'bla=
me' view
  Message-Id: <1248475450-5668-4-git-send-email-jnareb@gmail.com>
  http://article.gmane.org/gmane.comp.version-control.git/123961


What layout problems in 'blame' view did you notice?=20

>> By the way, this is one of the only two places where we have to
>> use quote_command and 3-argument form of open, instead of list for o=
f
>> magic open. =A0It is because of pipeline, piping git-archive output
>> into compressor. =A0The other such place is git_object, to redirect =
error
>> stream to /dev/null (to discard stderr).
>>
>> I thought about replacing it by list form of open somewhat (you can
>> find it in git mailing list archive), but it is not easy. =A0And IPC=
::Run
>> is IMVHO a bit of overkill, especially for "minimal dependencies"
>> gitweb (perhaps for Git::Web?).
>=20
> Lately I have been playing with Capture::Tiny, which seems to fill
> some nice niches in this respect.

I don't quite see how you plan to use Capture::Tiny here.  The output
of git-archive has to be passed to compressor, and then dumped to stdou=
t,
not captured.

--=20
Jakub Narebski
Poland

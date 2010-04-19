From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Mon, 19 Apr 2010 23:33:49 +0530
Message-ID: <j2ke72faaa81004191103qabe0c3ddj959d8804e873ed04@mail.gmail.com>
References: <201004150630.44300.chriscool@tuxfamily.org>
	 <201004181950.19610.jnareb@gmail.com>
	 <20100418195623.GA3563@machine.or.cz>
	 <201004191243.24209.jnareb@gmail.com>
	 <20100419115113.GC3563@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, Sam Vilain <sam@vilain.net>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Apr 19 20:03:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3vK9-0005NC-35
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 20:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462Ab0DSSDv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Apr 2010 14:03:51 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:37407 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648Ab0DSSDu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Apr 2010 14:03:50 -0400
Received: by yxe29 with SMTP id 29so2605142yxe.4
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 11:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zHfjeG9z8u059qxEYcjJX9Intsc8kGFcP68rWximINY=;
        b=bkX5EzP6+BIwYIz4u2HqA8hXAUj2FkqNJXGYWy/4t4IiutBoKOc2SsVp/2V0ptx9rA
         aq8b6o6UXr8MRh5Yd6cJ8K/jj98EWPbJleaIsvfj3WiWK0otl8oTk0p9BPA5UuAot+pI
         csc12Lpc6aNwlSohMxTzv5nDc+DwY7Vnkjc8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GvmiEbqqoukK3t/ZFqZ1jVrKE4Cpop9MPxKPGZaRo43mkssOUtNRTV4Wf1bVaNXZQ5
         pPWcyvSZApCS2vRoym9E2NJSL6O7u2GJuynEFS6z9sYyWNm3Nwc1Gvv5Col7FfCPij/7
         CFgvRXrXSVvoAnqUG/gqq9ZUZH9wwtrAmN/C0=
Received: by 10.90.118.4 with HTTP; Mon, 19 Apr 2010 11:03:49 -0700 (PDT)
In-Reply-To: <20100419115113.GC3563@machine.or.cz>
Received: by 10.90.167.19 with SMTP id p19mr3212426age.43.1271700229074; Mon, 
	19 Apr 2010 11:03:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145320>

On Mon, Apr 19, 2010 at 5:21 PM, Petr Baudis <pasky@suse.cz> wrote:
> On Mon, Apr 19, 2010 at 12:43:22PM +0200, Jakub Narebski wrote:
>> On Sun, Apr 18, 2010 at 21:56 +0200, Petr Baudis wrote:
>> > If the project is a success, I wanted to use it for mob branch edi=
ting
>> > on repo.or.cz. It could also be used as open-source Gist alternati=
ve.
>>
>> For that you would need editing file / editing contents action, but
>> this is explicitely excluded in current version of Pavan's proposal =
:-(
>
> Is it? I see it only being omitted.

Yes, you can see it in "future functionalities" section of the proposal=
=2E

Implementing a proper and perfect file editor will be a tough job. So,
I removed it from GSoC and listed in that section.
But we can always have a simple textarea to implement it and I think I
will have time to do this simple textarea during my GSoC.

>
>> > But it needs to be coded so that it does not require an actual che=
cked
>> > out copy (which shouldn't be too much hassle).
>>
>> It would require using 'git hash-object -t blob -w --stdin' (from bo=
dy
>> submitted via POST from textarea) plus 'git update-index --cacheinfo=
'.
>
> Yes. Not a whole lot of effort, seems to me. A downside is that you
> cannot use the working tree - index dichotomy, but life isn't perfect=
=2E
>
>> There is however complication that you would need to do open2/open3
>> because git-hash-object would require bidirectional communication un=
less
>> you would use temporary file (command_bidi_pipe in Git.pm, untested)=
=2E
>
> I think even just going through a temporary file is fine for initial
> implementation.
>
>> So additional step would be
>>
>> =A0 =A0 =A0 =A0 cp -fvR gitweb/lib /var/www/cgi-bin/ =A0 =A0;# as ro=
ot
>
> Yes!
>
>> I hope that we could make installing gitweb as easy as
>>
>> =A0 =A0 =A0 =A0 make webscriptdir=3D/var/www/cgi-bin/ \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0gitweb-install
>>

We can try it. :-)

>> or in more complicated case (gitweb modules not installed in cgi-bin=
)
>>
>> =A0 =A0 =A0 =A0 make webscriptdir=3D/var/www/cgi-bin/gitweb \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0GITWEB_BASE=3D"/gitweb/" \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0GITWEBPERLLIB=3D/usr/local/lib/perl5 \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0gitweb-install
>>
>> or something like that (I do not know any standard for the name of b=
uild
>> configuration variable which tells where to install web aplication;
>> do you?)
>
> Ideally, yes, but that's not directly tied to the splitting effort.
> (No clue about the configuration variable.)
>
>> Well, I would perhaps start simply with
>>
>> =A0 gitweb.perl
>> =A0 lib/Gitweb.pm
>>
>> We can modify file organization later; what's important is the build
>> infrastructure (even if it is instruction in gitweb/INSTALL).
>
> That sounds like the best way. :)
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Petr "=
Pasky" Baudis
> http://pasky.or.cz/ | "Ars longa, vita brevis." -- Hippocrates
>

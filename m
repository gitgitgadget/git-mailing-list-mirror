From: demerphq <demerphq@gmail.com>
Subject: Re: obnoxious CLI complaints
Date: Fri, 11 Sep 2009 01:19:28 +0200
Message-ID: <9b18b3110909101619n6904a75dm10dd0b5717fb0d76@mail.gmail.com>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com>
	 <200909101850.26109.jnareb@gmail.com>
	 <43d8ce650909101246l50189c97r4f3fc4a8d7a0bd4@mail.gmail.com>
	 <200909102223.31602.jnareb@gmail.com>
	 <43d8ce650909101504q32448cb9w562a43969d01b1fe@mail.gmail.com>
	 <7v4ora76vr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Tapsell <johnflux@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Brendan Miller <catphive@catphive.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 01:19:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlsvR-0002Ep-Mt
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 01:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbZIJXT1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Sep 2009 19:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbZIJXT0
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 19:19:26 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:37046 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbZIJXT0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Sep 2009 19:19:26 -0400
Received: by ewy2 with SMTP id 2so622039ewy.17
        for <git@vger.kernel.org>; Thu, 10 Sep 2009 16:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Fl/r4RFDbYPwTW980mozKxmti50k8x3yq7mb6fO8vOk=;
        b=Rh5P+tIGQYLemhbmbFZKWhwPHRo6Ya6LYCHkb+5vHi/OUldw/yPw4ySEGKpeHxrm61
         IIfyOwwlGAxoYFBUmnLz2f5wKE9k6w9uRJ9JbYGygEiBxJWv5+N37kQb034xrzfAZJ81
         5art8A92AKQp0s8Yw0uyIZit2YSPyUbXlGHTc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vI793zuFBggUYri5tCzwLTwD/BHGyywDehoOLGOMsmRr54WIb7Dn26XxZ+UkXFXJAk
         DikYOsf+VViEaZDX8du+E9w4kcmOQ2aarNUILy3Ffo//zzGlK19yAzelvB6fwUHF8k2U
         iOgqKVIw9RHEsNnVPqyLnRqmXASzLNMdwdyE8=
Received: by 10.216.54.143 with SMTP id i15mr256480wec.222.1252624768120; Thu, 
	10 Sep 2009 16:19:28 -0700 (PDT)
In-Reply-To: <7v4ora76vr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128158>

2009/9/11 Junio C Hamano <gitster@pobox.com>:
> John Tapsell <johnflux@gmail.com> writes:
>
>> 2009/9/10 Jakub Narebski <jnareb@gmail.com>:
>>> Dnia czwartek 10. wrze=B6nia 2009 21:46, John Tapsell napisa=B3:
>>>> 2009/9/10 Jakub Narebski <jnareb@gmail.com>:
>>>
>>>> > First, it would be consistent with how ordinary archivers such a=
s tar
>>>> > or zip are used, where you have to specify list of files to arch=
ive
>>>> > (in our case this list is HEAD). =A0Second, I'd rather not accid=
entally
>>>> > dump binary to terminal: "git archive [HEAD]" dumps archive to s=
tandard
>>>> > output.
>>>>
>>>> That could be fixed by outputting to a file. =A0git format-patch o=
utputs
>>>> to a file, so why wouldn't git achieve?
>>>
>>> "git format-patch" outputs to files because it generates _multiple_
>>> files; generating single patch is special case. =A0Also git-format-=
patch
>>> can generate file names from patch (commit) subject; it is not the =
case
>>> for "git archive" (what name should it use?).
>>
>> What if it used the current (or topleve) directory name? =A0Wouldn't
>> that work in most cases?
>
> Following along the same line of reasoning, it would work in most cas=
es if
> the output is literally named "archive.tar". =A0If it is not the name=
 the
> user wants, the user can "mv" afterwards, or give an explicit filenam=
e.

Why not $sha1.tar?

> What it does _not_ allow is to send the output to a downstream comman=
d for
> postprocessing without introducing some magic token to say "standard
> output" (e.g. "git archive -f - | (cd ../foo && tar xf -)").
>
> If the default is to write to the standard output, we won't have all =
of
> these issues. =A0People who want a file can name the file by
>
> =A0 =A0 =A0 =A0git archive >my.file.tar
>
> and people who want to pipe (which is 99% of the use pattern for me) =
can
> say
>
> =A0 =A0 =A0 =A0git archive | down stream commands.
>
> Oh, wait.
>
> That is exactly what we have, so what's the point of continuing this
> discussion any further? =A0Can we just stop?

Is it portable to assume that piping is always in binmode? From a
portability POV i could imagine piping being a problem in this
respect, and might be why tar provides a way to output to a file and
not just to a handle. For example ISTR that on windows piping is by
default in text mode. I think its not a showstopper there as you can
change it, but still, from a portability point of view you might not
want to depend on piping.

cheers,
Yves


--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"

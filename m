From: John Tapsell <johnflux@gmail.com>
Subject: Re: obnoxious CLI complaints
Date: Fri, 11 Sep 2009 03:18:55 +0300
Message-ID: <43d8ce650909101718j2f1f77cbgc347ee755145353f@mail.gmail.com>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com>
	 <200909101850.26109.jnareb@gmail.com>
	 <43d8ce650909101246l50189c97r4f3fc4a8d7a0bd4@mail.gmail.com>
	 <200909102223.31602.jnareb@gmail.com>
	 <43d8ce650909101504q32448cb9w562a43969d01b1fe@mail.gmail.com>
	 <7v4ora76vr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Brendan Miller <catphive@catphive.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 02:19:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mltr1-0007L2-AK
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 02:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbZIKASw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Sep 2009 20:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbZIKASw
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 20:18:52 -0400
Received: from mail-yx0-f176.google.com ([209.85.210.176]:59069 "EHLO
	mail-yx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbZIKASw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Sep 2009 20:18:52 -0400
Received: by yxe6 with SMTP id 6so875394yxe.22
        for <git@vger.kernel.org>; Thu, 10 Sep 2009 17:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Fq7H8qPskwEHBDQr/W8XzCDJfRfbEYD8wPCSE/Q/qtU=;
        b=xGv7K8jhvwuTgb/5ESzQqyDfhRrvH36eEK/B9JtDPJvuklgsJHAu50zkCYbq224QFe
         dT7+q4iBQDlf0F7z/4C4ZkBwmGABGiJLqsBe9OETIrpfM0votCrDpHpsOHDNZvla3P52
         +x9MTcJRPu7WhxafG9Tvhoxf41UkHFbtc7Ces=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gIyQAUekfkpzqV3I8Dq354bE3j8+Yb3UGjWWTKiXB/itPAoUlm8JHXGb8LoNSllXxu
         G1KP/FyFfmGFwgAw34ILaNbBqi8GZIZt07wYw+VMC0MCoCo2HnV3gU7NAfaAQr1Gij/J
         ePsRUqGTeihPJrJ/5UpfJf4lxFbE4WX5hiKDQ=
Received: by 10.150.237.4 with SMTP id k4mr3816987ybh.93.1252628335104; Thu, 
	10 Sep 2009 17:18:55 -0700 (PDT)
In-Reply-To: <7v4ora76vr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128163>

2009/9/11 Junio C Hamano <gitster@pobox.com>:
> John Tapsell <johnflux@gmail.com> writes:
>
>> 2009/9/10 Jakub Narebski <jnareb@gmail.com>:
>>> Dnia czwartek 10. wrze=C5=9Bnia 2009 21:46, John Tapsell napisa=C5=82=
:
>>>> 2009/9/10 Jakub Narebski <jnareb@gmail.com>:
>>>
>>>> > First, it would be consistent with how ordinary archivers such a=
s tar
>>>> > or zip are used, where you have to specify list of files to arch=
ive
>>>> > (in our case this list is HEAD). =C2=A0Second, I'd rather not ac=
cidentally
>>>> > dump binary to terminal: "git archive [HEAD]" dumps archive to s=
tandard
>>>> > output.
>>>>
>>>> That could be fixed by outputting to a file. =C2=A0git format-patc=
h outputs
>>>> to a file, so why wouldn't git achieve?
>>>
>>> "git format-patch" outputs to files because it generates _multiple_
>>> files; generating single patch is special case. =C2=A0Also git-form=
at-patch
>>> can generate file names from patch (commit) subject; it is not the =
case
>>> for "git archive" (what name should it use?).
>>
>> What if it used the current (or topleve) directory name? =C2=A0Would=
n't
>> that work in most cases?
>
> Following along the same line of reasoning, it would work in most cas=
es if
> the output is literally named "archive.tar". =C2=A0If it is not the n=
ame the
> user wants, the user can "mv" afterwards, or give an explicit filenam=
e.

That would also work.  Like how gcc uses "a.out" as the default filenam=
e


> What it does _not_ allow is to send the output to a downstream comman=
d for
> postprocessing without introducing some magic token to say "standard
> output" (e.g. "git archive -f - | (cd ../foo && tar xf -)").

Right, so what's wrong with the magic token?  There's plenty of precede=
nce.


> If the default is to write to the standard output, we won't have all =
of
> these issues.

These are issues?

> =C2=A0People who want a file can name the file by
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git archive >my.file.tar

I thought you didn't like this because then you dump binary to the
console by default ?

> and people who want to pipe (which is 99% of the use pattern for me) =
can
> say
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git archive | down stream commands.

Why would it be so bad to do:

git archive -f - | down stream commands

?

This is the most logical way forward.  It keeps the command simple for
simple use cases (make an archive - "git archive")  but easily
scalable for more complex use cases (add a  "-f -" if you want to do
magical things)

John

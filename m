From: ZhenTian <loooseleaves@gmail.com>
Subject: Re: I lost my commit signature
Date: Wed, 15 Jun 2016 12:27:15 +0800
Message-ID: <CAGrdoOoxphU0tRjV22yduXrhmOSyCc_zVnhuO9fFA6UPRd9WiA@mail.gmail.com>
References: <CAGrdoOrrpc7OiU74fa-qpjLNxOtm4upAOAfWPG6VbWUjyE0C2Q@mail.gmail.com>
 <20160614075824.GB12563@sigill.intra.peff.net> <CAGrdoOp=dDkiTr+Sb-uZWx66b4hoZCYAiRjfgYqoE8H4-kXJvg@mail.gmail.com>
 <20160614081854.GA13457@sigill.intra.peff.net> <CAGrdoOqfcacG488u-MA7UiapgvJEGNX2QaRq8BMmycEWg-BGWg@mail.gmail.com>
 <20160614094121.GA13971@sigill.intra.peff.net> <e129da8e-4e1d-c535-ca62-d2a4c2e23799@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jun 15 06:27:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bD2QJ-0000Xc-JY
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 06:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbcFOE1R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jun 2016 00:27:17 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:34511 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbcFOE1Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2016 00:27:16 -0400
Received: by mail-yw0-f173.google.com with SMTP id c72so9972478ywb.1
        for <git@vger.kernel.org>; Tue, 14 Jun 2016 21:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vulBKizb9ucJW/pWu1Zi+tEUZU4F03rnaJlhsdmysaA=;
        b=fEH/OHRqLBHRVyjLoTLWEzFjgaTCYHoFaYdAGAVhnVuE4IhqyfwiHYhlhhgjxEilhd
         lt73iBiixtL8THZZD+panPSO7feY5tAV06xl4JkO19ZyyhGqFi0QdIIVRVNwKvdoC3p3
         w6ZvLvuUHwt+Vro2FysnHnnzZnQhYh6M4MTpl6zCtlwPwav2iwVexl1Nyf+I/yVECuUA
         rOnmfQ0TqtKj5EqFomnh4wyWa0169P6RP98wYuXcgCGt0Y2dyT1CxkLo7vCsaTu5bKhT
         F+cpcXERxFumaK9X14WtAOYzHvKnzIUotRFoad9UR93Oqod+pixKGXVcioRb2iaFKHuZ
         Gp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vulBKizb9ucJW/pWu1Zi+tEUZU4F03rnaJlhsdmysaA=;
        b=eQZhB1Xz6f9M6at7nxGZuhiVAniNV2EDQBDVc82yf0rkv16VXN9D4jYMC041bBYkqY
         fNo8DqRZofF+rgePDUP79fmiEjo3Pd9JQOvTeWCFifttT9KPmNqZYcjs9WQD2E7UlmFb
         Y8q7NjgaYq/OX0rJFd0ZjHqCD5qbFGS/AyBjkmNevtitFDuBzPW7uRAS5rAZF77h657b
         RIgCTMkbcraIaYwTU+seh3yJiukbMZxrz5OmTR5E2/mf1TYcV0Y6s+lU/3FiL6iZEXsE
         moxCbfYnf6hG3WdnAbKO/wMEwW7xQRy4rUuEzFZu3WyXcTszkIk3B/wE38ml0W91mslB
         f3SA==
X-Gm-Message-State: ALyK8tI9nJt623PqGETv8fVDyROmfaLzlrCL8H90VoviwSrvfy/2aPz1ml2O9QPsrCacj7Y9GsGIDhjBRtSbIQ==
X-Received: by 10.129.153.8 with SMTP id q8mr3778354ywg.227.1465964835529;
 Tue, 14 Jun 2016 21:27:15 -0700 (PDT)
Received: by 10.129.85.203 with HTTP; Tue, 14 Jun 2016 21:27:15 -0700 (PDT)
In-Reply-To: <e129da8e-4e1d-c535-ca62-d2a4c2e23799@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297353>

Hi Michael and Peff,

I got two more lines from gpg -v during commit with -S:
```
gpg: writing to stdout
gpg: RSA/SHA1 signature from: "2EF2AD6E Tian Zhen <tianzhen@honovation.=
com>"
```

after I commit, I push it to remote, but someone had pushed before to
master branch, so I pull on master branch(`git pull --rebase`), then I
check my commit via `git log --show-signature`, there is no signature
in it, so I commit it with --ament and -S again, the signature is come
back.

I haven't check signature before push, because I have checked four
commits before, every commit is fine.

I don't know whether the `git pull` influenced signature or not.

My signature is just like Schrodinger's cat, when I check it, it lost :=
)
-Schr=C3=B6dinger


On Tue, Jun 14, 2016 at 6:57 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Jeff King venit, vidit, dixit 14.06.2016 11:41:
>> On Tue, Jun 14, 2016 at 04:39:38PM +0800, ZhenTian wrote:
>>
>>> I want to set gpg -v to pgp.program, but if I set it, it can't call=
 gpg:
>>> ```
>>> error: cannot run gpg -v: No such file or directory
>>> error: could not run gpg.
>>> fatal: failed to write commit object
>>> ```
>>>
>>> I have tried set gpg.program value to `gpg|/tmp/log`, `/usr/bin/gpg
>>> -v`, `gpg -v`, `"/usr/bin/gpg -v"`
>>>
>>> only after I set to `gpg` or `/usr/bin/gpg` without any argument, i=
t will work.
>>
>> Ah, right. Most of the time we run such programs as shell commands, =
but
>> it looks like we do not. So you'd have to do something like:
>>
>>       cat >/tmp/fake-gpg <<-\EOF
>>       #!/bin/sh
>>       gpg -v "$@"
>>       EOF
>>       chmod +x /tmp/fake-gpg
>>       git config gpg.program /tmp/fake-gpg
>>
>> -Peff
>>
>
> The content of "gpg.program" is used as argv[0] when we build up vari=
ous
> commands to be run; we expect it to heed standard gpg options.
>
> On the other hand:
>
> git -c gpg.program=3Decho commit -S
>
> 'successfully' creates a commit that has
>
> gpgsig -bsau Michael J Gruber <mickey@mouse.dis>
>
> as the last header line. gpg.program=3Dtrue fails (as does cat, unhap=
py
> with the options), so apparently we do some error checking but not en=
ough.
>
> Michael

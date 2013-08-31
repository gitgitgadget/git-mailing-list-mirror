From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] branch: use $curr_branch_short more
Date: Sat, 31 Aug 2013 04:22:44 -0500
Message-ID: <CAMP44s0et9_e5XH-4aydrM-i_+ORampdsitJzK-rSj+4dwPUKw@mail.gmail.com>
References: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com>
	<1377899810-1818-7-git-send-email-felipe.contreras@gmail.com>
	<xmqq38pqwlyl.fsf@gitster.dls.corp.google.com>
	<5221A510.2020206@web.de>
	<CAMP44s1qyF70eSCM4L1Yr=U02AwFZ0TNqiDvag8Qdzzi9GS1Mw@mail.gmail.com>
	<5221B324.7020908@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sat Aug 31 11:22:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFhOT-0006H2-3A
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 11:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101Ab3HaJWq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Aug 2013 05:22:46 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:56121 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677Ab3HaJWq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Aug 2013 05:22:46 -0400
Received: by mail-lb0-f180.google.com with SMTP id q8so2512419lbi.25
        for <git@vger.kernel.org>; Sat, 31 Aug 2013 02:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=1SOC2JKmKRDYxdMslxXJGzH0dw6GppvPVc8DaLMsxZg=;
        b=DuY5R+K3jEJed5sT3DKTfu9b5Fvx8yll8PctqpfziBmZNUSA38gIXIcLhas89AG++8
         luPmfmHOv3tPOEMRTyzSRZ8bd9tjql13OVTG25mRxo2ViLH9Ugen44qekAinbWp8Thrd
         Y6A65kz0LPol52QOvq6K22BygOZdKhDCxP0X4UPkK11kgjQa+6Dd9SrpO/Iazn9kgef3
         Od1fJDSAr3MJG8yejjRuB0cXiIfbGzBfaxnn446HBRTTLiDZ7GxkLcdBelTB7blzmPFH
         a0DEppD6jppQxTArUuOE6DnOrSwrE80bLBg9aSFSqKyBnwFNwylvTgZ+Ubiu5HwJ38EL
         ixpQ==
X-Received: by 10.152.203.233 with SMTP id kt9mr901225lac.29.1377940964347;
 Sat, 31 Aug 2013 02:22:44 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 31 Aug 2013 02:22:44 -0700 (PDT)
In-Reply-To: <5221B324.7020908@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233513>

On Sat, Aug 31, 2013 at 4:11 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote=
:

>> Subject: pull: trivial simplification
>>
>> With that summary, people would have an easier time figuring out if
>> they need to read more about the patch or not.
>
>
> "trivial simplification" is too generic; we could have lots of them.

No, we can have only one, otherwise it would say simplificationS.

> A summary should describe the change.

You can never fully describe the change, only the diff does that.

=46or example "use $curr_branch_short more" does not tell me anything
about the extent of the changes, is it used in one more place? two?
one hundred? Moreover, how exactly is it used more? Is some
refactoring needed?

And it still doesn't answer the most important question any summary
should answer: why? Why use $curr_branch_short more?

> Its low complexity can be derived from
> it -- using an existing variable a bit more is not very exciting.

You didn't say "a bit more" you said "more". And yes, the complexity
can be derived from the summary, but not from this one.

> But I wouldn't call that patch trivial because its correctness depend=
s on
> code outside of its shown context.

Correctness is a separate question from triviality, and the
correctness can only be assessed by looking at the actual patch.

The patch can be both trivial and wrong.

> The reason for the patch isn't mentioned explicitly.  Perhaps it shou=
ld be.
> I felt that using something that's already there instead of recreatin=
g it is
> motivation alone.

Why? Because it simplifies the code. That's the real answer.

--=20
=46elipe Contreras

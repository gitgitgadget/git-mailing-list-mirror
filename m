From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCHv4 2/2] pull --rebase: Avoid spurious conflicts and
 reapplying unnecessary patches
Date: Fri, 13 Aug 2010 00:08:23 +0200
Message-ID: <AANLkTikt6kRZRGW5Y=0qFf41P2HVLe97qGH=5ya5gcbw@mail.gmail.com>
References: <1281592569-740-1-git-send-email-newren@gmail.com>
 <1281592569-740-3-git-send-email-newren@gmail.com> <AANLkTimHiYUPyNTtT4SwapqN8YZGB1wjxJPwTTaPZhEa@mail.gmail.com>
 <AANLkTimoB=__-FmuFYa_rKqMjoYwWQS9hzziuk9Jseyx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
	martinvz <martin.von.zweigbergk@gmail.com>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 00:08:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjfxB-0000QW-He
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 00:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760526Ab0HLWIo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 18:08:44 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43704 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855Ab0HLWIo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 18:08:44 -0400
Received: by yxg6 with SMTP id 6so627556yxg.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 15:08:43 -0700 (PDT)
Received: by 10.231.34.70 with SMTP id k6mr797105ibd.25.1281650923205; Thu, 12
 Aug 2010 15:08:43 -0700 (PDT)
Received: by 10.231.36.6 with HTTP; Thu, 12 Aug 2010 15:08:23 -0700 (PDT)
In-Reply-To: <AANLkTimoB=__-FmuFYa_rKqMjoYwWQS9hzziuk9Jseyx@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153427>

On Thu, Aug 12, 2010 at 10:19 PM, Elijah Newren <newren@gmail.com> wrot=
e:
> Hi,
>
> Thanks for the review and comments!
>
> On Thu, Aug 12, 2010 at 7:34 AM, Santi B=E9jar <santi@agolina.net> wr=
ote:
> <snip>
>> All this makes sense.
>>
>> But can you explain when it happens? One possibility is when you don=
't
>> fork from the tracking branch as in:
>
> That's one possibility. =A0Patch 1/2 in this thread contains testcase=
s
> for two others. =A0Another possibility is having your patches get
> upstream by some alternative route (e.g. pulling your changes to a
> third machine, pushing from there, and then going back to your
> original machine and trying to pull --rebase).

I think this is commit message material.

>
>> Subject: Difference between pull --rebase and fetch+rebase
>> Message-ID: <27059158.post@talk.nabble.com>
>> From: martinvz <martin.von.zweigbergk@gmail.com>
>>
>> and this patch should also fix martinvz's issue (I've CC martinvz, c=
an
>> you test this patch? Thanks).
>
> Since you've cc'd martinvz, I'll note for his benefit that in the
> thread you reference above, you stated,
>
> "By the way, when Git tries to apply these two commits it should dete=
ct
> that they are already applied so it should do nothing, isn't it?"
>
> The answer is no, it won't detect they are already applied, as
> explained in the commit message that started the current thread. =A0(=
If
> git did detect the changes were already applied, this bug would have
> been innocuous.)

Thanks, you are right.

Santi

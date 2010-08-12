From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCHv4 2/2] pull --rebase: Avoid spurious conflicts and
 reapplying unnecessary patches
Date: Fri, 13 Aug 2010 01:17:32 +0200
Message-ID: <AANLkTim6Tg7fNqxFYGU=bxQAn24ipkNaiENU5waCyQ4y@mail.gmail.com>
References: <1281592569-740-1-git-send-email-newren@gmail.com>
 <1281592569-740-3-git-send-email-newren@gmail.com> <AANLkTimHiYUPyNTtT4SwapqN8YZGB1wjxJPwTTaPZhEa@mail.gmail.com>
 <AANLkTimoB=__-FmuFYa_rKqMjoYwWQS9hzziuk9Jseyx@mail.gmail.com> <AANLkTikt6kRZRGW5Y=0qFf41P2HVLe97qGH=5ya5gcbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
	martinvz <martin.von.zweigbergk@gmail.com>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 01:17:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojh26-00034a-U0
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 01:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753760Ab0HLXRx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 19:17:53 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:63606 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937Ab0HLXRx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 19:17:53 -0400
Received: by gwb20 with SMTP id 20so646321gwb.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 16:17:52 -0700 (PDT)
Received: by 10.231.184.16 with SMTP id ci16mr875929ibb.23.1281655072129; Thu,
 12 Aug 2010 16:17:52 -0700 (PDT)
Received: by 10.231.16.196 with HTTP; Thu, 12 Aug 2010 16:17:32 -0700 (PDT)
In-Reply-To: <AANLkTikt6kRZRGW5Y=0qFf41P2HVLe97qGH=5ya5gcbw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153441>

On Fri, Aug 13, 2010 at 12:08 AM, Santi B=E9jar <santi@agolina.net> wro=
te:
> On Thu, Aug 12, 2010 at 10:19 PM, Elijah Newren <newren@gmail.com> wr=
ote:
>> Hi,
>>
>> Thanks for the review and comments!
>>
>> On Thu, Aug 12, 2010 at 7:34 AM, Santi B=E9jar <santi@agolina.net> w=
rote:
>> <snip>
>>> All this makes sense.
>>>
>>> But can you explain when it happens? One possibility is when you do=
n't
>>> fork from the tracking branch as in:
>>
>> That's one possibility. =A0Patch 1/2 in this thread contains testcas=
es
>> for two others. =A0Another possibility is having your patches get
>> upstream by some alternative route (e.g. pulling your changes to a
>> third machine, pushing from there, and then going back to your
>> original machine and trying to pull --rebase).
>
> I think this is commit message material.

I just want to add one thing, thanks for your great commit message.
Although the patch itself if 7 lines it is fantastic to have a commit
message explaining all the historical context and this level of
detail.

Thanks,
Santi

From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] branch: use $curr_branch_short more
Date: Sat, 31 Aug 2013 11:11:00 +0200
Message-ID: <5221B324.7020908@web.de>
References: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com> <1377899810-1818-7-git-send-email-felipe.contreras@gmail.com> <xmqq38pqwlyl.fsf@gitster.dls.corp.google.com> <5221A510.2020206@web.de> <CAMP44s1qyF70eSCM4L1Yr=U02AwFZ0TNqiDvag8Qdzzi9GS1Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 11:11:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFhDJ-0000li-UO
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 11:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824Ab3HaJLK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Aug 2013 05:11:10 -0400
Received: from mout.web.de ([212.227.15.3]:59935 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752305Ab3HaJLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 05:11:09 -0400
Received: from [192.168.2.102] ([79.253.149.114]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MC1VQ-1V6rVL0Azo-008oYy for <git@vger.kernel.org>;
 Sat, 31 Aug 2013 11:11:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <CAMP44s1qyF70eSCM4L1Yr=U02AwFZ0TNqiDvag8Qdzzi9GS1Mw@mail.gmail.com>
X-Provags-ID: V03:K0:NtIC80YzbOM/JiiMPT8sbNkERSlh7BoaL+3j6/Dr3z8ue8W9S30
 mhPl/l9IWM+V3u7zCgXw9gJOlMW7tCMtvgytqFVRaq5meM4Vgote+TJI33MmxSVTNXG7ijC
 aEY5F/NSZ4lm8YiOxucnMLBhc9b1duVJBX9Lo8uBQkRMQn3B0zcdmte/aveOUxtQn6Bf7C5
 tj/aBC9xYgq3WgqCewmKw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233512>

Am 31.08.2013 10:22, schrieb Felipe Contreras:
>> Subject: branch: use $curr_branch_short more
>
> Why? I don't think that summary explains the reason for being for thi=
s
> patch, also, it starts with branch: instead of pull:

You're right about "branch" vs. "pull".  I'll better go back to bed. ~_=
~

> Subject: pull: trivial simplification
>
> With that summary, people would have an easier time figuring out if
> they need to read more about the patch or not.

"trivial simplification" is too generic; we could have lots of them.  A=
=20
summary should describe the change.  Its low complexity can be derived=20
from it -- using an existing variable a bit more is not very exciting.

But I wouldn't call that patch trivial because its correctness depends=20
on code outside of its shown context.

The reason for the patch isn't mentioned explicitly.  Perhaps it should=
=20
be.  I felt that using something that's already there instead of=20
recreating it is motivation alone.

Ren=C3=A9

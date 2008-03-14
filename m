From: Wincent Colaiuta <win@wincent.com>
Subject: Re: About detached heads
Date: Fri, 14 Mar 2008 12:17:05 +0100
Message-ID: <E1DAC955-38CC-495B-9DCA-B25847EFF6C4@wincent.com>
References: <93c3eada0803140246k53408c74m21f9dc277857202d@mail.gmail.com> <9A4AC53D-BCFA-4BEE-BD53-AA7F29781454@wincent.com> <vpq1w6dvaxe.fsf@bauges.imag.fr>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: geoffrey.russell@gmail.com, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Mar 14 12:18:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja7vP-0003j4-CU
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 12:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388AbYCNLRb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Mar 2008 07:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752227AbYCNLRb
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 07:17:31 -0400
Received: from wincent.com ([72.3.236.74]:41784 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752053AbYCNLRa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Mar 2008 07:17:30 -0400
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m2EBHMd7004196;
	Fri, 14 Mar 2008 06:17:23 -0500
In-Reply-To: <vpq1w6dvaxe.fsf@bauges.imag.fr>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77208>

El 14/3/2008, a las 11:48, Matthieu Moy escribi=F3:

> Wincent Colaiuta <win@wincent.com> writes:
>
>> El 14/3/2008, a las 10:46, Geoff Russell escribi=F3:
>>
>>> This should be simple! I have a series of commits:
>>>
>>>          1---2---3---4---5
>>>
>>> I want to go back to 3 but not branch, so I want
>>>
>>>          1---2---3---4---5---3
>>
>> How about?
>>
>>  git cherry-pick the-sha-1-id-of-commit-3
>
> Correct me if I'm wrong, but I believe this will try to re-apply
> commit 3 (probably a no-op since commit 3 is already in the history,
> perhaps tons of conflicts if 4 and 5 touched the same pieces of code)=
=2E

I thought the OP was saying that 4 and 5 somehow undid the effect of 3 =
=20
and he wanted to reapply it. But he probably meant what you said, he =20
just wants to reset back to 3.

Wincent

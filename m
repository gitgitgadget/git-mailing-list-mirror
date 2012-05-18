From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2] git-svn: clarify the referent of dcommit's optional argument
Date: Fri, 18 May 2012 10:27:46 +0200
Message-ID: <87396xj3lp.fsf@thomas.inf.ethz.ch>
References: <1336978405-17943-1-git-send-email-jon.seymour@gmail.com>
	<CAH3Anroxjn6sCBYa71Y-H1AvitiFn=dRUapGxgQ1Nu6=Tf03Uw@mail.gmail.com>
	<7vr4umivr2.fsf@alter.siamese.dyndns.org>
	<CAH3Anrr11eLiHkasdLxAWD9--B6QNq5-kFfO+Xg1F5xTDS56zg@mail.gmail.com>
	<7vliktfoza.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Jon Seymour <jon.seymour@gmail.com>, <git@vger.kernel.org>,
	<normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 18 10:28:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVIY6-0004j6-NY
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 10:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761463Ab2ERI1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 04:27:54 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:20955 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760123Ab2ERI1v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 04:27:51 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 18 May
 2012 10:27:48 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (217.235.93.211) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 18 May
 2012 10:27:49 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [217.235.93.211]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197940>

Junio C Hamano <gitster@pobox.com> writes:

> Jon Seymour <jon.seymour@gmail.com> writes:
>
>> On Tue, May 15, 2012 at 2:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> The only reason why the original is not ordered that way, as far as I can
>>> tell, is because "It is recommended that" was part of an existing paragraph
>>> when dd31da2 (git-svn: allow dcommit to take an alternate head, 2006-12-12)
>>> added "An optional ...", so it was tucked after existing paragraph without
>>> reading the resulting whole to see if "at the very end" was the best place.
>>
>> Re-reading this, I don't think the advice:
>>
>>     "It is recommended that you run 'git svn' fetch and rebase (not
>>     pull or merge) your commits against the latest changes in the =C2=A0SVN
>>     repository."
>>
>> really belongs in the description of dcommit at all.
>
> I tend to agree.  Opinions from git-svn experts?

I agree that this is not dcommit-specific advice.  Perhaps there should
be a longer section that explains in detail what is rebased how and thus
what the limitations of dcommit are.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch

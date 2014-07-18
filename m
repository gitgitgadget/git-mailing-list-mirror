From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH RFC v2 00/19] Enable options --signoff, --reset-author for pick, reword
Date: Fri, 18 Jul 2014 14:10:54 +0200
Message-ID: <87zjg63m0h.fsf@thomasrast.ch>
References: <53A258D2.7080806@gmail.com>
	<cover.1404323078.git.bafain@gmail.com>
	<xmqqha2r8trc.fsf@gitster.dls.corp.google.com>
	<53BD6917.7070700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 14:19:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X878D-0002xk-6U
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 14:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761581AbaGRMTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 08:19:16 -0400
Received: from ip1.thgersdorf.net ([148.251.9.194]:44546 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761467AbaGRMTO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 08:19:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id A34384D6572;
	Fri, 18 Jul 2014 14:10:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id AL1x07ouLdTF; Fri, 18 Jul 2014 14:10:55 +0200 (CEST)
Received: from hexa.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id A202C4D65EA;
	Fri, 18 Jul 2014 14:10:54 +0200 (CEST)
In-Reply-To: <53BD6917.7070700@gmail.com> (Fabian Ruch's message of "Wed, 09
	Jul 2014 18:08:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253814>

Fabian Ruch <bafain@gmail.com> writes:

> On 07/08/2014 10:45 PM, Junio C Hamano wrote:
>> Fabian Ruch <bafain@gmail.com> writes:
>>> Fabian Ruch (19):
>>>   rebase -i: Failed reword prints redundant error message
>>>   rebase -i: reword complains about empty commit despite --keep-empty
>>>   rebase -i: reword executes pre-commit hook on interim commit
>>>   rebase -i: Teach do_pick the option --edit
>>>   rebase -i: Implement reword in terms of do_pick
>>>   rebase -i: Stop on root commits with empty log messages
>>>   rebase -i: The replay of root commits is not shown with --verbose
>>>   rebase -i: Root commits are replayed with an unnecessary option
>>>   rebase -i: Commit only once when rewriting picks
>>>   rebase -i: Do not die in do_pick
>>>   rebase -i: Teach do_pick the option --amend
>>>   rebase -i: Teach do_pick the option --file
>>>   rebase -i: Prepare for squash in terms of do_pick --amend
>>>   rebase -i: Implement squash in terms of do_pick
>>>   rebase -i: Explicitly distinguish replay commands and exec tasks
>>>   rebase -i: Parse to-do list command line options
>>>   rebase -i: Teach do_pick the option --reset-author
>>>   rebase -i: Teach do_pick the option --signoff
>>>   rebase -i: Enable options --signoff, --reset-author for pick, reword
>> 
>> After "rebase -i:", some begin with lowercase and many begin with
>> capital, which makes the short-log output look distracting.
>
> The ones that begin with lower-case letters are the ones that begin with
> the command name "reword". All first lines are typed in lower case now.

You could spell it 'reword' (with the quotes), which also disambiguates
the command from the verb.

-- 
Thomas Rast
tr@thomasrast.ch

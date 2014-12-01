From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [BUG] Documentation: git log: --exit-code undocumented?
Date: Mon, 01 Dec 2014 19:43:24 +0300
Message-ID: <87oarngw2b.fsf@osv.gnss.ru>
References: <87zjb78u7g.fsf@osv.gnss.ru>
	<xmqqegsjqqox.fsf@gitster.dls.corp.google.com>
	<87wq6bgwl6.fsf@osv.gnss.ru>
	<xmqqa937qqb7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 17:43:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvU4R-000249-NA
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 17:43:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107AbaLAQn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 11:43:27 -0500
Received: from mail.javad.com ([54.86.164.124]:33931 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752885AbaLAQn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 11:43:27 -0500
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 2740D6187A;
	Mon,  1 Dec 2014 16:43:26 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <sorganov@gmail.com>)
	id 1XvU4K-0006UJ-BH; Mon, 01 Dec 2014 19:43:24 +0300
In-Reply-To: <xmqqa937qqb7.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 01 Dec 2014 08:37:32 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260493>

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Sergey Organov <sorganov@gmail.com> writes:
>>>
>>>> Hello,
>>>>
>>>> $ git help log | grep exit-code
>>>>            problems are found. Not compatible with --exit-code.
>>>> $
>>>>
>>>> What --exit-code does in "git log"?
>>>
>>> It doesn't.  That is why it is not listed.
>>
>> Then, how can --check possibly interfer with it?
>
> The description is shared with "git diff" and friends, which is
> invoked via "git log -p".  As "log" does not give the exit code
> of individual "diff-tree" invocation for each commit, --exit-code
> option is irrelevant.

Do you agree there is some minor problem here? First, "git log"
silently eats the --exit-code option that does nothing. Next, git-log
manual page doesn't include --exit-log description while refers to it
elsewhere. What's proposed resulution?

-- 
Sergey.

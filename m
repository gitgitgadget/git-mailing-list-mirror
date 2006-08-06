From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/6] gitweb: Further refactoring
Date: Sun, 06 Aug 2006 12:52:58 +0200
Organization: At home
Message-ID: <eb4hkp$m0o$1@sea.gmane.org>
References: <200608060206.49086.jnareb@gmail.com> <7vmzai89o1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Aug 06 12:52:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9gFC-0007On-6V
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 12:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWHFKw1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 06:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWHFKw1
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 06:52:27 -0400
Received: from main.gmane.org ([80.91.229.2]:60090 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751349AbWHFKw1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Aug 2006 06:52:27 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G9gEx-0007MS-7U
	for git@vger.kernel.org; Sun, 06 Aug 2006 12:52:15 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 06 Aug 2006 12:52:15 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 06 Aug 2006 12:52:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24973>

Junio C Hamano wrote:

> The earlier 9-series looked fine, so I intend to apply them all
> to "next".  However, they were all tab damaged and it was very
> painful to fix up the patch.

I'm sorry for that. As far as I checked, KNode (news reader which I used for
sending 9-(micro)series) preserves tabs when attaching file inline. I guess
that GMane news-to-mail gateway might munge whitespace. I won't use KNode
to send patches, then.

By the way, can anyone tell me how to setup git-send-email to send email via
GMail (authenticated SMTP, via STARTTLS/SSL, on ports 25 or 465 or 587)?

> This series, PATCH 1/5 (6?) looks fine (it is a bugfix for
> git_diff_print), but among others, one of them had a seriously
> fishy preimage (e.g. as you can see in "next", I haven't
> accepted the function rename patch but 3/6 talks about
> format_mark_referencing), and at that point my patience ran out.

I _have_ notified that this 6-series is on top of previous series,
namely '[PATCH 7/5] Merge changes in "split patch 1" series' patch.

But I try to redo not accepted changes on top of next, and put
"gitweb: Great subroutines renaming" on top of series. (BTW. this 
is simple search'n'replace on subroutine names... well, perhaps after
1.4.2...).

[...]
> Please note that I am primarily concentrating on polishing what
> is in "master" to finish 1.4.2 for now, so I might have missed
> breakage in these gitweb patches that I queued for "next".

I'm trying to check my gitweb patches, by checking the output of all
possible actions, althought I think it doesn't encompass all the cases...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

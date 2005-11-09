From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Wed, 09 Nov 2005 15:14:21 -0800
Message-ID: <7v3bm59zxu.fsf@assigned-by-dhcp.cox.net>
References: <43348086.2040006@zytor.com> <20050924011833.GJ10255@pasky.or.cz>
	<7vvf0r6x97.fsf@assigned-by-dhcp.cox.net>
	<20050924125001.GB25069@pasky.or.cz>
	<7virwqwd3z.fsf@assigned-by-dhcp.cox.net>
	<20051109223303.GG30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 00:14:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZz98-0002pF-AB
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 00:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbVKIXOX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 18:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbVKIXOX
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 18:14:23 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:5561 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751570AbVKIXOX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 18:14:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051109231400.CSAQ16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Nov 2005 18:14:00 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051109223303.GG30496@pasky.or.cz> (Petr Baudis's message of
	"Wed, 9 Nov 2005 23:33:04 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11434>

Petr Baudis <pasky@suse.cz> writes:

> ...; is it safe to assume that the
> default template post-update hook shipped with GIT will be
> good-to-be-autoenabled on public repositories 

I do not think that is an unreasonable assumption.  After all,
sample hooks are there to help people setting up common usage
patterns, not to show off flashy but irrelevant-to-the-real-world-needs
features ;-).

Please yell loudly when somebody posts a patch or brings up a
proposal to break that assumption in the future.

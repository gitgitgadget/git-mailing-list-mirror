From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] One Git To Rule Them All
Date: Tue, 31 May 2005 23:21:00 -0700
Message-ID: <7vis0yr41f.fsf@assigned-by-dhcp.cox.net>
References: <20050601055833.GA14231@port.evillabs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 08:19:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdMYY-000318-N3
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 08:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVFAGVH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 02:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVFAGVH
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 02:21:07 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:6558 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261290AbVFAGVC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2005 02:21:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050601062101.RIMI8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Jun 2005 02:21:01 -0400
To: Jason McMullan <jason.mcmullan@timesys.com>
In-Reply-To: <20050601055833.GA14231@port.evillabs.net> (Jason McMullan's
 message of "Wed, 1 Jun 2005 01:58:33 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In my opinion, this is going backwards.

I think we had this discussion long time ago on the list, and
instead of using cvs/svn style of "cmd subcmd" syntax, the
consensus back then was that using "cmd-" prefix without spaces
is easier for making TAB completion to work (you do not have to
muck with command specific rules in the readline configuration),
and this is especially helpful for people who ends up using the
bare Plumbing. IIUC, the same reason is behind cg-* command set.

Having said that, for many people who do not wish to use the
bare Plumbing interactively, installing git-* commands in, say,
$(libexec)/git/ might be a more appropriate option.  But we have
to remember there are people who uses the bare Plumbing
interatively.  I think Jeff Garzik said he does not use Cogito,
and I suspect Linus does not either.



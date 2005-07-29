From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] add "-f" option to git-commit-script to force commit withoutchanges
Date: Thu, 28 Jul 2005 19:24:57 -0700
Message-ID: <7vslxypcw6.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0507281646340.25783@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 04:25:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyKYv-0008U9-AV
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 04:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbVG2CZM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 22:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbVG2CZF
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 22:25:05 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:48795 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S262262AbVG2CZB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2005 22:25:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050729022452.OPFK1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Jul 2005 22:24:52 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

While I agree there should be a graceful way to go back to the
original head from a failed merge situation, I do not think
"committing the current HEAD" is the right model for the end
user to think about it.

Wouldn't using "checkout -f" to revert to the version you would
want to go back work as expected?

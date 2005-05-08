From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add exclude file support to cg-status
Date: Sun, 08 May 2005 16:28:44 -0700
Message-ID: <7vfywx2t77.fsf@assigned-by-dhcp.cox.net>
References: <20050502171042.A24299@cox.net>
	<20050508015016.GL9495@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Porter <mporter@kernel.crashing.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 01:22:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUv6p-0000ve-G2
	for gcvg-git@gmane.org; Mon, 09 May 2005 01:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263006AbVEHX3J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 19:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbVEHX3J
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 19:29:09 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:43238 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S263006AbVEHX2w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2005 19:28:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050508232844.KQJ7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 8 May 2005 19:28:44 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050508015016.GL9495@pasky.ji.cz> (Petr Baudis's message of
 "Sun, 8 May 2005 03:50:16 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> ... since I *don't* think you want to share this. The very
PB> fact it is in the .git/ directory implies here that these
PB> are your local exclude patterns which are likely
PB> temporary...

Is it really the case?  I recall that Linux kernel started
shipping with the standard dontdiff file for everybody's use
some time ago, after enough people wanted it included in the
upstream release.  Maybe you would want to read from both?

PB> The fact that we have no support for version-tracked exclude file can't
PB> stop me! ;-)

What darcs folks do is that they have a per-tree configuration
(kept in ./_darcs, which is similar to our ./.git) that says
which file is the exclude list, and by setting configuration
item to point at a file which _is_ version controlled they can
share the exclude file.


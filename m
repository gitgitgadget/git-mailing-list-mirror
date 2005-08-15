From: Junio C Hamano <junkio@cox.net>
Subject: Screwed up AUTHOR field for two commits.
Date: Mon, 15 Aug 2005 16:07:00 -0700
Message-ID: <7vacjix0iz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 01:08:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4o2x-0001FO-Ee
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 01:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbVHOXHI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 19:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbVHOXHH
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 19:07:07 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:1949 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932552AbVHOXHG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 19:07:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050815230701.FZUZ3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 Aug 2005 19:07:01 -0400
To: Amos Waterland <apw@rossby.metr.ou.edu>,
	Ryan Anderson <ryan@michonline.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The topmost couple of commits in the "master" branch made from
your patches are incorrectly attributed to me.

What happened was that I stumbled upon a merge conflict during
git-rebase, and ended up hand committing these two without
carrying the authorship information forward from the original
commits.  This usually does not happen because I always use JIT
tools for rebasing, but this time I was trying to stay within
the set of core GIT barebone Porcelain.

I apologize for the screwup.

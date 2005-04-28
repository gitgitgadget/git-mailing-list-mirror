From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] add a diff-files command
Date: Thu, 28 Apr 2005 10:16:08 -0700
Message-ID: <7vk6mm9607.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.62.0504271701080.14033@localhost.localdomain>
	<7vr7gvevpv.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.62.0504272031330.14033@localhost.localdomain>
	<7vr7gu97xq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.62.0504281238130.14033@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 19:11:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRCXB-0003lW-8k
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 19:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbVD1RQN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 13:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbVD1RQN
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 13:16:13 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:52455 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262176AbVD1RQM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 13:16:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050428171609.GZFE26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Apr 2005 13:16:09 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.62.0504281238130.14033@localhost.localdomain> (Nicolas
 Pitre's message of "Thu, 28 Apr 2005 12:56:43 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "NP" == Nicolas Pitre <nico@cam.org> writes:

NP> ...  And yesterday I realized that the (currently unimplemented) 
NP> --ignore switch to show-files, combined with the exclusion pattern list, 
NP> whould be more logical than teaching show-diff (which I still think is a 
NP> misnamer in the context of the other diff tools) about files unknown to 
NP> the cache.  The patch to show-files is also much smaller and logical.

I agree wholeheartedly with both counts.  (1) Linus and I
discussed briefly about renaming show-diff to diff-files but it
is on hold, waiting for a big wholesale rename.  (2) the logical
place for the -X and -x is "show-files --ignore".


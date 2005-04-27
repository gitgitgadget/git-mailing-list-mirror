From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make -s flag to show-diff a no-op.
Date: Wed, 27 Apr 2005 15:35:51 -0700
Message-ID: <7v64y7etko.fsf@assigned-by-dhcp.cox.net>
References: <7vfyxbeuwt.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504271520150.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 00:36:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQv7Y-000677-2z
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 00:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbVD0WjE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 18:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVD0Wi5
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 18:38:57 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:51111 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262054AbVD0Wfz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 18:35:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050427223550.KEOR19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 27 Apr 2005 18:35:50 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504271520150.18901@ppc970.osdl.org> (Linus
 Torvalds's message of "Wed, 27 Apr 2005 15:20:45 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> I also wonder whether "-p" should turn on recursion by default (for all 
LT> the tools). "-p" without "-r" doesn't really seem to make much sense, does 
LT> it?

When I know which path I am interested in,

    $ diff-tree -p <tree-1> <tree-2> ls-tree.c

would still get the benefit of not descending down into ppc and
mozilla-sha1 subdirectories, if I am not mistaken.

Think of the kernel sources, and I would say leaving the option
of not recursing down is a good thing.


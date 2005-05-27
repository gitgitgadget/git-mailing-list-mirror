From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 00/12] Diff updates
Date: Fri, 27 May 2005 15:43:58 -0700
Message-ID: <7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 28 00:42:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbnWn-00010X-8N
	for gcvg-git@gmane.org; Sat, 28 May 2005 00:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbVE0WoH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 18:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbVE0WoH
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 18:44:07 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:9898 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S262623AbVE0WoE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 18:44:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050527224359.YKBY20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 27 May 2005 18:43:59 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org> (Linus
 Torvalds's message of "Fri, 27 May 2005 08:56:35 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This series consists of the following 12 patches.  Most of them
are bugfixes and cleanups.  The last one is somewhat iffy,
although it does not break things, and lies somewhere between a
request for inclusion and a request for comments.

    [PATCH 01/12] Fix math thinko in similarity estimator.
    [PATCH 02/12] Introduce diff_free_filepair() funcion.
    [PATCH 03/12] Make pathspec only care about the detination tree.
    [PATCH 04/12] Remove unused rank field from diff_core structure.
    [PATCH 05/12] Do not expose internal scaling to diff-helper.
    [PATCH 06/12] Remove final newline from the value of xfrm_msg variable.
    [PATCH 07/12] Clean up diff_setup() to make it more extensible.
    [PATCH 08/12] Remove a function not used anymore.
    [PATCH 09/12] Add --pickaxe-all to diff-* brothers.
    [PATCH 10/12] Fix the way diffcore-rename records unremoved source.
    [PATCH 11/12] Move pathspec to the beginning of the diffcore chain.
    [PATCH 12/12] Optimize diff-tree -[CM] --stdin



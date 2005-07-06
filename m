From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 0/13] Patch Series
Date: Thu, 07 Jul 2005 02:39:33 +1000
Message-ID: <20050706163933.9791.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Wed Jul 06 18:57:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqDCS-0007UL-IY
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 18:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbVGFQzF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 12:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVGFQxO
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 12:53:14 -0400
Received: from 203-217-64-103.dyn.iinet.net.au ([203.217.64.103]:4993 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262340AbVGFQjn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 12:39:43 -0400
Received: (qmail 9801 invoked by uid 500); 6 Jul 2005 16:39:33 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


I have re-issued the patches I have created in the last day after checking
that they apply correctly when applied in this order to the
current Linus HEAD (b43d44779bf98977b211256f936d0edda8a9625a)

Introduction of --topo-order and tidy up of rev-list.c

[PATCH 1/13] Temporary fixup to rev-list.c to restore expected order of arguments presented to --merge-order sort.
[PATCH 2/13] Swap order of insert_by_date arguments
[PATCH 3/13] Introduce struct rev_list_fns to rev-list.c to reduce amount of conditional processing.
[PATCH 4/13] Add a topological sort procedure to commit.c [rev 4]
[PATCH 5/13] Introduce --topo-order switch to git-rev-list
[PATCH 6/13] Change gitk so that it uses --topo-order rather than --merge-order
[PATCH 7/13] Tidy up - slight simplification of rev-list.c
[PATCH 8/13] Fix handling of duplicates by topological order.

Tidy up and extension of t6xxx test cases

[PATCH 9/13] Factor out useful test case infrastructure from t/t6001... into t/t6000-lib.sh
[PATCH 10/13] Introduce unit tests for git-rev-list --bisect
[PATCH 11/13] Change the sed seperator in t/t6000-lib.sh.

Test for and fix of recently discovered --merge-order bug

[PATCH 12/13] Add a t/t6001 test case for a --merge-order bug
[PATCH 13/13] Fixes a problem with --merge-order A B (A is linear descendent of a merge B)

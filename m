From: Zach Welch <zw@superlucidity.net>
Subject: [PATCH 0/3] init-db.c cleanup and fixes
Date: Tue, 19 Apr 2005 21:28:39 -0700
Message-ID: <mailbox-1242-1113971319-958842@spoon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: torvalds@osdl.org
X-From: git-owner@vger.kernel.org Wed Apr 20 06:24:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO6lR-0007C5-II
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 06:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVDTE2n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 00:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVDTE2n
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 00:28:43 -0400
Received: from guft.superlucidity.net ([63.224.205.130]:20623 "EHLO
	mail.guft.org") by vger.kernel.org with ESMTP id S261338AbVDTE2l
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 00:28:41 -0400
Received: (qmail 1247 invoked by uid 5006); 19 Apr 2005 21:28:39 -0700
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus,

I see you pulled the first two patches of my last series into your tree, 
so I know I had your attention briefly. I wanted to see what I can do to
help the rest of the changes get in, so....

I realized last night as I was going to bed that the third patch might 
not be accepted because it changes the behaviour slightly, nevermind that 
they were - by comparison with today's alternative - plain ugly.  

For what it's worth, init-db is practically useless for my package 
without the second change in this series.  Currently, I've implemented 
init-db in pure perl, but I'd like to use init-db.

As such, I started from scratch, and came up with a much simpler 
series of patches.  Please continue to ignore the previous series, but
consider these new patches in their stead.

New GIT_FILE_DIRECTORY patches will follow seperately.

Cheers,

Zach Welch
Superlucidity Services

These patches were based off commit 4e1778c8ceeaea340a2a7f62fc65736da327ec05.

There are 3 patches in this series:
        [PATCH 1/3] init-db.c: cleanup comments
        [PATCH 2/3] init-db.c: normalize env var handling.
        [PATCH 3/3] init-db.c: create and use safe_create_dir helper

From: "Sean" <seanlkml@sympatico.ca>
Subject: [RFC] adding merge-node to parent lines in a commit
Date: Sun, 15 May 2005 17:22:27 -0400 (EDT)
Message-ID: <1282.10.10.10.24.1116192147.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun May 15 23:23:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXQZ0-0000Ey-1a
	for gcvg-git@gmane.org; Sun, 15 May 2005 23:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVEOVWd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 17:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVEOVWc
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 17:22:32 -0400
Received: from simmts8.bellnexxia.net ([206.47.199.166]:5319 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261248AbVEOVW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 17:22:28 -0400
Received: from linux1 ([69.156.111.46]) by simmts8-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050515212227.YPYI26867.simmts8-srv.bellnexxia.net@linux1>
          for <git@vger.kernel.org>; Sun, 15 May 2005 17:22:27 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4FLMRJx008452
	for <git@vger.kernel.org>; Sun, 15 May 2005 17:22:27 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sun, 15 May 2005 17:22:27 -0400 (EDT)
To: git@vger.kernel.org
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
References: 
In-Reply-To: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Just a random thought presented for flamage...  Would adding the merge
node to each "parent" line in merge nodes be workable?

parent  SHA1-PARENT  SHA1-MERGE-NODE

It's not exactly clear cut I guess, especially in the case of multi-parent
merges, but it would make descending the history slightly easier.   It
would let you look at any merge, and know exactly which commits were
associated with that merge, without needing any repo-id or time
information.  This information is needed at the time of merge anyway, so
recording it rather than leaving it to be calculated later makes some
sense.  Comments?

Cheers,
Sean





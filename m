From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH 0/5] More ref logging
Date: Fri, 19 May 2006 05:14:56 -0400
Message-ID: <20060519091456.GH22257@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 11:15:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fh14e-00081H-5Y
	for gcvg-git@gmane.org; Fri, 19 May 2006 11:15:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWESJPD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 05:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWESJPD
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 05:15:03 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:13003 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751226AbWESJPC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 05:15:02 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Fh14U-0005gB-4o; Fri, 19 May 2006 05:14:58 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 370C5212691; Fri, 19 May 2006 05:14:56 -0400 (EDT)
To: Junio Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20337>

These are on top of the other five I just sent:

* [PATCH 1/5] Correct force_write bug in refs.c

	Yea there was a bug in the last bug fix.  Now we
	really don't write the ref unless we need to.

* [PATCH 2/5] Change order of -m option to update-ref.

	Minor documentation nit noticed by Junio.

* [PATCH 3/5] Include ref log detail in commit, reset, etc.

	Enhance some core tools to use the new '-m' switch with
	update-ref.  Trivial but requires the new update-ref.

* [PATCH 4/5] Create/delete branch ref logs.

	This was discussed on #git earlier this morning.
	Automatically create the ref log if -l is given when creating
	a branch and delete the log when deleting the branch.

* [PATCH 5/5] Enable ref log creation in git checkout -b.

	Fix git checkout -b to behave like git branch.

-- 
Shawn.

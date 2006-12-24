From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH 0/7] Various sp/mmap improvemnts
Date: Sun, 24 Dec 2006 00:54:27 -0500
Message-ID: <20061224055427.GD7443@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 24 06:54:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyMJk-000248-Un
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 06:54:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113AbWLXFyc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 00:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754141AbWLXFyc
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 00:54:32 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53998 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754113AbWLXFyc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 00:54:32 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GyMJa-00010g-Ni; Sun, 24 Dec 2006 00:54:30 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7394020FB65; Sun, 24 Dec 2006 00:54:28 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35345>

Small improvements on top of my sp/mmap branch:

[PATCH 1/7] Rename gitfakemmap to git_mmap. 
[PATCH 2/7] Switch git_mmap to use pread.   

	These two might apply right to master as-is and aren't
	necessarily part of my sp/mmap topic.

[PATCH 3/7] Ensure packed_git.next is initia...
[PATCH 4/7] Default core.packdGitWindowSize ...
[PATCH 5/7] Don't exit successfully on EPIPE...
[PATCH 6/7] Release pack windows before repo...
[PATCH 7/7] Replace mmap with xmmap, better ...

	These apply on top of my sp/mmap topic and some also assume
	the 1/7,2/7 patches above to git_mmap were already applied.


1/7-5/7 were suggested by comments on the mailing list. Two I just
forgot to implement (6/7, 7/7) prior to submitting the original
series.

-- 
Shawn.

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: fast-import maint fixes
Date: Thu, 24 May 2007 00:55:42 -0400
Message-ID: <20070524045542.GI28023@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Simon Hausmann <simon@lst.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 06:55:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hr5Mc-0005fd-Gc
	for gcvg-git@gmane.org; Thu, 24 May 2007 06:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756721AbXEXEzs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 00:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758546AbXEXEzs
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 00:55:48 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55664 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756721AbXEXEzs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 00:55:48 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hr5MW-0007nT-Ud; Thu, 24 May 2007 00:55:45 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2134620FBAE; Thu, 24 May 2007 00:55:43 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48222>

The following changes since commit 7ca055f75ad7ffd2251d4b607fbb86d7bcfd77c7:
  Stephan Springl (1):
        Use git-for-each-ref to check whether the origin branch exists.

are available in the git repository at:

  repo.or.cz:/srv/git/git/fastimport.git maint

Shawn O. Pearce (2):
      Refactor fast-import branch creation from existing commit
      Fix possible coredump with fast-import --import-marks

Simon Hausmann (2):
      fast-import: Fix uninitialized variable
      fast-import: Fix crash when referencing already existing objects

 fast-import.c          |   67 ++++++++++++++++++++++++++---------------------
 t/t9300-fast-import.sh |   29 ++++++++++++++++++++
 2 files changed, 66 insertions(+), 30 deletions(-)


These are built on top of Junio's maint, and should be merged there,
as they fix coredumps when documented features are actually used.

:-(

-- 
Shawn.

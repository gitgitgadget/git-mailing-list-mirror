From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Pushing into a repository with working directory?
Date: Mon, 1 Jan 2007 23:51:08 -0500
Message-ID: <20070102045108.GC27690@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 02 05:51:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1bcR-0003s3-9E
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 05:51:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755260AbXABEvN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 23:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755261AbXABEvM
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 23:51:12 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46065 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755260AbXABEvM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 23:51:12 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H1bc2-0004Fd-0x
	for git@vger.kernel.org; Mon, 01 Jan 2007 23:50:58 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C225520FB65; Mon,  1 Jan 2007 23:51:08 -0500 (EST)
To: git@vger.kernel.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35770>

So tonight on #git I think I answered for the 10th time why the
working directory doesn't update after a push to its associated
repository.

We all know its somewhat dangerous to push into the current branch
of a working directory, especially if that working directory contains
uncommitted changes, as HEAD no longer matches the index.

But we all also know its incredibly useful to be able to push into
a repository with a working directory, so we certainly don't want
to disallow it entirely.

What about refusing a push to the current branch (branch listed in
$GIT_DIR/HEAD) and the repository appears to have a working directory
(is_bare_git_dir is false)?

-- 
Shawn.

From: Shawn Pearce <spearce@spearce.org>
Subject: Why git-merge-resolve in git-am?
Date: Wed, 27 Dec 2006 20:45:25 -0500
Message-ID: <20061228014525.GC16612@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Dec 28 02:45:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzkKp-0003Kc-PC
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 02:45:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWL1Bp3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 20:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWL1Bp3
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 20:45:29 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37391 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964859AbWL1Bp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 20:45:28 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GzkKh-0004i7-Jz
	for git@vger.kernel.org; Wed, 27 Dec 2006 20:45:23 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 673EC20FB65; Wed, 27 Dec 2006 20:45:25 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35506>

Why does git-am use git-merge-resolve while git-rebase -m uses
git-merge-recursive?

Can we just change git-am to use git-merge-recursive instead?
For one thing its faster, for another it supports the GITHEAD_*
feature for naming the hunks in a conflict.

-- 
Shawn.

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: bash completion updates
Date: Thu, 24 May 2007 02:13:11 -0400
Message-ID: <20070524061311.GJ28023@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 08:13:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hr6Zd-00083t-O6
	for gcvg-git@gmane.org; Thu, 24 May 2007 08:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757989AbXEXGNQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 02:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758048AbXEXGNQ
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 02:13:16 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56868 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757989AbXEXGNP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 02:13:15 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hr6ZV-0001RH-9C; Thu, 24 May 2007 02:13:13 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A79A320FBAE; Thu, 24 May 2007 02:13:11 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48223>

The following changes since commit aba170cdb4874b72dd619e6f7bbc13c33295f831:
  Junio C Hamano (1):
        GIT 1.5.2

are available in the git repository at:

  repo.or.cz:/srv/git/git/fastimport.git master

Jonas Fonseca (1):
      Update bash completion to ignore some more plumbing commands

Shawn O. Pearce (7):
      Hide the plumbing diff-{files,index,tree} from bash completion
      Teach bash completion about git-shortlog
      Remove a duplicate --not option in bash completion
      Update bash completion header documentation
      Teach bash completion about 'git remote update'
      Teach bash completion about recent log long options
      Update bash completion for git-config options

 contrib/completion/git-completion.bash |   81 ++++++++++++++++++++++++++++----
 1 files changed, 71 insertions(+), 10 deletions(-)


These are relative to the 1.5.2 tip commit, so they should be able to
go just about anywhere.  I consider them all to be new features, but
they should really be suitable for inclusion in a 1.5.2.1 release.

Note that my master branch doesn't contain my maint branch; I'm
expecting you to merge things up on your end.  ;-)

-- 
Shawn.

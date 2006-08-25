From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 5/7] git(7): put the synopsis in a verse style paragraph
Date: Fri, 25 Aug 2006 03:05:48 +0200
Message-ID: <20060825010548.GF4069@diku.dk>
References: <20060818084545.GB4717@diku.dk> <7virkqbcq3.fsf@assigned-by-dhcp.cox.net> <20060825005655.GB4069@diku.dk> <20060825005820.GC4069@diku.dk> <20060825010149.GD4069@diku.dk> <20060825010458.GE4069@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 25 03:06:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGQ9U-0005wS-9H
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 03:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422810AbWHYBGI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 21:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422809AbWHYBGH
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 21:06:07 -0400
Received: from [130.225.96.91] ([130.225.96.91]:27568 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1422808AbWHYBFw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Aug 2006 21:05:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id ED83577007E;
	Fri, 25 Aug 2006 03:05:49 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26105-20; Fri, 25 Aug 2006 03:05:48 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id C49BF77007C;
	Fri, 25 Aug 2006 03:05:48 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id A0B4B6DF88D; Fri, 25 Aug 2006 03:04:30 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id ADCEE629FB; Fri, 25 Aug 2006 03:05:48 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060825010458.GE4069@diku.dk>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25988>

... so it wraps properly in small terminals.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 Documentation/git.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 3de5fa9..a9c87e3 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -8,8 +8,9 @@ git - the stupid content tracker
 
 SYNOPSIS
 --------
+[verse]
 'git' [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate]
-	[--bare] [--git-dir=GIT_DIR] [--help] COMMAND [ARGS]
+    [--bare] [--git-dir=GIT_DIR] [--help] COMMAND [ARGS]
 
 DESCRIPTION
 -----------
-- 
1.4.2.GIT

-- 
Jonas Fonseca

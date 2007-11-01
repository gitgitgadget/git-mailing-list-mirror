From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH] git-rev-list.txt: rev stands for revision, not reverse.
Date: Thu, 1 Nov 2007 09:45:53 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071101084552.GA4934@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 09:46:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InVgp-0007XX-GJ
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 09:46:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753648AbXKAIp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 04:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753763AbXKAIp4
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 04:45:56 -0400
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:50930 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554AbXKAIpz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 04:45:55 -0400
Received: from localhost.localdomain (xdsl-87-78-70-152.netcologne.de [87.78.70.152])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id D826440000749;
	Thu,  1 Nov 2007 09:45:53 +0100 (CET)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1InVgX-0001Pd-3b; Thu, 01 Nov 2007 09:45:53 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62929>

Mention revs, revisions as aliases for commit objects,
to clarify that rev-list is not an abbreviation for
listing in reverse order, but for listing revisions.
---
Yes, believe it or not, but I stumbled over the synopsis

| git-rev-list - Lists commit objects in reverse chronological order

asking myself whether rev could possibly mean "reverse".
I hope this helps avoid this pitfall for others.

Cheers,
Ralf

 Documentation/git-rev-list.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 4852804..8afe34b 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -44,9 +44,9 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Lists commit objects in reverse chronological order starting at the
-given commit(s), taking ancestry relationship into account.  This is
-useful to produce human-readable log output.
+Lists commit objects (revs, revisions) in reverse chronological order
+starting at the given commit(s), taking ancestry relationship into
+account.  This is useful to produce human-readable log output.
 
 Commits which are stated with a preceding '{caret}' cause listing to
 stop at that point. Their parents are implied. Thus the following
-- 
1.5.3.3.g34c6d

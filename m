From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH 2/6] Fix wording in push definition.
Date: Tue, 9 Oct 2007 23:01:05 +0200
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071009210105.GD31317@ins.uni-bonn.de>
References: <20071009205755.GB31317@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 23:34:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfMiF-0001Kc-6I
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 23:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755055AbXJIVdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 17:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755140AbXJIVdt
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 17:33:49 -0400
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:60279 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754903AbXJIVdr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 17:33:47 -0400
Received: from localhost.localdomain (xdsl-87-78-163-242.netcologne.de [87.78.163.242])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 6F0E64000073A
	for <git@vger.kernel.org>; Tue,  9 Oct 2007 23:01:43 +0200 (CEST)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1IfMCP-0000mM-PH
	for git@vger.kernel.org; Tue, 09 Oct 2007 23:01:05 +0200
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071009205755.GB31317@ins.uni-bonn.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60444>

Make the definition of push in the glossary readable.
---
 Documentation/glossary.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
index d99fa19..5645177 100644
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -301,8 +301,8 @@ This commit is referred to as a "merge commit", or sometimes just a
 [[def_push]]push::
 	Pushing a <<def_branch,branch>> means to get the branch's
 	<<def_head_ref,head ref>> from a remote <<def_repository,repository>>,
-	find out if it is an ancestor to the branch's local
-	head ref is a direct, and in that case, putting all
+	find out if it is a direct ancestor to the branch's local
+	head ref, and in that case, putting all
 	objects, which are <<def_reachable,reachable>> from the local
 	head ref, and which are missing from the remote
 	repository, into the remote
-- 
1.5.3.3.g34c6d

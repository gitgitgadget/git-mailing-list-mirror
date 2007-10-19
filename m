From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH] gitk.txt: Fix markup.
Date: Fri, 19 Oct 2007 19:24:43 +0200
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071019172443.GC9906@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 19 19:26:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iivbo-0007GB-Pv
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 19:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935834AbXJSRYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 13:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935876AbXJSRYs
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 13:24:48 -0400
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:48387 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935842AbXJSRYq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 13:24:46 -0400
Received: from localhost.localdomain (xdsl-87-78-67-237.netcologne.de [87.78.67.237])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 3A0A3400009FC
	for <git@vger.kernel.org>; Fri, 19 Oct 2007 19:24:44 +0200 (CEST)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1IivaV-0002aS-O1
	for git@vger.kernel.org; Fri, 19 Oct 2007 19:24:43 +0200
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61736>

For the manpage, avoid generating an em dash in code.

Signed-off-by: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
---
 Documentation/gitk.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index e9f82b9..8dbfb0d 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -69,7 +69,7 @@ gitk --since="2 weeks ago" \-- gitk::
 	The "--" is necessary to avoid confusion with the *branch* named
 	'gitk'
 
-gitk --max-count=100 --all -- Makefile::
+gitk --max-count=100 --all \-- Makefile::
 
 	Show at most 100 changes made to the file 'Makefile'. Instead of only
 	looking for changes in the current branch look in all branches.
-- 
1.5.3.1.153.g89df5

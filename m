From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH] git-clone.txt: Improve --depth description.
Date: Thu, 1 Nov 2007 09:46:02 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071101084602.GB4934@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 09:46:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InVh6-0007ZD-4h
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 09:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755285AbXKAIqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 04:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755243AbXKAIqH
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 04:46:07 -0400
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:50948 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754659AbXKAIqG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 04:46:06 -0400
Received: from localhost.localdomain (xdsl-87-78-70-152.netcologne.de [87.78.70.152])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 7A00940002DDB;
	Thu,  1 Nov 2007 09:46:03 +0100 (CET)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1InVgg-0001Pk-VI; Thu, 01 Nov 2007 09:46:02 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62930>

Avoid abbreviation 'revs', improve the language a bit.
---
 Documentation/git-clone.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 253f4f0..cca14d6 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -111,11 +111,11 @@ OPTIONS
 
 --depth <depth>::
 	Create a 'shallow' clone with a history truncated to the
-	specified number of revs.  A shallow repository has
+	specified number of revisions.  A shallow repository has a
 	number of limitations (you cannot clone or fetch from
 	it, nor push from nor into it), but is adequate if you
-	want to only look at near the tip of a large project
-	with a long history, and would want to send in a fixes
+	are only interested in the recent history of a large project
+	with a long history, and would want to send in fixes
 	as patches.
 
 <repository>::
-- 
1.5.3.1.522.g85b0

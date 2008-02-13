From: Sergei Organov <osv@javad.com>
Subject: [PATCH] git-cvsimport.txt: fix '-M' description.
Date: Wed, 13 Feb 2008 17:31:17 +0300
Message-ID: <87hcgcx5uo.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 15:57:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPJ31-0006YU-Df
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 15:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754870AbYBMO4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 09:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754214AbYBMO4n
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 09:56:43 -0500
Received: from javad.com ([216.122.176.236]:2178 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753213AbYBMO4m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 09:56:42 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id m1DEucd57831;
	Wed, 13 Feb 2008 14:56:39 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1JPJ2F-000257-W7; Wed, 13 Feb 2008 17:56:31 +0300
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73798>

Fix '-M' description. Old one reads as if the user can somehow "see"
the default regex when using -M along with -m.

Signed-off-by: Sergei Organov <osv@javad.com>
---
 Documentation/git-cvsimport.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index dbce503..6f91b9e 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -107,8 +107,8 @@ If you need to pass multiple options, separate them with a comma.
 
 -M <regex>::
 	Attempt to detect merges based on the commit message with a custom
-	regex. It can be used with '-m' to also see the default regexes.
-	You must escape forward slashes.
+	regex. It can be used with '-m' to enable the default regexes
+	as well. You must escape forward slashes.
 
 -S <regex>::
 	Skip paths matching the regex.
-- 
1.5.4.18.gd0b8

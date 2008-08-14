From: Matt McCutchen <matt@mattmccutchen.net>
Subject: [PATCH] git format-patch documentation: clarify what
	--cover-letter does
Date: Thu, 14 Aug 2008 13:37:41 -0400
Message-ID: <1218735461.2498.37.camel@mattlaptop2.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 19:40:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTgoC-0003nu-4m
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 19:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353AbYHNRjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 13:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752638AbYHNRjS
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 13:39:18 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:55336 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759219AbYHNRjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 13:39:16 -0400
Received: from jankymail-a3.g.dreamhost.com (sd-green-bigip-177.dreamhost.com [208.97.132.177])
	by hapkido.dreamhost.com (Postfix) with ESMTP id DB19D17D186
	for <git@vger.kernel.org>; Thu, 14 Aug 2008 10:39:19 -0700 (PDT)
Received: from [192.168.1.47] (pool-71-163-217-160.washdc.east.verizon.net [71.163.217.160])
	by jankymail-a3.g.dreamhost.com (Postfix) with ESMTP id 99DBD65793;
	Thu, 14 Aug 2008 10:37:48 -0700 (PDT)
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92377>

Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
---
 Documentation/git-format-patch.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 010d9e4..2f1deec 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -147,9 +147,9 @@ include::diff-options.txt[]
 	to any configured headers, and may be used multiple times.
 
 --cover-letter::
-	Generate a cover letter template.  You still have to fill in
-	a description, but the shortlog and the diffstat will be
-	generated for you.
+	In addition to the patches, generate a "cover letter" file
+	containing the shortlog and the overall diffstat.  You still have
+	to fill in a description.
 
 --suffix=.<sfx>::
 	Instead of using `.patch` as the suffix for generated
-- 
1.6.0.rc3.8.g24bd

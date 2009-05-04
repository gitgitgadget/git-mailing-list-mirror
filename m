From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/7] Fix FindBugs exclude filter to work on UNIX platforms
Date: Mon,  4 May 2009 16:30:42 -0700
Message-ID: <1241479848-20687-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Matthias Sohn <matthias.sohn@sap.com>
X-From: git-owner@vger.kernel.org Tue May 05 01:31:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M17ci-0005qi-3u
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 01:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755162AbZEDXau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 19:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbZEDXat
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 19:30:49 -0400
Received: from george.spearce.org ([209.20.77.23]:52538 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbZEDXas (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 19:30:48 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 3E58038194; Mon,  4 May 2009 23:30:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id C597738194;
	Mon,  4 May 2009 23:30:48 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc4.206.g03e16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118273>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 org.spearce.jgit/.fbprefs |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/.fbprefs b/org.spearce.jgit/.fbprefs
index e97968b..d6f94c3 100644
--- a/org.spearce.jgit/.fbprefs
+++ b/org.spearce.jgit/.fbprefs
@@ -119,7 +119,7 @@ detectorWrongMapIterator=WrongMapIterator|true
 detectorXMLFactoryBypass=XMLFactoryBypass|true
 detector_threshold=2
 effort=default
-excludefilter0=findBugs\\FindBugsExcludeFilter.xml
+excludefilter0=findBugs/FindBugsExcludeFilter.xml
 filter_settings=Medium|BAD_PRACTICE,CORRECTNESS,MT_CORRECTNESS,PERFORMANCE,STYLE|false
 filter_settings_neg=MALICIOUS_CODE,NOISE,I18N,SECURITY,EXPERIMENTAL|
 run_at_full_build=true
-- 
1.6.3.rc4.206.g03e16

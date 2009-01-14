From: jidanni@jidanni.org
Subject: [PATCH] git-rev-parse(1): restore vital table header
Date: Thu, 15 Jan 2009 05:34:55 +0800
Message-ID: <1231968895-3643-1-git-send-email-jidanni@jidanni.org>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 14 22:57:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNDjJ-0005QC-To
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 22:56:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813AbZANVz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 16:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754554AbZANVz2
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 16:55:28 -0500
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:36869 "EHLO
	homiemail-a4.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754388AbZANVz2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jan 2009 16:55:28 -0500
Received: from jidanni.org (122-127-36-160.dynamic.hinet.net [122.127.36.160])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a4.dreamhost.com (Postfix) with ESMTP id 9CFF1415A6;
	Wed, 14 Jan 2009 13:55:25 -0800 (PST)
X-Mailer: git-send-email 1.6.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105707>

A vital table header is restored. Else the new user may be confused as
to the implied relationship betwixt the two columns.

Signed-off-by: jidanni <jidanni@jidanni.org>
---
 Documentation/git-rev-parse.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 2921da3..45ea114 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -318,6 +318,7 @@ all of its parents.
 
 Here are a handful of examples:
 
+   Range            Reaches
    D                G H D
    D F              G H I J D F
    ^G D             H D
-- 
1.6.0.6

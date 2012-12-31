From: Jason Holden <jason.k.holden.swdev@gmail.com>
Subject: [PATCH v2 2/2] Provide better guidance for submitting patches against upstream utilities
Date: Mon, 31 Dec 2012 17:19:35 -0500
Message-ID: <1356992375-11116-3-git-send-email-jason.k.holden.swdev@gmail.com>
References: <1356992375-11116-1-git-send-email-jason.k.holden.swdev@gmail.com>
Cc: gitster@pobox.com, th.acker@arcor.de, paulus@samba.org,
	patthoyts@users.sourceforge.net, worldhello.net@gmail.com,
	Jason Holden <jason.k.holden.swdev@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 31 23:21:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tpnjg-0005Cz-1E
	for gcvg-git-2@plane.gmane.org; Mon, 31 Dec 2012 23:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936Ab2LaWVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 17:21:14 -0500
Received: from mail-vc0-f181.google.com ([209.85.220.181]:39915 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930Ab2LaWVL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 17:21:11 -0500
Received: by mail-vc0-f181.google.com with SMTP id gb30so12923587vcb.26
        for <git@vger.kernel.org>; Mon, 31 Dec 2012 14:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=SsVNP5iu5XQiGPAB0qllQ9shLbUVFTYx94D4dW1++xo=;
        b=Tm1VwBwK5VSNiCP5SfcXO5JcUYiN6xEEs19tIARaj5p+CM7++Ro9jiT46XYTmrDbdC
         zvL472u48rS0IaCy+hhn997oHxvibFqFXJN25K7olu7nzwXzJ2LY2ReSGFKw2/Fe/quL
         ZNIv2EgYlMJP2y0t0CeakDz6sQsfZ11H+o29zCCxLM53qt6MEYoICpgiv7ROTvPuqPhj
         wUc/+frCoN7gTwc67YMfsCoI4zskTF6mhX3rJh25Y6BWcAXKsnZ1Q9kX/lCOOPlAc9Uj
         G8eiMc45ZXQ2ijVUf3Xx15UyUXL7bD+d3A2hE41L62KdguvRJEvAWWnmY65v0SmjWadj
         ypIw==
X-Received: by 10.58.68.74 with SMTP id u10mr68398949vet.21.1356992470288;
        Mon, 31 Dec 2012 14:21:10 -0800 (PST)
Received: from rowblue.hsd1.nh.comcast.net (c-75-69-185-21.hsd1.nh.comcast.net. [75.69.185.21])
        by mx.google.com with ESMTPS id di16sm39824172vdb.11.2012.12.31.14.21.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 31 Dec 2012 14:21:09 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.28.g0ab5d1f
In-Reply-To: <1356992375-11116-1-git-send-email-jason.k.holden.swdev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212363>

git-gui, gitk, and git-po are maintained upstream of git.
Document this, and the procedure for submitting patches to these tools

Signed-off-by: Jason Holden <jason.k.holden.swdev@gmail.com>
---
 Documentation/SubmittingPatches | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 75935d5..30b95a8 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -58,6 +58,17 @@ Checklist (and a short version for the impatient):
 	  please test it first by sending email to yourself.
 	- see below for instructions specific to your mailer
 
+	Improving upstream utilities (gitk, git-gui, git-po)
+	- gitk, git-gui, and git-po are maintained upstream of Git
+	  despite being included in Git's git repository
+	- Patches should be made against the upstream gui repository,
+	  and not against the version in Git's git repository
+	- The resulting patch should still be emailed for review
+	  to the git mailing list (git@vger.kernel.org), cc'ing the
+	  applicable gui maintainer
+	- Please see the MAINTAINER's file for the gui maintainer's contact
+	  information and canonical repository location
+
 Long version:
 
 I started reading over the SubmittingPatches document for Linux
-- 
1.8.1.rc3.28.g0ab5d1f

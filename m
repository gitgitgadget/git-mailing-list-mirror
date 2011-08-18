From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v2 2/4] git-p4: Add description of rename/copy detection options.
Date: Thu, 18 Aug 2011 23:20:52 +0100
Message-ID: <1313706054-11740-3-git-send-email-vitor.hda@gmail.com>
References: <1313706054-11740-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 00:21:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuAy8-0002QM-Ng
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 00:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903Ab1HRWVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 18:21:39 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34913 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754894Ab1HRWVh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 18:21:37 -0400
Received: by mail-wy0-f174.google.com with SMTP id 24so1729052wyg.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 15:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=pu00XlYawg7Xca1SDSy7Jrrpvtgx73AU/8CVdctdxQw=;
        b=xxi71Y30fa1NxS2mws/H09+5Z9v2udv8ewqKCKl9zGrFJqQ+AOY5in7IvOKIhkub89
         6pPQSujpe4oe72SlIAzp/M/hq7p9/+pZ0fbMbwbF43GPOg57rwb15qDxlvDeCmVXgOgu
         T2YftkckmIpy/pJrvnaAJXXAq2rzn48ikS/Mg=
Received: by 10.227.162.201 with SMTP id w9mr1066936wbx.28.1313706097230;
        Thu, 18 Aug 2011 15:21:37 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id fy12sm2103590wbb.32.2011.08.18.15.21.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 15:21:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1313706054-11740-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179638>

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 contrib/fast-import/git-p4.txt |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/git-p4.txt b/contrib/fast-import/git-p4.txt
index caa4bb3..2ffbccc 100644
--- a/contrib/fast-import/git-p4.txt
+++ b/contrib/fast-import/git-p4.txt
@@ -232,6 +232,31 @@ git-p4.skipUserNameCheck
 When submitting, git-p4 checks that the git commits are authored by the current
 p4 user, and warns if they are not. This disables the check.
 
+git-p4.detectRenames
+
+Detect renames when submitting changes to Perforce server. Will enable -M git
+argument. Can be optionally set to a number representing the threshold
+percentage value of the rename detection.
+
+  git config [--global] git-p4.detectRenames true
+  git config [--global] git-p4.detectRenames 50
+
+git-p4.detectCopies
+
+Detect copies when submitting changes to Perforce server. Will enable -C git
+argument. Can be optionally set to a number representing the threshold
+percentage value of the copy detection.
+
+  git config [--global] git-p4.detectCopies true
+  git config [--global] git-p4.detectCopies 80
+
+git-p4.detectCopiesHarder
+
+Detect copies even between files that did not change when submitting changes to
+Perforce server. Will enable --find-copies-harder git argument.
+
+  git config [--global] git-p4.detectCopies true
+
 Implementation Details...
 =========================
 
-- 
1.7.5.4

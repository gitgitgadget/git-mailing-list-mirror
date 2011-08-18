From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH 2/4] git-p4: Add description of rename/copy detection options.
Date: Thu, 18 Aug 2011 02:04:17 +0100
Message-ID: <1313629459-22937-3-git-send-email-vitor.hda@gmail.com>
References: <1313629459-22937-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 03:04:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtr2T-00039P-6a
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 03:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754711Ab1HRBEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 21:04:48 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:35063 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669Ab1HRBEs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 21:04:48 -0400
Received: by wwe5 with SMTP id 5so3658833wwe.1
        for <git@vger.kernel.org>; Wed, 17 Aug 2011 18:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=pu00XlYawg7Xca1SDSy7Jrrpvtgx73AU/8CVdctdxQw=;
        b=nvFHFKfLhihIFaA//fveq6q/LgrVmNauk3h748o5pmQtoWmfJUSNbdRyC9yUCaok7L
         mVkJER72fDVh5SnzMAx3dN47vy+9hWI+4I4390Sg3R2+IT9LD+IELYIdsOzbKZkR5EJv
         yD0Bcn02e465BQUl/ld/2SiKC9phKmYxrMsrQ=
Received: by 10.227.196.196 with SMTP id eh4mr91979wbb.23.1313629486840;
        Wed, 17 Aug 2011 18:04:46 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id fm9sm1343282wbb.27.2011.08.17.18.04.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Aug 2011 18:04:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1313629459-22937-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179549>

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

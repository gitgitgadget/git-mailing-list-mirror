From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v3 2/5] git-p4: Add description of rename/copy detection options
Date: Mon, 22 Aug 2011 09:33:06 +0100
Message-ID: <1314001989-29017-3-git-send-email-vitor.hda@gmail.com>
References: <1314001989-29017-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 22 10:34:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvPxf-0001Mc-O9
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 10:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760Ab1HVIeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 04:34:20 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58449 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754189Ab1HVIeR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 04:34:17 -0400
Received: by mail-ww0-f44.google.com with SMTP id 5so4968962wwf.1
        for <git@vger.kernel.org>; Mon, 22 Aug 2011 01:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=pu00XlYawg7Xca1SDSy7Jrrpvtgx73AU/8CVdctdxQw=;
        b=u8W3SI7QJz4Eb1FD30GyCg2AmR8wyCUSwcfah4fhLwfPDZPf3yZOt2gNIXralyRf6a
         eY/Xc/eVJ/NZqcdNZ+x2NIqpN6rT4VU3ozqvglpaK1og0fOnQ9UddLBYa4yZbe5MlibC
         +Spd6qVoN5ve4pLkimMZyoHBoJQcbtvupxdjE=
Received: by 10.216.90.8 with SMTP id d8mr1845224wef.25.1314002057167;
        Mon, 22 Aug 2011 01:34:17 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id e44sm3284981wed.41.2011.08.22.01.34.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 22 Aug 2011 01:34:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1314001989-29017-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179846>

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

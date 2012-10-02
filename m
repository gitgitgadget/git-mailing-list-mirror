From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/5] Documentation: sort diff-config.txt alphabetically
Date: Tue,  2 Oct 2012 22:21:07 +0530
Message-ID: <1349196670-2844-3-git-send-email-artagnon@gmail.com>
References: <1349196670-2844-1-git-send-email-artagnon@gmail.com>
Cc: Jens Lehmann <Jens.Lehmann@web.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 18:52:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ5hf-0007bu-Bg
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 18:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220Ab2JBQvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 12:51:48 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:48220 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607Ab2JBQvf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 12:51:35 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so5408625pad.19
        for <git@vger.kernel.org>; Tue, 02 Oct 2012 09:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+1FhfcCF1BISUKYtam8PcaNdjtPN+vfCm4PUBDGL0l8=;
        b=eAFfZgTthWdwEBP8GOrkwBM2uhiatGdPf401YUuLqFpEVmQvXM3CI8i7S4hUUNRqxM
         f5whSpiJb7ftS9Q654Uuufnbdkt7GBdaln0VGoBVpAhLWkaUegKqnpJ2ITxj+q50C1N1
         8wP9YwgYBVlXnES+83kjuKKs5Stb5x/ZcZaVkHFvwUYxTm+EJNTVns3ViLMr6h6LASzh
         gaFKMSsyZOfZYmXD4UNIPJV4vDrzYREdk8x77zmcZIUWnuXASV4hNwJdEsuLwyffB4Di
         yLc90VDsFK9AVA34mAWKQZgq4npNxnKPAW7L5o2g6xJg/1E1K1pWVC5JCKDL6WffFghb
         kCFg==
Received: by 10.68.224.161 with SMTP id rd1mr5956980pbc.49.1349196695363;
        Tue, 02 Oct 2012 09:51:35 -0700 (PDT)
Received: from localhost.localdomain ([49.206.137.123])
        by mx.google.com with ESMTPS id qd9sm1151524pbb.31.2012.10.02.09.51.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Oct 2012 09:51:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
In-Reply-To: <1349196670-2844-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206819>

df44483a (diff --stat: add config option to limit graph width,
2012-03-01) added the option diff.statGraphWidth, but did not place it
in its appropriate lexical place in diff-config.txt.  Fix this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/diff-config.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index c2b94f9..04574f9 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -52,10 +52,6 @@ directories with less than 10% of the total amount of changed files,
 and accumulating child directory counts in the parent directories:
 `files,10,cumulative`.
 
-diff.statGraphWidth::
-	Limit the width of the graph part in --stat output. If set, applies
-	to all commands generating --stat output except format-patch.
-
 diff.external::
 	If this config variable is set, diff generation is not
 	performed using the internal diff machinery, but using the
@@ -99,6 +95,10 @@ diff.renames::
 	will enable basic rename detection.  If set to "copies" or
 	"copy", it will detect copies, as well.
 
+diff.statGraphWidth::
+	Limit the width of the graph part in --stat output. If set, applies
+	to all commands generating --stat output except format-patch.
+
 diff.suppressBlankEmpty::
 	A boolean to inhibit the standard behavior of printing a space
 	before each empty output line. Defaults to false.
-- 
1.7.8.1.362.g5d6df.dirty

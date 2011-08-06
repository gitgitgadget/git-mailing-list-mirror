From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 32/40] whitespace: remediate t9110-git-svn-use-svm-props.sh
Date: Sat,  6 Aug 2011 18:44:46 +1000
Message-ID: <1312620294-18616-32-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:46:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcWz-0005WP-7l
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755684Ab1HFIq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:46:27 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:53446 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755401Ab1HFIqU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:46:20 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5182831iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Q93KHgQ1SceXxLIyuCtM89AamYgaVQrO2SxdO+467ZU=;
        b=QIq34r1u1LeOtOrHDtkZvpb8Gc23dUis8GbHv4dQ2877zIgCIbHZkv45lQRULO8we6
         Q0rUiE/xBFZ6GbbTOmjVfWKJK7wGci6rMzmeBpNIgX3YONI8vcDXUcRlNlx4Sx/PEzxg
         ZeUNV4NWeglvxckaaMai9/0EpkJyUqZhRJZmw=
Received: by 10.231.45.129 with SMTP id e1mr942183ibf.22.1312620379834;
        Sat, 06 Aug 2011 01:46:19 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.46.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:46:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178859>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t9110-git-svn-use-svm-props.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9110-git-svn-use-svm-props.sh b/t/t9110-git-svn-use-svm-props.sh
index a06e4c5..7db429c 100755
--- a/t/t9110-git-svn-use-svm-props.sh
+++ b/t/t9110-git-svn-use-svm-props.sh
@@ -50,9 +50,9 @@ test_expect_success 'verify metadata for /dir' "
 	"
 
 test_expect_success 'find commit based on SVN revision number' "
-        git svn find-rev r12 |
+	git svn find-rev r12 |
 	    grep `git rev-parse HEAD`
-        "
+	"
 
 test_expect_success 'empty rebase' "
 	git svn rebase
-- 
1.7.6.362.gf0e6

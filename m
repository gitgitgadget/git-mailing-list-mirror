From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH v2] Documentation/diff-options: reword description of --submodule option
Date: Wed, 14 Mar 2012 13:00:55 -0400
Message-ID: <1331744455-624-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 14 18:01:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7rZx-0006MS-JU
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 18:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761136Ab2CNRBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 13:01:33 -0400
Received: from mail-fa0-f46.google.com ([209.85.161.46]:40840 "EHLO
	mail-fa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760284Ab2CNRBc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 13:01:32 -0400
Received: by faas1 with SMTP id s1so441147faa.19
        for <git@vger.kernel.org>; Wed, 14 Mar 2012 10:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=GRrsjD4P1znStzJh0VZDyamyUf94Kyyw7TxjeQ2TuwQ=;
        b=GfUyS3xI4yMgTGrmGLLstk1KT2hB3dg+pHuiwAhBSClWxPWvxnEAqJGsFxZaYeAkUF
         BBWXhb5fIPgH1k9m5DKBVI6RNKOhCkVYt22XpAgIq35e8tZ0G9yT0vqq7BZ/hJeZ0fNk
         vDTv/7DLPgT1H4N+SKwFcKcPOAsf6Wt0QkRrEO+7X77hU7TCk1U8iaQQ49IUJGWex2eh
         qcnYmPtujT3fhGMC353WmgEOhq1g2o/vLkHwOgm4d0JxNrFtvKFJbtV28rjONonO0Yzd
         3/o5+0Wn97rkQMK4NqLjupms/WhhbXAOLXWyu6tVx6yQ4unzbRVadlhmeROgmZaM9bAs
         J9ag==
Received: by 10.224.106.66 with SMTP id w2mr4080913qao.1.1331744490610;
        Wed, 14 Mar 2012 10:01:30 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id ha10sm9713917qab.14.2012.03.14.10.01.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Mar 2012 10:01:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193134>

The previous description was confusing.  This rewrite makes it easier
to understand.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

Changes in v2:
  - v1 was a series of two patches. The first was a simple typo fix
    (s/Chose/Choose/). v2 eliminates the first commit as it is no longer
    needed.
  - Changed wording again based on direction from Junio Hamano.
  - Removed explanation of formats from the commit message. The diff
    now adequately explains how they work.


 Documentation/diff-options.txt |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 7d4566f..6aa0907 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -165,11 +165,12 @@ any of those replacements occurred.
 	of the `--diff-filter` option on what the status letters mean.
 
 --submodule[=<format>]::
-	Chose the output format for submodule differences. <format> can be one of
-	'short' and 'log'. 'short' just shows pairs of commit names, this format
-	is used when this option is not given. 'log' is the default value for this
-	option and lists the commits in that commit range like the 'summary'
-	option of linkgit:git-submodule[1] does.
+	Specify how differences in submodules are shown.  When `--submodule`
+	or `--submodule=log` is given, the 'log' format is used.  This format lists
+	the commits in the range like linkgit:git-submodule[1] `--summary` does.
+	Omitting the `--submodule` option or specifying `--submodule=short`,
+	uses the 'short' format. This format just shows the names of the commits
+	at the beginning and end of the range.
 
 --color[=<when>]::
 	Show colored diff.
-- 
1.7.10.rc0

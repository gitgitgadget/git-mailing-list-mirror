From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 26/40] whitespace: remediate t7810-grep.sh
Date: Sat,  6 Aug 2011 18:44:40 +1000
Message-ID: <1312620294-18616-26-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:46:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcWV-0005FS-IX
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755371Ab1HFIqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:46:14 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:52375 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755283Ab1HFIqG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:46:06 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5183416iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=je6ksRipb9EEot1GBMZYd8VOVTZenJGhnhur3TcdBHc=;
        b=Fs4ALswSjjJ1dy6LtwSfSbOXuBBgn+3gAwf28FMf0ATk+lTWmYDSxzjRn+gGHeDnrn
         i5Zx7HoBTm2auR30NMrrg5m2HOmgCnG+d98Rffnmma1PMzr0BhEQTWPdk7ad+fg3/qU8
         VSAl/cwfwl/HHswsxbN7rQMf8kBWy1SVeftHE=
Received: by 10.43.131.200 with SMTP id hr8mr1740897icc.229.1312620366076;
        Sat, 06 Aug 2011 01:46:06 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.46.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:46:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178853>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t7810-grep.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index a29ae45..348e575 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -168,7 +168,7 @@ do
 
 	test_expect_success "grep -c $L (no /dev/null)" '
 		! git grep -c test $H | grep /dev/null
-        '
+	'
 
 	test_expect_success "grep --max-depth -1 $L" '
 		{
-- 
1.7.6.362.gf0e6

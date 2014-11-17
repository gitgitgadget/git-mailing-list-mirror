From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] Documentation: change "gitlink" typo in git-push
Date: Mon, 17 Nov 2014 00:49:00 +0000
Message-ID: <1416185340-105170-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Dan Allen <dan.j.allen@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 17 01:49:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqAVG-0002cr-A5
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 01:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbaKQAtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2014 19:49:09 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50062 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751112AbaKQAtI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Nov 2014 19:49:08 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 82AD72808F;
	Mon, 17 Nov 2014 00:49:04 +0000 (UTC)
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git-push manual page used "gitlink" in one place instead of
"linkgit".  Fix this so the link renders correctly.

Noticed-by: Dan Allen <dan.j.allen@gmail.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-push.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 21b3f29..b17283a 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -34,7 +34,7 @@ When the command line does not specify what to push with `<refspec>...`
 arguments or `--all`, `--mirror`, `--tags` options, the command finds
 the default `<refspec>` by consulting `remote.*.push` configuration,
 and if it is not found, honors `push.default` configuration to decide
-what to push (See gitlink:git-config[1] for the meaning of `push.default`).
+what to push (See linkgit:git-config[1] for the meaning of `push.default`).
 
 
 OPTIONS[[OPTIONS]]
-- 
2.2.0.rc0.207.ga3a616c

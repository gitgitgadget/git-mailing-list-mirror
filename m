From: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] read-tree: replace bracket set with parentheses to clarify usage
Date: Wed, 26 Aug 2015 22:27:06 -0600
Message-ID: <1440649626-3751-1-git-send-email-alexhenrie24@gmail.com>
Cc: Alex Henrie <alexhenrie24@gmail.com>
To: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 27 06:27:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUomT-0002pu-DT
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 06:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbbH0E1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 00:27:13 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33351 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863AbbH0E1M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 00:27:12 -0400
Received: by pacti10 with SMTP id ti10so11239795pac.0
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 21:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=CqSnkqIQvFhwEqhOHSbEye3QaHI1mkkasdQ1lDTN4vg=;
        b=ioTGzWLKONV0PkwM+PCmEQN20ixSEacHvKzoijeNGn7rTcXtx5AlNnzB0G3Ui7SOC2
         3vKFp8JDLvoXm25seZ7z8/DXyo5oK5XytN665dWBlhQ5Iqm5cvg0J4cD0fv9AhX2yvsC
         JyqRaplfIpj7L1RC+dAGdI7K9NkntRqIEvtWdNmsT5zdVrYnnCaQzAMFrSTSmi/tbEf8
         fBvxAA5oPFoHqridg3GH2tcMQgLMEDSe946jeFxCELb/rlPpw2PFWGOyBJeAEDx9ImnR
         JDNuVMZDgbA/12LO/WsbQWRPoVFBnOMwqFjYlhETG2IXdUDblVBzGmFzFedFzb21/Rhd
         Rd8g==
X-Received: by 10.68.239.69 with SMTP id vq5mr3327520pbc.111.1440649632170;
        Wed, 26 Aug 2015 21:27:12 -0700 (PDT)
Received: from alex-wolverine.lan ([2601:681:4d04:75d8:e8b:fdff:fecc:2734])
        by smtp.gmail.com with ESMTPSA id qn6sm698539pbc.22.2015.08.26.21.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Aug 2015 21:27:11 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276660>

-u and -i can only be given if -m, --reset, or --prefix is given.
Without parentheses, it looks like -u and -i can be used no matter
what, and the second pair of brackets is confusing.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/read-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 43b47f7..2379e11 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -34,7 +34,7 @@ static int list_tree(unsigned char *sha1)
 }
 
 static const char * const read_tree_usage[] = {
-	N_("git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>] [-u [--exclude-per-directory=<gitignore>] | -i]] [--no-sparse-checkout] [--index-output=<file>] (--empty | <tree-ish1> [<tree-ish2> [<tree-ish3>]])"),
+	N_("git read-tree [(-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>) [-u [--exclude-per-directory=<gitignore>] | -i]] [--no-sparse-checkout] [--index-output=<file>] (--empty | <tree-ish1> [<tree-ish2> [<tree-ish3>]])"),
 	NULL
 };
 
-- 
2.5.0

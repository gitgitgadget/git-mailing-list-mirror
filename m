Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92C3C20357
	for <e@80x24.org>; Mon, 17 Jul 2017 15:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751294AbdGQPi3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 11:38:29 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33962 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbdGQPi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 11:38:28 -0400
Received: by mail-pg0-f65.google.com with SMTP id v190so6110911pgv.1
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 08:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HEY0QienvBisRH65MsjZdUq8TwXr9wFeIu0VgZgu4ZY=;
        b=G7jkkw1bA6SdsiRCu7MibkeKHISxAOgCM1Q8jPl0/mPwFhwwqx2MS3O674nmNfjbMe
         Gl7+erUGydcxEW+cKAEL0Wx3Ya8k610cBvOJooa0DnzeiLiUSfbfjKDSd/1Me3ickCyu
         erCx9cdw8HkB3IUJz6CTENW5uyl8OJ3B1UPJ/jlAMQ0EeYe045Ws3jbEGhScoU/+sWSt
         54JiNDU6eyxtMt+eIyADcaBOdoFgIUVVTWVZ5l6wV0P7Mm+12mPnoedoZnkHmXFiJu4V
         YDy8ybgd2+6cWlYnf8n07BoXWWWDdfRB+QDCRUVbk3dpUTc67iBljVYja1lN2aXDOIB7
         mZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HEY0QienvBisRH65MsjZdUq8TwXr9wFeIu0VgZgu4ZY=;
        b=qa5bYsVopHMlXEKFDLJwg4fvPuqNIUbGgspSwiDP/cw5wXAXleOXQQB5nM7Ll7BZkd
         CwQQ5jb7/xidV4eAXbsdWNHn3v+gmBsyYwajCQxaLixrMeF7bXR8dowKCiiLooLDUxAb
         em7h4ZH1ogZSkpvBAaE+HsOUIfkayPrGz89P7aes4S8+IuMjEK/YXy1Q14ST1rVsYadA
         pGk58ER3myW/H7+L4wkS+wjdVk7B+zln8x+ZBkvXmrGpq3ZJaK4VlYYF+CvzPduZDGrR
         PVGP7+1CRrOyg5tFEBsBjgpQVQn5n5+hSeXw6i1ptOLzhVaReH6UF+wVGOVTspIbmyhJ
         z20A==
X-Gm-Message-State: AIVw111dCGUTJKcv+18/YB7AZX/5LhOqf7BOvHjHYgIFcBE7GKQV8uWa
        DBTWCB/kWb/RF5qreK8=
X-Received: by 10.98.66.198 with SMTP id h67mr20188444pfd.2.1500305908105;
        Mon, 17 Jul 2017 08:38:28 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7003:dd63:70be:8c6f:6f19:1db1])
        by smtp.gmail.com with ESMTPSA id w125sm33414422pfb.117.2017.07.17.08.38.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jul 2017 08:38:27 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH] doc: reformat the paragraph containing the 'cut-line'
Date:   Mon, 17 Jul 2017 21:08:39 +0530
Message-Id: <20170717153839.16586-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.13.3.973.gaaf39e6bd.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The paragraph that describes the 'scissors' cleanup mode of
'commit' had the 'cut-line' in the middle of a sentence. This
made it possible for the line to get wrapped on smaler windows.
This shouldn't be the case as it makes it hard for the user to
understand the structure of the cut-line.

Reformat the pragraph to make the 'cut-line' stand on a line of
it's own thus distinguishing it from the rest of the paragraph.
This further prevents it from getting wrapped to some extent.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 Documentation/git-commit.txt | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index afb06adba..2c0d48bab 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -196,11 +196,12 @@ whitespace::
 verbatim::
 	Do not change the message at all.
 scissors::
-	Same as `whitespace`, except that everything from (and
-	including) the line
-	"`# ------------------------ >8 ------------------------`"
-	is truncated if the message is to be edited. "`#`" can be
-	customized with core.commentChar.
+	Same as `whitespace` except that everything from (and including)
+    the line found below is truncated, if the message is to be edited.
+    "`#`" can be customized with core.commentChar.
+
+        # ------------------------ >8 ------------------------
+
 default::
 	Same as `strip` if the message is to be edited.
 	Otherwise `whitespace`.
-- 
2.13.3.973.gaaf39e6bd.dirty


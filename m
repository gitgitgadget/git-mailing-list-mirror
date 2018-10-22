Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A0D71F453
	for <e@80x24.org>; Mon, 22 Oct 2018 20:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbeJWFG3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 01:06:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46209 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729105AbeJWFG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 01:06:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id i4-v6so7677460wrr.13
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 13:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wbG2FDixWtqd8XyA64OUh4GeD78GzZqn9m8g75NVBDU=;
        b=C7goYrVKKUeUDR9a3GfX1HCga9LEmAh0QNRKnNnnBuxqkhgMZnTC83S0BS2+b4Z4yv
         yvmAsTjE9s8EHvIrBhjQTNL/u3/7AjXD7BTzN/SsZswCfZ+Fcy2ckiOHYa6xEYg4HthR
         4Q7/pMpHU94O1QR/yeFeGqaMk0HyGhEFVA//wkjznos32HSeclQZwT1GlAP9bT6LjA8J
         5QffFNzAuaBqsai4XAAW5NSx+NLghSndCpf8PPd9raPHRbRPburLUN7h967rlpu6y3Dk
         +BypUU4qLq6gKnl5afTsxfHA3QE2zM7S7C1ZS6DAdCP6SUz3gZceIGaIz2ox48RcgX0P
         Zu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wbG2FDixWtqd8XyA64OUh4GeD78GzZqn9m8g75NVBDU=;
        b=KViKdO9ysm9htvuRuPgYQv3nxvTsYODeQWLUzwSIFmCCq9QtA9aDZF42+YrrY055JW
         RoNUlOQqkYGY8qX6oEVO0TUh8dmgx7ONXAnaxjROGRK08x5w79/tl3P7JDWEhe/yNBWm
         bR4GXC95/b+M+ME6VhOqvx8l036ZsYtBiY4OGsM6IpljJAbHl3XzJZ7UMBgBRvDHSx66
         ztjtU0FsuSiy078W0JCx1BK/aZ0en45k1pbXi8fEIudQ8EtbJ0Atirsvmzi+6pRi6G9d
         OR1pIr85MuMhEC2E9qQGyPWBd0K16E4Qt42AR9lJckvKEFzHFdSmRhUi7Et2IkiJDk6L
         pRRg==
X-Gm-Message-State: ABuFfohnYvkNhAJdKflmckLkXbT+gTTgHfeCH1E+C5d8WJXZ15g5BSRa
        CPdwHROauNz/fs6ULqsU67oQJRcf
X-Google-Smtp-Source: ACcGV63ks8B5ccmkP4tOHojbV9zjuWo4T8IyPZmmjcqJTrbmFZlU5t3Kk/FzZ25Y3XBtI+8tHmFELA==
X-Received: by 2002:a05:6000:1105:: with SMTP id z5mr45812566wrw.136.1540241181573;
        Mon, 22 Oct 2018 13:46:21 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:4936:e72c:acbd:e1bd])
        by smtp.gmail.com with ESMTPSA id r134-v6sm9526526wmg.9.2018.10.22.13.46.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 13:46:20 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH 2/6] doc: fix ASCII art tab spacing
Date:   Mon, 22 Oct 2018 22:45:42 +0200
Message-Id: <20181022204546.20354-3-asheiduk@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181022204546.20354-1-asheiduk@gmail.com>
References: <20181022204546.20354-1-asheiduk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Followup to 5dd05ebf ("doc: fix merge-base ASCII art tab spacing", 2016-10-21)

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/git-bisect-lk2009.txt | 30 ++++++++++++++---------------
 Documentation/git-checkout.txt      | 14 +++++++-------
 Documentation/git-merge-base.txt    |  6 +++---
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bisect-lk2009.txt
index 0f9ef2f25e..e99925184d 100644
--- a/Documentation/git-bisect-lk2009.txt
+++ b/Documentation/git-bisect-lk2009.txt
@@ -633,11 +633,11 @@ and so at step 3) we compute f(X).
 Let's take the following graph as an example:
 
 -------------
-	    G-H-I-J
-	   /       \
+            G-H-I-J
+           /       \
 A-B-C-D-E-F         O
-	   \       /
-	    K-L-M-N
+           \       /
+            K-L-M-N
 -------------
 
 If we compute the following non optimal function on it:
@@ -649,25 +649,25 @@ g(X) = min(number_of_ancestors(X), number_of_descendants(X))
 we get:
 
 -------------
-	    4 3 2 1
-	    G-H-I-J
+            4 3 2 1
+            G-H-I-J
 1 2 3 4 5 6/       \0
 A-B-C-D-E-F         O
-	   \       /
-	    K-L-M-N
-	    4 3 2 1
+           \       /
+            K-L-M-N
+            4 3 2 1
 -------------
 
 but with the algorithm used by git bisect we get:
 
 -------------
-	    7 7 6 5
-	    G-H-I-J
+            7 7 6 5
+            G-H-I-J
 1 2 3 4 5 6/       \0
 A-B-C-D-E-F         O
-	   \       /
-	    K-L-M-N
-	    7 7 6 5
+           \       /
+            K-L-M-N
+            7 7 6 5
 -------------
 
 So we chose G, H, K or L as the best bisection point, which is better
@@ -773,7 +773,7 @@ forked of the main branch at a commit named "D" like this:
 -------------
 A-B-C-D-E-F-G  <--main
        \
-	H-I-J  <--dev
+        H-I-J  <--dev
 -------------
 
 The commit "D" is called a "merge base" for branch "main" and "dev"
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 9db02928c4..801de2f764 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -311,9 +311,9 @@ branch refers to a specific commit. Let's look at a repo with three
 commits, one of them tagged, and with branch 'master' checked out:
 
 ------------
-	   HEAD (refers to branch 'master')
-	    |
-	    v
+           HEAD (refers to branch 'master')
+            |
+            v
 a---b---c  branch 'master' (refers to commit 'c')
     ^
     |
@@ -329,9 +329,9 @@ to commit 'd':
 ------------
 $ edit; git add; git commit
 
-	       HEAD (refers to branch 'master')
-		|
-		v
+               HEAD (refers to branch 'master')
+                |
+                v
 a---b---c---d  branch 'master' (refers to commit 'd')
     ^
     |
@@ -398,7 +398,7 @@ at what happens when we then checkout master:
 ------------
 $ git checkout master
 
-	       HEAD (refers to branch 'master')
+               HEAD (refers to branch 'master')
       e---f     |
      /          v
 a---b---c---d  branch 'master' (refers to commit 'd')
diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index 502e00ec35..9f07f4f6ed 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -154,13 +154,13 @@ topic origin/master`, the history of remote-tracking branch
 `origin/master` may have been rewound and rebuilt, leading to a
 history of this shape:
 
-			 o---B2
+	                 o---B2
 	                /
 	---o---o---B1--o---o---o---B (origin/master)
 	        \
-		 B0
+	         B0
 	          \
-		   D0---D1---D (topic)
+	           D0---D1---D (topic)
 
 where `origin/master` used to point at commits B0, B1, B2 and now it
 points at B, and your `topic` branch was started on top of it back
-- 
2.19.1


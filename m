Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E0211F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 14:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfKOOjW (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 09:39:22 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55473 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfKOOjW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 09:39:22 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so9889214wmb.5
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 06:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=310vHg8KP4NEE3Lf1+Rg54zhmzvuXE6DILo8niwSDUw=;
        b=bv+8Z5WMOmSnaQJCeMlPBl6mt/CMBTJuRRUDucQ3VXTESlKI6yTN95PD+yGM20UEZJ
         RvsAX9oZ8eDBgU5x6Nfr916e+B+y60dkP25kJ7bPv+a9twTnLSgCWdLnOMsU3ZQ3vHEs
         SbT0HKu9+0HKWeIQfH/LWlE7fPle3B0iAUSpGVIxsxNYN6JnDcxdy9sE5XSzmqyCCoG0
         WWvV1UYT98s++UrCGTPBqkdB4srmPB+xo7t209UQnOMl++bgckn6/o1mP3WpqqqjbOK7
         fXZFOxYb4QseuO+DMWYscytorxyTVyS2heAABYiq/v/YYuEOiwVlfIUCw40dUSdsbLkk
         6lcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=310vHg8KP4NEE3Lf1+Rg54zhmzvuXE6DILo8niwSDUw=;
        b=npl5ZG+enikJbB8ymbh0JVscgy9bbpE4Tbk8KlBPi6HnnCKXj/9uIxrkKbPuso4aPr
         FEF1p1dJVVXlKsbHeg9HBcbFrO0FJCEIGVQTfrmbLEzL90WDK9kir5guLK/6E2dlav1k
         VGxMi6q+h4i+XfqSUy4LKursgPhQy5mMys+05mZHpXjAWpCAAJGveAA7joT0BVUfxUlV
         4nRl8R5/f13+eOzhWKny8nzNMrgjqlnyqOryQpAfFBHsRe9tL2fM6dLnfaKKjWwP0a7v
         J1QcHeXRzNaH3VeF+A5dkGHc3m2wgSqHfGqCSOdExcrHs1X5LCvq+Xn0yRs+gIx5yEC+
         eLwQ==
X-Gm-Message-State: APjAAAV3qB5pj+i1dyxEnd6wZOA+9icU8Z5xPu+iyX6oQ91BOItn0OSd
        8TnQ6TDROaWIDPzvoWDaUE3Qv1HE
X-Google-Smtp-Source: APXvYqyFXm/Ii5skSxsbbjB9DDuiGhPD6KPchlY/Ps8EJkprYU4Umlt80OzTz6XW3QSzT54zmP+wGA==
X-Received: by 2002:a7b:c84b:: with SMTP id c11mr13902393wml.158.1573828760026;
        Fri, 15 Nov 2019 06:39:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n1sm11921709wrr.24.2019.11.15.06.39.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 06:39:19 -0800 (PST)
Message-Id: <2288690b94d82a629a3a94e25fa75d24a1c24000.1573828756.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v2.git.1573828756.gitgitgadget@gmail.com>
References: <pull.463.git.1573679258.gitgitgadget@gmail.com>
        <pull.463.v2.git.1573828756.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 14:39:16 +0000
Subject: [PATCH v2 3/3] FIX: wrap return for read_pipe_lines in ustring() and
 wrap GitLFS read of the pointer file in ustring()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index b088095b15..83f59ddca5 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -180,6 +180,11 @@ def die(msg):
         sys.exit(1)
 
 def write_pipe(c, stdin):
+    """Writes stdin to the command's stdin
+    Returns the number of bytes written.
+
+    Be aware - the byte count may change between 
+    Python2 and Python3"""
     if verbose:
         sys.stderr.write('Writing pipe: %s\n' % str(c))
 
@@ -249,6 +254,11 @@ def read_pipe_lines(c):
     val = pipe.readlines()
     if pipe.close() or p.wait():
         die('Command failed: %s' % str(c))
+    # Unicode conversion from str
+    # Iterate and fix in-place to avoid a second list in memory.
+    if isunicode:
+        for i in range(len(val)):
+            val[i] = ustring(val[i])
 
     return val
 
@@ -1268,7 +1278,7 @@ def generatePointer(self, contentFile):
             ['git', 'lfs', 'pointer', '--file=' + contentFile],
             stdout=subprocess.PIPE
         )
-        pointerFile = pointerProcess.stdout.read()
+        pointerFile = ustring(pointerProcess.stdout.read())
         if pointerProcess.wait():
             os.remove(contentFile)
             die('git-lfs pointer command failed. Did you install the extension?')
-- 
gitgitgadget

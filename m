Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4951E1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 12:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731055AbfKFMsf (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 07:48:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33237 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730392AbfKFMse (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 07:48:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id a17so1514388wmb.0
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 04:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DOPT2UisF57tFDAhc8FYGoKmKi+H9UikSzo+N+QGsDU=;
        b=qp+XmAvb+QcsIT7Ey49Qi5C7tx18BKQ3ijpVgibkW6bsfSqHhl6UQf9Z0alDqgjOep
         94TI1LCln2zHt8r+W6PbLFWH4qiUrcXyMx5bqjUZD2i72eXZVh4ZnkyKBVLUg5QvsLhj
         dgNbGnRbWCxEP0QQoib6tCBi7QzebRP363YeW83RAoCYBNfq5xh0SpujBxsMLpMiBYna
         z4hxv39qP+NFPrfae1cuqkALgWWZQN89DcucluAukDUvHuMEPFJ63h18uX+LKjzG5c2o
         ALd7ciOfpZJpGD2QacjpnP4wXCS2XGQbogSUrTX4L+K7qfBeNbT9HAuv0wPoVmpf0+ZD
         djHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DOPT2UisF57tFDAhc8FYGoKmKi+H9UikSzo+N+QGsDU=;
        b=ipwGrVYDpqPLF38kPPiSbrUg1Lgu+8PMF6nxlmjYkUTzEA/ApQ9JrBD0wv4dTqaVsU
         zucTmgKX8bb/Y0PkPbKRuxLyfH71YPv4BieFgyg6tGLrZCwn/GFUM6fLoo6mai7ClQ5O
         rNqAQJmaf8K+P2uyCnQGkHl5q7N20ILaV3yRALXh7gaknHaFKvA9npQeJjieIn3dEqoD
         EbuOihJxYMRSW7vuuTXD6JlnI16dLJnCxvFLLPvL8EFx7YUf3IaA5rCa5Ahodx0rxzx3
         SZBhByckeSEJ41P1KJUM9rB7jyYI8iuunKuD3aoBKLJSOcO8yXwby71MoR+puvzsgoHG
         nakg==
X-Gm-Message-State: APjAAAXlBXn6HttMo7KC8xhQ6JiM2jCmvVgBqfs2UuaEMH4TTxCQxfEw
        sp7yy4gT3XfRgYPTnK7F9QxqzGnE
X-Google-Smtp-Source: APXvYqydUjy3Q/P71N4RP0eo/SnBjrgRg6CFkcG2hFzJyX1QQBYGdLTtZmrXL4ED2aqbetyTHiIQ0w==
X-Received: by 2002:a7b:c7c7:: with SMTP id z7mr2246206wmk.133.1573044511625;
        Wed, 06 Nov 2019 04:48:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e27sm7090711wra.21.2019.11.06.04.48.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 04:48:31 -0800 (PST)
Message-Id: <796bc03408273097847185f9130d4992e1ee8121.1573044509.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.456.git.1573044509.gitgitgadget@gmail.com>
References: <pull.456.git.1573044509.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 12:48:29 +0000
Subject: [PATCH 1/1] api-index: remove api doc index files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

Remove both api-index.txt and api-index-skel.txt as the API documentation
is being moved to the header files, so the index is not needed anymore
because the doc files (Documentation/technical/api-*.txt) will be gone.

Make changes to Documentation/Makefile accordingly.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 Documentation/Makefile                     | 11 +++------
 Documentation/git.txt                      |  3 ---
 Documentation/technical/.gitignore         |  1 -
 Documentation/technical/api-index-skel.txt | 13 ----------
 Documentation/technical/api-index.sh       | 28 ----------------------
 5 files changed, 3 insertions(+), 53 deletions(-)
 delete mode 100644 Documentation/technical/.gitignore
 delete mode 100644 Documentation/technical/api-index-skel.txt
 delete mode 100755 Documentation/technical/api-index.sh

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 06d85ad958..0788dd12e8 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -73,7 +73,7 @@ SP_ARTICLES += howto/rebuild-from-update-hook
 SP_ARTICLES += howto/rebase-from-internal-branch
 SP_ARTICLES += howto/keep-canonical-history-correct
 SP_ARTICLES += howto/maintain-git
-API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technical/api-index.txt, $(wildcard technical/api-*.txt)))
+API_DOCS = $(patsubst %.txt,%,$(wildcard technical/api-*.txt))
 SP_ARTICLES += $(API_DOCS)
 
 TECH_DOCS += MyFirstContribution
@@ -96,7 +96,6 @@ TECH_DOCS += technical/shallow
 TECH_DOCS += technical/signature-format
 TECH_DOCS += technical/trivial-merge
 SP_ARTICLES += $(TECH_DOCS)
-SP_ARTICLES += technical/api-index
 
 ARTICLES_HTML += $(patsubst %,%.html,$(ARTICLES) $(SP_ARTICLES))
 HTML_FILTER ?= $(ARTICLES_HTML) $(OBSOLETE_HTML)
@@ -352,7 +351,7 @@ clean:
 	$(RM) *.texi *.texi+ *.texi++ git.info gitman.info
 	$(RM) *.pdf
 	$(RM) howto-index.txt howto/*.html doc.dep
-	$(RM) technical/*.html technical/api-index.txt
+	$(RM) technical/*.html
 	$(RM) SubmittingPatches.txt
 	$(RM) $(cmds_txt) $(mergetools_txt) *.made
 	$(RM) manpage-base-url.xsl
@@ -385,12 +384,8 @@ user-manual.xml: user-manual.txt user-manual.conf asciidoctor-extensions.rb GIT-
 	$(TXT_TO_XML) -d book -o $@+ $< && \
 	mv $@+ $@
 
-technical/api-index.txt: technical/api-index-skel.txt \
-	technical/api-index.sh $(patsubst %,%.txt,$(API_DOCS))
-	$(QUIET_GEN)cd technical && '$(SHELL_PATH_SQ)' ./api-index.sh
-
 technical/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
-$(patsubst %,%.html,$(API_DOCS) technical/api-index $(TECH_DOCS)): %.html : %.txt \
+$(patsubst %,%.html,$(API_DOCS) $(TECH_DOCS)): %.html : %.txt \
 	asciidoc.conf GIT-ASCIIDOCFLAGS
 	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) $*.txt
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 9b82564d1a..0fdd93ac95 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -904,9 +904,6 @@ See linkgit:gitworkflows[7] for an overview of recommended workflows.
 See also the link:howto-index.html[howto] documents for some useful
 examples.
 
-The internals are documented in the
-link:technical/api-index.html[Git API documentation].
-
 Users migrating from CVS may also want to
 read linkgit:gitcvs-migration[7].
 
diff --git a/Documentation/technical/.gitignore b/Documentation/technical/.gitignore
deleted file mode 100644
index 8aa891daee..0000000000
--- a/Documentation/technical/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-api-index.txt
diff --git a/Documentation/technical/api-index-skel.txt b/Documentation/technical/api-index-skel.txt
deleted file mode 100644
index eda8c195c1..0000000000
--- a/Documentation/technical/api-index-skel.txt
+++ /dev/null
@@ -1,13 +0,0 @@
-Git API Documents
-=================
-
-Git has grown a set of internal API over time.  This collection
-documents them.
-
-////////////////////////////////////////////////////////////////
-// table of contents begin
-////////////////////////////////////////////////////////////////
-
-////////////////////////////////////////////////////////////////
-// table of contents end
-////////////////////////////////////////////////////////////////
diff --git a/Documentation/technical/api-index.sh b/Documentation/technical/api-index.sh
deleted file mode 100755
index 9c3f4131b8..0000000000
--- a/Documentation/technical/api-index.sh
+++ /dev/null
@@ -1,28 +0,0 @@
-#!/bin/sh
-
-(
-	c=////////////////////////////////////////////////////////////////
-	skel=api-index-skel.txt
-	sed -e '/^\/\/ table of contents begin/q' "$skel"
-	echo "$c"
-
-	ls api-*.txt |
-	while read filename
-	do
-		case "$filename" in
-		api-index-skel.txt | api-index.txt) continue ;;
-		esac
-		title=$(sed -e 1q "$filename")
-		html=${filename%.txt}.html
-		echo "* link:$html[$title]"
-	done
-	echo "$c"
-	sed -n -e '/^\/\/ table of contents end/,$p' "$skel"
-) >api-index.txt+
-
-if test -f api-index.txt && cmp api-index.txt api-index.txt+ >/dev/null
-then
-	rm -f api-index.txt+
-else
-	mv api-index.txt+ api-index.txt
-fi
-- 
gitgitgadget

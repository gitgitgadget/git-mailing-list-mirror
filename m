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
	by dcvr.yhbt.net (Postfix) with ESMTP id 641E61F4B5
	for <e@80x24.org>; Sun, 17 Nov 2019 21:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfKQVFW (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 16:05:22 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37152 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfKQVFU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 16:05:20 -0500
Received: by mail-wr1-f66.google.com with SMTP id t1so17099868wrv.4
        for <git@vger.kernel.org>; Sun, 17 Nov 2019 13:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gnKUVJ1lm2HEd10kicC0YvBZsIDgxI2dYQImyP93oT8=;
        b=m1l9B03SamBWjrlQxvVZSgaB+bbE8ZjIa53u90KqkFOJOCvXsLtbu8/11nsScIeaXW
         oom8Ig+4SnxDj/okXmdZIwfiUrNc+Eg0BJBnvawv0Cwfu7TiP7Jq9FtU/fieesyH5moz
         OSU5BUzYXO8SBov6VA/7iytVuox08YAjo/tbVy10sffHI53OS/zDNUtXHDDKrtlA9R9Q
         5NWlCTgvosvUTYRUU47L4+ADmLKlzfH/Z1cyIHSfg9JDglKUQF1W+g30Of2iC+p8KngW
         ygSC1x6QRN4ZLFwQdzOtRcRjgU4SBiUoZ5aUiZ6aYL+dYUNuRU14hJ+8Mr7CoxcNcyIH
         axiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gnKUVJ1lm2HEd10kicC0YvBZsIDgxI2dYQImyP93oT8=;
        b=q0neopvAZfHsmKOzmF2dPd1UmZINkaCrx0dz0vI5wTN0z0hkFROVxq4RKueAqIYOT/
         4HM4qi5onSZuf2KHC65SYIIeecY6ieKXPmRCcgZmvL5wRwoUFeZkHkH7leIqf4fJy2xR
         e+M8FGhuPji1O7Zvf9f+U2xgf3eIcX88KqkUYq3xZm9NRL42+8KZe9CXzIKuv7aYML5A
         20bQCfAc2wntvb5MezB9xEvnsM5vL/c0IFQ/CZYx/vMcBFbJoa8E4LCj/BO8IRo3r8qh
         xbcPGQ/tjxA3qRY8DNn0fsKZQwE0OMNckWKwvOci/bHBA5qdDnDyv6F2XZsTs5USFSyw
         IUlQ==
X-Gm-Message-State: APjAAAUaloQWhJGsNxsyhleEDLTaTyc8mhEsCKrixlJzc7uEB2XrkMJx
        jzz5gqaIK6N/RDzrDo5sFXomwWSO
X-Google-Smtp-Source: APXvYqykzI1PlHrg33rrI+qEH8dIOYmqdbzoykgZ3uSsaGkv3K+LArGucffzUsLJtHtzY/VvKYWF5Q==
X-Received: by 2002:adf:fd45:: with SMTP id h5mr29202685wrs.388.1574024717892;
        Sun, 17 Nov 2019 13:05:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u16sm20897765wrr.65.2019.11.17.13.05.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Nov 2019 13:05:17 -0800 (PST)
Message-Id: <3771f7e2cb2187e8faa8e6f4f8fd585a20cbb0ba.1574024701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v5.git.1574024700.gitgitgadget@gmail.com>
References: <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
        <pull.434.v5.git.1574024700.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 17 Nov 2019 21:05:00 +0000
Subject: [PATCH v5 21/21] api-index: remove api doc index files
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
index 8fe829cc1b..28d8f68c9d 100644
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
@@ -97,7 +97,6 @@ TECH_DOCS += technical/shallow
 TECH_DOCS += technical/signature-format
 TECH_DOCS += technical/trivial-merge
 SP_ARTICLES += $(TECH_DOCS)
-SP_ARTICLES += technical/api-index
 
 ARTICLES_HTML += $(patsubst %,%.html,$(ARTICLES) $(SP_ARTICLES))
 HTML_FILTER ?= $(ARTICLES_HTML) $(OBSOLETE_HTML)
@@ -353,7 +352,7 @@ clean:
 	$(RM) *.texi *.texi+ *.texi++ git.info gitman.info
 	$(RM) *.pdf
 	$(RM) howto-index.txt howto/*.html doc.dep
-	$(RM) technical/*.html technical/api-index.txt
+	$(RM) technical/*.html
 	$(RM) SubmittingPatches.txt
 	$(RM) $(cmds_txt) $(mergetools_txt) *.made
 	$(RM) manpage-base-url.xsl
@@ -386,12 +385,8 @@ user-manual.xml: user-manual.txt user-manual.conf asciidoctor-extensions.rb GIT-
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

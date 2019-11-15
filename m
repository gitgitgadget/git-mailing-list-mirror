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
	by dcvr.yhbt.net (Postfix) with ESMTP id E25851F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 09:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfKOJyK (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 04:54:10 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55979 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfKOJyG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 04:54:06 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so9009783wmb.5
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 01:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gnKUVJ1lm2HEd10kicC0YvBZsIDgxI2dYQImyP93oT8=;
        b=WTFSpFR5wB7Q2LmFsHiwq/aA0RiICxoh+mvc+KC63LVf87b+5d8kCYZvhBcdOKwN5j
         142ZnHxPOs8wUoKiyr2OCdIWl+zu5o0H7EensohuPPsytfFKrEDP8dEFQtQMqTJCKNjQ
         2j8KS3VcNIpvYPalwCUbgxE7Sr8ZMNRNGrZMzGUps7vmBWJ5R+qorhgsegHvyTGu/uLJ
         iWIJwFDJJqQ73hCj2aG2DLylFzaYmuCGF4e/v+g34oGmI8PBgNVZxR0fNp8BUMIXwuef
         2+00pXz9ewbu7dSwx60YYxvKjGKAG/UyJoj7F2sA0io6F3kXV2SCoIoh5fmP3BoEOAA4
         aoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gnKUVJ1lm2HEd10kicC0YvBZsIDgxI2dYQImyP93oT8=;
        b=oWWppTt2ymGm/RORoEEkgQu/oyBQUwlc/QCrr51vijmj5x48JAAh3S9Jm1jmWjYov+
         Jw/eUrE48omuNRU85OZpfx2E1GgP8oLggCf0PoqF8DB36k1RMboALDejF/Q+GxhPDD5q
         2VuRoXFUk3jL+kI2WSTk4XlLkbsdpSO5dDxyC372X2KlYfemHyr3/kp7Zc4J798TIkSR
         UBybTX/5m+wTgLxHMQtCrtf2LzkkWccRmRtDtHH4vgHFMjm6XUWO1OESiPZ2dEPi6QI8
         hc56yP6Vu9Wwvhp9VCT4h5bVFDz4VjdblMG5tOrLvdYQ4mdtQjVdD95XrdV5ljCalY3g
         maEw==
X-Gm-Message-State: APjAAAV+EgAcorgAQTg5VMHu7pgwjNX+Tvt0UtkeEQl2ycUPh0CVd9lE
        Tlc+Wq/rhytc8CiR/1dR8YkJfVix
X-Google-Smtp-Source: APXvYqzV4NCMUQDxCVB/sBfAxMwebFHQsZ01kZL6dWcih07oAJuNjRpYW5K94eLPBcErhMR9e/bwrA==
X-Received: by 2002:a1c:3843:: with SMTP id f64mr12791822wma.129.1573811644698;
        Fri, 15 Nov 2019 01:54:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o81sm9774165wmb.38.2019.11.15.01.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 01:54:04 -0800 (PST)
Message-Id: <5f214173931afd39d595a51d796876b11f060f06.1573811627.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
References: <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
        <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 09:53:46 +0000
Subject: [PATCH v4 21/21] api-index: remove api doc index files
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

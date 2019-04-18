Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 487B020248
	for <e@80x24.org>; Thu, 18 Apr 2019 13:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388973AbfDRNQn (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 09:16:43 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42047 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388579AbfDRNQm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 09:16:42 -0400
Received: by mail-ed1-f67.google.com with SMTP id u23so1444824eds.9
        for <git@vger.kernel.org>; Thu, 18 Apr 2019 06:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DyI7MH/iUolCbhUpIzane0afk+05CRO/9vWkd0HAMfI=;
        b=Z1oNPFmrAW4n92Z/ezu7BmRZQjH0PCKx6uIPQhrGrVpZnni/fxBqFEP57rtzITC1qU
         C39o2qBbo6OjsFl2X/YPC6XcdxE/Auz5hmhXgr7cF/jIfBjoSjMMK+lDVCKz6S4JeId0
         OOqxJdPth/C5AUZCl3vkksVp8YRWr++LPPPRA3guOFr9SjKswBOnwQq38mps4q+nClv7
         wTmPZsnaejgCSeDJYYOWWU8IXWp9purYnsf7JS+i9jIdjb0y/FbJ/Gqb5n4z9YUWtx+3
         kbPk/uBCx7qFmAMHDXyv4i1ICrRpNYLNKgN8mDhiAEYSFhsp5o7SNlY1ntaHRkXTtlWF
         cV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DyI7MH/iUolCbhUpIzane0afk+05CRO/9vWkd0HAMfI=;
        b=ibTOggL7XKv6Qz3VcPVXHUuW0q5oCjQNeKvCNZjfXmdbvtHaKDqbGZUsh/Mbkd6b8t
         +eRtG5+jS5y52aay/VAtBtOdvUO2Nlb/11ARhJg+HO6vSIm7vEWSSWvZ0MTHPllK/gga
         BtsX1lcCQIXbTLUFeVrL79m2r1LxjMx2/I5CBpNuJ7hXR3+gf/pkTJTzKYH3EQhM6Q47
         sw/i1GysUIHe4EV3G3yD1Om5RSI+5SqDSXkd9vwCnzb43TfoSOQU9f1qW4Ciim8cDiW+
         A8lHQQI1K16QCDqv485eklymBQBeWlfJkRIX7KEZF11+U0iNUo4UiPck3xb1e4MnHN4G
         sz3g==
X-Gm-Message-State: APjAAAXzKQXjoDhhYf+OdCVt3JPoHnq3EYEO/bYTqw/oQq3K9TnL60Hq
        pitGam4lqVICVjRMTvoZmEAclMCT
X-Google-Smtp-Source: APXvYqzsnm3s/0CFp1j5ZhhaNDBMPQPgxfR3L/ybQkCGuWRpsvxGtwxmLFipqEpmSYho5KoVW2Xovw==
X-Received: by 2002:a17:906:b309:: with SMTP id n9mr51420592ejz.210.1555593400153;
        Thu, 18 Apr 2019 06:16:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm485973edt.93.2019.04.18.06.16.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 06:16:39 -0700 (PDT)
Date:   Thu, 18 Apr 2019 06:16:39 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Apr 2019 13:16:30 GMT
Message-Id: <fda0b10c84390d781d6d21a52c891dc5b54ef8d1.1555593396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.168.v2.git.gitgitgadget@gmail.com>
References: <pull.168.git.gitgitgadget@gmail.com>
        <pull.168.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/8] Makefile: drop the NO_INSTALL variable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The last user was just removed; There is no longer any need to carry it
around. Should we ever run into a need for it again, it is easy enough
to revert this commit.

It is unlikely, though, that we need `NO_INSTALL` again: as we saw with
the just-removed item, `git-remote-testgit`, we have better locations
to put executables and scripts that we do not want to install, e.g.
a subdirectory in `t/`, or `contrib/`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index 26f8ed2228..f5be2f633e 100644
--- a/Makefile
+++ b/Makefile
@@ -661,10 +661,6 @@ SCRIPT_SH_GEN = $(patsubst %.sh,%,$(SCRIPT_SH))
 SCRIPT_PERL_GEN = $(patsubst %.perl,%,$(SCRIPT_PERL))
 SCRIPT_PYTHON_GEN = $(patsubst %.py,%,$(SCRIPT_PYTHON))
 
-SCRIPT_SH_INS = $(filter-out $(NO_INSTALL),$(SCRIPT_SH_GEN))
-SCRIPT_PERL_INS = $(filter-out $(NO_INSTALL),$(SCRIPT_PERL_GEN))
-SCRIPT_PYTHON_INS = $(filter-out $(NO_INSTALL),$(SCRIPT_PYTHON_GEN))
-
 # Individual rules to allow e.g.
 # "make -C ../.. SCRIPT_PERL=contrib/foo/bar.perl build-perl-script"
 # from subdirectories like contrib/*/
@@ -674,11 +670,11 @@ build-sh-script: $(SCRIPT_SH_GEN)
 build-python-script: $(SCRIPT_PYTHON_GEN)
 
 .PHONY: install-perl-script install-sh-script install-python-script
-install-sh-script: $(SCRIPT_SH_INS)
+install-sh-script: $(SCRIPT_SH_GEN)
 	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-install-perl-script: $(SCRIPT_PERL_INS)
+install-perl-script: $(SCRIPT_PERL_GEN)
 	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-install-python-script: $(SCRIPT_PYTHON_INS)
+install-python-script: $(SCRIPT_PYTHON_GEN)
 	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 
 .PHONY: clean-perl-script clean-sh-script clean-python-script
@@ -689,9 +685,9 @@ clean-perl-script:
 clean-python-script:
 	$(RM) $(SCRIPT_PYTHON_GEN)
 
-SCRIPTS = $(SCRIPT_SH_INS) \
-	  $(SCRIPT_PERL_INS) \
-	  $(SCRIPT_PYTHON_INS) \
+SCRIPTS = $(SCRIPT_SH_GEN) \
+	  $(SCRIPT_PERL_GEN) \
+	  $(SCRIPT_PYTHON_GEN) \
 	  git-instaweb
 
 ETAGS_TARGET = TAGS
@@ -2683,7 +2679,6 @@ endif
 test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
 
 all:: $(TEST_PROGRAMS) $(test_bindir_programs)
-all:: $(NO_INSTALL)
 
 bin-wrappers/%: wrap-for-bin.sh
 	@mkdir -p bin-wrappers
@@ -2967,7 +2962,7 @@ rpm::
 
 artifacts-tar:: $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS) \
 		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(test_bindir_programs) \
-		$(NO_INSTALL) $(MOFILES)
+		$(MOFILES)
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) \
 		SHELL_PATH='$(SHELL_PATH_SQ)' PERL_PATH='$(PERL_PATH_SQ)'
 	test -n "$(ARTIFACTS_DIRECTORY)"
@@ -3016,7 +3011,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(OBJECTS)
 	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
-	$(RM) $(TEST_PROGRAMS) $(NO_INSTALL)
+	$(RM) $(TEST_PROGRAMS)
 	$(RM) $(FUZZ_PROGRAMS)
 	$(RM) -r bin-wrappers $(dep_dirs)
 	$(RM) -r po/build/
-- 
gitgitgadget


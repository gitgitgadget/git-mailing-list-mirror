Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 058C61F461
	for <e@80x24.org>; Thu, 18 Jul 2019 13:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390544AbfGRNTV (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 09:19:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53533 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390515AbfGRNTS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 09:19:18 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so25576233wmj.3
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 06:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=T5sC/K2nocoacN82eqyh9pXAZYpl+oGpqVWb7MKvpJg=;
        b=u1+zPFBB5ljuFEfuuOF8c9UuRLLfD0yFfF/O0v+C/eGRjvT3Rv6SoaThAbJU2YD5jr
         2ykz1o8EJ4vS/up5dZS/0I31oqFKwBs1goYdTmAO3zfFrLAJ8kdVGwylhFzweZhbo9qS
         tRXNEzzRL1MziTRxx9dJ8Fjx82bRDrZA1g3fYCxpn2KqOsVZOVHFMAC7EXftHi2FtwOt
         bwom2Ep/UNNpYQ+FeKVzpADucDJCFXxCuZe020loqH2frqczp4ggDwGY6jgQNh1TVJGH
         13yRmfsVrf9uhUI5/rJfD2UqWlI3Ze2OslCdymDsH1fWuV+0VW4N9Y4HWwd9CJAGXJxJ
         s9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=T5sC/K2nocoacN82eqyh9pXAZYpl+oGpqVWb7MKvpJg=;
        b=UfUGSYnzs+zXinWjcGQzB/yOzxUJZ78JiDS4J9gpspjsr0GrlRZPqSu38G9Ut+kvG2
         WE58efqz7dCUgOGCD7thrNb3fPDJcxTbPDqg4qX3W2ezlWSRXAE5V9aiC7wXFvKdPBlN
         epqgm3fpqoEbO4CdqQfNXDC9dlMhw+9s9seLeNQS6f7i4lwM2WQzW0tgH5dq+i/DRAHi
         9aZC7pV/2KSFzLP/KK9FZ+m7AvdNsl/Ep7as3xOfLWLDRM/zq+p0pvuv9c2tVQrghfgp
         EFD8Sc0wvFMZLuZCUZ5kZbTGT8L/ICXW05QOpcARLZr+9PvDOTWQeHs0eRR7b3341VF8
         PmxQ==
X-Gm-Message-State: APjAAAVXoIHRtAVObOvvFuSpoWDgjWyAtQu1GCr3rIUmZ33pRCkE3xrp
        pSkzZ7q5SywAhjF6WhelPK0dZZv9
X-Google-Smtp-Source: APXvYqyIhjg4EqDs1sE6u6JP1MwuN2fW351yKWg5i/kkl1uNxdVzlUhZi1r4ru+KE0ZUkbC0zBbhBw==
X-Received: by 2002:a1c:9a4b:: with SMTP id c72mr17230039wme.102.1563455955857;
        Thu, 18 Jul 2019 06:19:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u18sm22343689wmd.19.2019.07.18.06.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 06:19:15 -0700 (PDT)
Date:   Thu, 18 Jul 2019 06:19:15 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jul 2019 13:18:57 GMT
Message-Id: <971247e32056a564161e10d05237c41d041e7ff8.1563455939.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 22/24] bin-wrappers: append `.exe` to target paths if
 necessary
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When compiling with Visual Studio, the projects' names are identical to
the executables modulo the extensions. Read: there will exist both a
directory called `git` as well as an executable called `git.exe` in the
end. Which means that the bin-wrappers *need* to target the `.exe` files
lest they try to execute directories.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 98a0588416..3716dadc08 100644
--- a/Makefile
+++ b/Makefile
@@ -2717,7 +2717,7 @@ bin-wrappers/%: wrap-for-bin.sh
 	@mkdir -p bin-wrappers
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
-	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%,$(@F))|' < $< > $@ && \
+	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%$(X),$(@F))$(patsubst git%,$(X),$(filter $(@F),$(BINDIR_PROGRAMS_NEED_X)))|' < $< > $@ && \
 	chmod +x $@
 
 # GNU make supports exporting all variables by "export" without parameters.
-- 
gitgitgadget


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25AF31FAF4
	for <e@80x24.org>; Mon,  6 Feb 2017 03:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753200AbdBFDl2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 22:41:28 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35967 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752420AbdBFDl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 22:41:27 -0500
Received: by mail-pg0-f67.google.com with SMTP id 75so7847826pgf.3
        for <git@vger.kernel.org>; Sun, 05 Feb 2017 19:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=A1z7vNh2sf/FA33TrHJqdAVf2Hcmbc4yw3c3WzxTiQQ=;
        b=oAsaqIuuNFxMZ1hdfynrGuUJslqeoBV8Sb7qPogDD/uXXSqdxcUg91wP/Y4i9v84np
         Vr4Shh4HlwNRa5EIMfTDqoCE3ZmExgWtnkMxmNoNHxzdjoR+9edTQXw5uqIUG7UyQitL
         jM+UiSN8jJK0aFvH4NcDQLhVl8FHAHbqBt1IsT5X3caTu4owk4AtpUJ9B9t5a8S/HZT/
         HAlqtAkY+d37H5AORznHr2P1O3qnMsSdCIswHkpkplatg7c51mNlY5DWJR7VkzzWpxt5
         Imgh1ezEIMwRBISWZ5i7s49I+ARm4c29CW3ucL+XD28aZqSksvFJTPDFoFUdJu2I0MKk
         Aimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=A1z7vNh2sf/FA33TrHJqdAVf2Hcmbc4yw3c3WzxTiQQ=;
        b=sDQc9juR2qo+1gtFlWGjEsc+VCF+FKRk9BZHUe4jmycKWK7js96eNNhYTnb1zhDKA7
         cNQOJg3NHWP18+y+SRTYXHU0o/gFYgcJuHxaOvS+fkia6D5/Pm+MENyzdVBv51BxHJta
         3RY1hXsQJhbcZMZRAXPgXSZPOn5VW31FV9sH8tGJv8QnC6lPKNGa51w/IOUEdSvgI4Og
         YV/QkNU7s3x4c7z2bl9r3l1C7xGIvxa2SxZFU5mMdUAZFMHOlJazHufo7oLQ2IFm3pmm
         SiNuChcOZ+1oOgMC6sWeMXvLlpAJDVPC9WofAGVVs/zSiktXFjl1VDk7/hmgXM3wFQx5
         SAXg==
X-Gm-Message-State: AIkVDXJ9JGI33FTxPg7OcaLHl+GialhBMATGXdDdSrxV+WTGtpxAay9FORlWvlRfOR3L8Q==
X-Received: by 10.98.214.209 with SMTP id a78mr10709662pfl.6.1486352486831;
        Sun, 05 Feb 2017 19:41:26 -0800 (PST)
Received: from arch-attack.localdomain (c-50-152-192-15.hsd1.ca.comcast.net. [50.152.192.15])
        by smtp.gmail.com with ESMTPSA id s136sm84763493pgc.38.2017.02.05.19.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Feb 2017 19:41:26 -0800 (PST)
Date:   Sun, 5 Feb 2017 19:41:18 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com
Subject: [PATCH] Document the --no-gui option in difftool
Message-ID: <20170206034118.GA29517@arch-attack.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prior to this, the `--no-gui` option was not documented in the manpage.
This commit introduces this into the manpage

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-difftool.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 224fb3090..a2661d9cc 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -87,9 +87,11 @@ instead.  `--no-symlinks` is the default on Windows.
 
 -g::
 --gui::
+--no-gui::
 	When 'git-difftool' is invoked with the `-g` or `--gui` option
 	the default diff tool will be read from the configured
-	`diff.guitool` variable instead of `diff.tool`.
+	`diff.guitool` variable instead of `diff.tool`. The `--no-gui`
+	option can be used to override this setting.
 
 --[no-]trust-exit-code::
 	'git-difftool' invokes a diff tool individually on each file.
-- 
2.12.0.rc0.208.g81c5d00b2


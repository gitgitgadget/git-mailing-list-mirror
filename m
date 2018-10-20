Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2619E1F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeJTUtt (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:49:49 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45148 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeJTUts (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:49:48 -0400
Received: by mail-lf1-f65.google.com with SMTP id c24-v6so676800lfi.12
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QCWKJ8Sk/UAJaxmd0XDTrMTYje1y+4CsrWry0fLXqJQ=;
        b=jtlyaVzFKSacg34COkHqlFXESS0oCDNHRB1KaimsNAIWsS82goW56QB2EIBrXohz95
         2QsdE77jNFqNttLsujbbjHGCpoHA+u5CI0VZng4Yv3fSZ3mKPgzIE+A3oW5yy7kDAZC8
         cS8TA//fW9j82G2Pr6FEQjVVuKjJIPgi0dY6ZnKlrNVKDgVDo006HBaRqDH1a2s9Q4DI
         1fT7L2AE2c7gb11xwZhgF1XPoPkDRnEsGcws784f9vyd4HDYy3c5TLsNwZDWjHEUzHet
         1IIa7B30VyYIKj6ELZ+hWZszXGL9i1lgK1dD24YN58h1fcn4bqVvUr10ZQtsrQZ5bl81
         9mCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QCWKJ8Sk/UAJaxmd0XDTrMTYje1y+4CsrWry0fLXqJQ=;
        b=d1Ag6QqFjcSEuoQTL7Wdr3/3qahjmogVY8qKOjQq87w6Z2oQ9BRQaav9MnEPPrpOJK
         VY66uVZbTRCOXZqhtaBV5yhW9wa+4pwha0J+ubilOqlEFEoecuBwuRkdZilPHoCa5B6V
         SO+PXvNBHiK/B1UlUuwHgo4uVWdgXxijmghBvFutzxGw2TjuZgc/k5MbI/hTmKvr3ONK
         usnNVQ8KsonWBN1W+zW9xJvZRCaJp6rz4aPnp9zwLgn64IHD6iJ1vOiYZMthHjrH5M7K
         6fPtEd3kQGnyHrDmydkEntFoAVJwN/VCRVA9DhECRxangNpPe0ryKGFgnJT3RLfuxCTE
         0YTA==
X-Gm-Message-State: ABuFfoj+YR5cF+0WDYEJy4f2nDdO4UMZSAG+tz/3LfBb0tIcktWWHnH5
        pMo5n1nlJq8PCtseExMlUqRJHgwU
X-Google-Smtp-Source: ACcGV61QuV7CbgtkX58JAbuNVQpvdTB8xKYNIOsd16l7aDaZQTKvl1m4LE9PXax4ScYBTNw2zWlcjA==
X-Received: by 2002:a19:750e:: with SMTP id y14-v6mr1122715lfe.43.1540039166055;
        Sat, 20 Oct 2018 05:39:26 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:25 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 23/59] config.txt: move grep.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:12 +0200
Message-Id: <20181020123848.2785-24-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181020123848.2785-1-pclouds@gmail.com>
References: <20181020123848.2785-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt      | 25 +------------------------
 Documentation/grep-config.txt | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/grep-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6898c9f567..3065520a7f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -339,30 +339,7 @@ include::gitcvs-config.txt[]
 
 include::gitweb-config.txt[]
 
-grep.lineNumber::
-	If set to true, enable `-n` option by default.
-
-grep.column::
-	If set to true, enable the `--column` option by default.
-
-grep.patternType::
-	Set the default matching behavior. Using a value of 'basic', 'extended',
-	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
-	`--fixed-strings`, or `--perl-regexp` option accordingly, while the
-	value 'default' will return to the default matching behavior.
-
-grep.extendedRegexp::
-	If set to true, enable `--extended-regexp` option by default. This
-	option is ignored when the `grep.patternType` option is set to a value
-	other than 'default'.
-
-grep.threads::
-	Number of grep worker threads to use.
-	See `grep.threads` in linkgit:git-grep[1] for more information.
-
-grep.fallbackToNoIndex::
-	If set to true, fall back to git grep --no-index if git grep
-	is executed outside of a git repository.  Defaults to false.
+include::grep-config.txt[]
 
 gpg.program::
 	Use this custom program instead of "`gpg`" found on `$PATH` when
diff --git a/Documentation/grep-config.txt b/Documentation/grep-config.txt
new file mode 100644
index 0000000000..44abe45a7c
--- /dev/null
+++ b/Documentation/grep-config.txt
@@ -0,0 +1,24 @@
+grep.lineNumber::
+	If set to true, enable `-n` option by default.
+
+grep.column::
+	If set to true, enable the `--column` option by default.
+
+grep.patternType::
+	Set the default matching behavior. Using a value of 'basic', 'extended',
+	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
+	`--fixed-strings`, or `--perl-regexp` option accordingly, while the
+	value 'default' will return to the default matching behavior.
+
+grep.extendedRegexp::
+	If set to true, enable `--extended-regexp` option by default. This
+	option is ignored when the `grep.patternType` option is set to a value
+	other than 'default'.
+
+grep.threads::
+	Number of grep worker threads to use.
+	See `grep.threads` in linkgit:git-grep[1] for more information.
+
+grep.fallbackToNoIndex::
+	If set to true, fall back to git grep --no-index if git grep
+	is executed outside of a git repository.  Defaults to false.
-- 
2.19.1.647.g708186aaf9


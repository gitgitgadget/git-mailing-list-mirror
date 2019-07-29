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
	by dcvr.yhbt.net (Postfix) with ESMTP id 57AF11F462
	for <e@80x24.org>; Mon, 29 Jul 2019 20:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbfG2UIQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 16:08:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37821 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730243AbfG2UIM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 16:08:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so38119372wrr.4
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 13:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kXc66PEqxg+GbFYsh0oZ7XdTgPZq9GqHCXpd+lonCGA=;
        b=Ce3fTtUIO6bdnshZ2rWsAAi5NNs8x9hNY1VHzKgK40/8liWBQySBlcAyG3bULJf75X
         WLQRA/DgQPnMdj77mit2GGu55Gs1jbzcGXxwW/wt+Dgalm6hQQ8ih3Mo1V7v9PNwZVQW
         baJTnYwdO+smUb58HhUixVAbz4VuLsblpB4ySQZVRIo0BGMQ2JjxM7J7yOvVejBF3VCX
         3xN6aAl8v4D2PfkAjqIvCjYWu5Jv6u1Vl4sjZrzztKUVAk/bsByPVfvcGCvynjVNX+yO
         0s9SBH/ZeQhCPCsPHQ15B8yZZLdbCOZxid3jEBPFYvaanViqA8JTE4xaYbs6erlaSl2W
         gJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kXc66PEqxg+GbFYsh0oZ7XdTgPZq9GqHCXpd+lonCGA=;
        b=ekI1gBssrCMZ4MyRZR4GLRyBIgFonMg+e4NEUzz6OzBsKKO0OPPhEYTe+A7jEWjY50
         QWAFXIhyHNRn7WxY0Y2i1bUfNQ6UPJDXcnZCPADxULJuOC/IGcKQLfpGV7OPL+4A7o6R
         w3TbYj+hUR7t8K6pCo8TCuhMuTg9MTa42sbzXhVGJ1DuDZxvYiyS6xZpLeZxtu3rz34a
         +9hMprajF4hO+UJVuM29Yp7GDZ+wa16XH9N3qEoNV2IH2hl/MqkSP/E9W5mMoBdpcYyd
         J92+pJY+jy12cOIE/CYgs6MYIVxSzCNqqD0qjZVErZvkE+4tX6LPWSBDP5WCGQxyFzrT
         dejA==
X-Gm-Message-State: APjAAAULzgMVO05ZiV5wsY/md0kqAjeE90UCt3aDIWzHQWSPBBE9Y8Gr
        FeiERxcG1oTM9ah1khXab5XFPBRl
X-Google-Smtp-Source: APXvYqwJ4rgAXTK+TY7EcUum+YFb4Xo3hRqKgkUdyM2woyl7Gof6xfmpEOipuh45UeXqOizry5uSVw==
X-Received: by 2002:a5d:46d1:: with SMTP id g17mr69392542wrs.160.1564430890496;
        Mon, 29 Jul 2019 13:08:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s12sm57401776wmh.34.2019.07.29.13.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:08:10 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:08:10 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Jul 2019 20:07:50 GMT
Message-Id: <052a98b8bb8aef572cba41dbdaf15a7b987b8270.1564430879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.v2.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
        <pull.287.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 14/23] contrib/buildsystems: handle libiconv, too
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

Git's test suite shows tons of breakages unless Git is compiled
*without* NO_ICONV. That means, in turn, that we need to generate
build definitions *with* libiconv, which in turn implies that we
have to handle the -liconv option properly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/engine.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index d613277595..c35844a0c7 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -347,6 +347,8 @@ sub handleLinkLine
             push(@libs, "ssleay32.lib");
         } elsif ("$part" eq "-lcurl") {
             push(@libs, "libcurl.lib");
+        } elsif ("$part" eq "-liconv") {
+            push(@libs, "libiconv.lib");
         } elsif ($part =~ /^-/) {
             push(@lflags, $part);
         } elsif ($part =~ /\.(a|lib)$/) {
-- 
gitgitgadget


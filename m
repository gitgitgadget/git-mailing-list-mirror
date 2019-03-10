Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE37C20248
	for <e@80x24.org>; Sun, 10 Mar 2019 15:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfCJPPC (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 11:15:02 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39074 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfCJPPC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 11:15:02 -0400
Received: by mail-lj1-f196.google.com with SMTP id g80so1859666ljg.6
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 08:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cY/FZcaHuvJhu3rd71bsbVN4FHPi71y8DfLxkTX8Lzs=;
        b=LqyqaFjmNhZz15TrtVRAS0T8wMMDL4PTk29q1U7HtIfGSosaX/yXEs5ST9Xlb5DJFU
         Z6bzDmVPmnfTepGQ1oRjY0dbw0HgbqiBrfxEsqleinPGarRJA8ak9GdoinoNN+xquGGn
         rrupXyV9Zgl+QXjlgYuGcNNIbnXVqyR1bPIAZpC1FaoWEqFyvRdKPkB4Wdsv+0+njxoC
         +Hv3BLQUNAin4yzlENRKA3vDryQRajF8yWBYyXC3+peiW2/bN/PtybOfwxC2NbUJMV/k
         tmngO1yxXMIZQvIdOvGd09pGBMK+RVcd4WObHvwqX5NHkgs1yNWzDRfUbANx37J0ecZR
         Z9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cY/FZcaHuvJhu3rd71bsbVN4FHPi71y8DfLxkTX8Lzs=;
        b=IJnCvLvAh3SYdqr0V32hwDh3WApEXiLjNEv0BEHKYC78wP36hOf2gjp+g9EUy+Yl/Q
         7sePmliEFxBuHEYnclA0qgb02VUW5/Ibt1obtoGz0vScYM+1+w3Cp8q99UtoyqqiJMIw
         oBoyVyqCoZOtmKCzvgbJwWpCsTKxaMBNV0v36273yw6dYmgZTGCfp+XcXWdDpP0xaAWG
         AGHTO2qobHj/2mlvr6+QYfV+SDfps2Oejuq3A/nhVllupxwceVZ4Egg4/40Ag41A2aSQ
         mDRdnHuPlQlvKjZB4d6dUdSz+DqP65FFp7uidCYsG6jXw6LDWmootRYHVypSJdQaGldS
         v9Jw==
X-Gm-Message-State: APjAAAWSk3wtBPjgT2uqdVK7VP5kVZHfxyMaQwiAY4GgMIGKmYa9KRdW
        nngWxcSdaoSYgge/UvMDira98stF
X-Google-Smtp-Source: APXvYqzQipPiGcdDAIxBVmw94pjJfBGVY6qiAeRzhj4DqGeZCSgSpuf+pLHNYglIT3vg2652H8Iupg==
X-Received: by 2002:a2e:9150:: with SMTP id q16mr14274938ljg.18.1552230899244;
        Sun, 10 Mar 2019 08:14:59 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id v20sm568292ljv.83.2019.03.10.08.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 08:14:58 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/2] asciidoctor-extensions: fix spurious space after linkgit in *.html
Date:   Sun, 10 Mar 2019 16:14:24 +0100
Message-Id: <bd8e8706fd30db7200c32570acf4aa3e5ca3fbbf.1552230490.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1552230490.git.martin.agren@gmail.com>
References: <xmqqmumc3g1h.fsf@gitster-ct.c.googlers.com> <cover.1552230490.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I really should have caught this when I wrote c3b4efa030
("asciidoctor-extensions: fix spurious space after linkgit",
2019-02-27). Turns out that when we create html-files, we take a
different path through this macro. So similar to c3b4efa030, we need to
drop a "\n" which turns into a space before punctuation.

Just like with c3b4efa030, note that if what follows is a word, not
punctuation, the white space renders just fine. So constructions such as
"see linkgit:foo[1] for more" still render as intended.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index f7a5982f8b..0089e0cfb8 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -11,7 +11,7 @@ module Git
       def process(parent, target, attrs)
         if parent.document.basebackend? 'html'
           prefix = parent.document.attr('git-relative-html-prefix')
-          %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>\n)
+          %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
         elsif parent.document.basebackend? 'docbook'
           "<citerefentry>\n" \
             "<refentrytitle>#{target}</refentrytitle>" \
-- 
2.21.0


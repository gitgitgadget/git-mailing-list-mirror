Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 589E21F463
	for <e@80x24.org>; Tue, 24 Sep 2019 10:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409534AbfIXKkc (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 06:40:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53796 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409515AbfIXKkc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 06:40:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id i16so1646710wmd.3
        for <git@vger.kernel.org>; Tue, 24 Sep 2019 03:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WA8SCjGLFYbRLJlun6Gu0ilRfkuEZ2Fn4uM/ns3lZZo=;
        b=F1V/sCi2XbPcy1unsIDlVE/D01WblfBbB2u1M7tlmNUJCV1Z0TVUKG8zERZtmeJcUz
         Zj4HRh7hb6EQBaEaFZZuoXGqtPtqPVhdRZp2/GQ9mDfkCaEJDu9RW2ARg4ogr1wU5yE6
         MoHbKfZ56EgdSgJqLefcu2PYEDp8JDlIeT9QxHGEajoR8dhcktZt3r/myENMvhBdG1HW
         urG6Y4Zq9/wbNjkbCzvC6bN7YD7PUvTg/asq1IoYIPLpDaZrmgqQwmwZ7MvZkpSccwCr
         0EMgEl1/M1udI0fgo8b6dcBcJ7kYtJrlSbGViG9xqo6Ri2M79PWi8AcpvEkXyZuVHnjO
         Sd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WA8SCjGLFYbRLJlun6Gu0ilRfkuEZ2Fn4uM/ns3lZZo=;
        b=IVt3oqPdm9ETg27o3lu1Nths70dPZf0OO4rfEyCJZzHMhav9khjfLVIEzyMt8oFJND
         6uxKkw+L3e1Wo8AW+la+LYkOMFXfo7TsmVNDI8yhYL68rSxSHmcozPaHD25IgUPFBnrM
         i3X07YxGi618izmZ84Ur2jzjvIJ/klrix6Rl8oAaCNkk16yvYRRtYd0b5v4aJDgcLw2j
         oo8gZ6wv+jhs34LHmBPCXe0DJ8lirqieg1Ots540fvHLZp+isTNQZhPs7bniRCyXpDZ0
         ntYEn6J8cOdOxwDJxsDDfjLQ1SWUwTjzkfkeRHLYiOGx4gvIy1zuhU0oybG0dXEihnjf
         TXAg==
X-Gm-Message-State: APjAAAVXDczxmuNZ/7u8oBtcgeu1b/Bla9YbKsyRH5sT7rSvg4hT5mSD
        x2A+34XzQKAhgDRhqN+b+ucxeCP1
X-Google-Smtp-Source: APXvYqyrfNQg/HhMdIKESp7KMVUu3t0sUNEfqGNrLojDWW+vginktfMtgAS8C/UJ82rnT546izKi1w==
X-Received: by 2002:a7b:c3d8:: with SMTP id t24mr2046420wmj.159.1569321630891;
        Tue, 24 Sep 2019 03:40:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x6sm1886342wmf.35.2019.09.24.03.40.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 03:40:30 -0700 (PDT)
Date:   Tue, 24 Sep 2019 03:40:30 -0700 (PDT)
X-Google-Original-Date: Tue, 24 Sep 2019 10:40:28 GMT
Message-Id: <e4410274e61f17d6f162a9218138cd2e56de7b7b.1569321628.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.347.v3.git.gitgitgadget@gmail.com>
References: <pull.347.v2.git.gitgitgadget@gmail.com>
        <pull.347.v3.git.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 2/2] t0028: add more tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

After I discovered that UTF-16-LE-BOM test was bugged, I decided that
better tests are required. Possibly the best option here is to compare
git results against hardcoded ground truth.

The new tests also cover more interesting chars where (ANSI != UTF-8).

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 t/t0028-working-tree-encoding.sh | 39 ++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 5493cf3ca9..c4d98a1aae 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -280,4 +280,43 @@ test_expect_success ICONV_SHIFT_JIS 'check roundtrip encoding' '
 	git reset
 '
 
+# $1: checkout encoding
+# $2: test string
+# $3: binary test string in checkout encoding
+test_commit_utf8_checkout_other () {
+	encoding="$1"
+	orig_string="$2"
+	expect_bytes="$3"
+	
+	test_expect_success "Commit UTF-8, checkout $encoding" '
+		test_when_finished "git checkout HEAD -- .gitattributes" &&
+		
+		test_ext="commit_utf8_checkout_$encoding" &&
+		test_file="test.$test_ext" &&
+		
+		# Commit as UTF-8
+		echo "*.$test_ext text working-tree-encoding=UTF-8" >.gitattributes &&
+		printf "$orig_string" >$test_file &&
+		git add $test_file &&
+		git commit -m "Test data" &&
+
+		# Checkout in tested encoding
+		rm $test_file &&
+		echo "*.$test_ext text working-tree-encoding=$encoding" >.gitattributes &&
+		git checkout HEAD -- $test_file &&
+		
+		# Test
+		printf $expect_bytes >$test_file.raw &&
+		test_cmp_bin $test_file.raw $test_file
+	'
+}
+
+test_commit_utf8_checkout_other "UTF-8"        "Test Тест" "\124\145\163\164\040\320\242\320\265\321\201\321\202"
+test_commit_utf8_checkout_other "UTF-16LE"     "Test Тест" "\124\000\145\000\163\000\164\000\040\000\042\004\065\004\101\004\102\004"
+test_commit_utf8_checkout_other "UTF-16BE"     "Test Тест" "\000\124\000\145\000\163\000\164\000\040\004\042\004\065\004\101\004\102"
+test_commit_utf8_checkout_other "UTF-16LE-BOM" "Test Тест" "\377\376\124\000\145\000\163\000\164\000\040\000\042\004\065\004\101\004\102\004"
+test_commit_utf8_checkout_other "UTF-16BE-BOM" "Test Тест" "\376\377\000\124\000\145\000\163\000\164\000\040\004\042\004\065\004\101\004\102"
+test_commit_utf8_checkout_other "UTF-32LE"     "Test Тест" "\124\000\000\000\145\000\000\000\163\000\000\000\164\000\000\000\040\000\000\000\042\004\000\000\065\004\000\000\101\004\000\000\102\004\000\000"
+test_commit_utf8_checkout_other "UTF-32BE"     "Test Тест" "\000\000\000\124\000\000\000\145\000\000\000\163\000\000\000\164\000\000\000\040\000\000\004\042\000\000\004\065\000\000\004\101\000\000\004\102"
+
 test_done
-- 
gitgitgadget

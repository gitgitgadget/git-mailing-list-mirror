Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97DC31F462
	for <e@80x24.org>; Sat,  8 Jun 2019 14:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfFHOnq (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jun 2019 10:43:46 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43665 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfFHOnq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jun 2019 10:43:46 -0400
Received: by mail-ed1-f68.google.com with SMTP id w33so6878428edb.10
        for <git@vger.kernel.org>; Sat, 08 Jun 2019 07:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q0+YoSHRj4i59Hq5zqHYovA23h9TjLTOKx8r65OjhV0=;
        b=d/15x5Q3C3QV+bBGIjHF6EW33bpVaOOWgP3QOy2Ss1BcsWrC9YGzPrpnZE1Jl59M0L
         sst0c0rjBdaUR6dEAeut3ezDE0ho99fM29UW5mnprRCdh5vKOlaCORMQtyEAoLgzfJ/D
         Obl334yZnUXlcmoRjcQyi/wE4/wNargNTeH+TTDHQOp1wWLgMAo3T543ne7uDwj6yMBL
         XqXnZFbmqVTgGfVafq86bBeCMFRAr8yOVUQ458Tk8ZXV4/naWx9mhbZF7Me2XyEX7C6x
         SfkUpfFoLHkYsYYb8EUC/fUkLHI/bENhju1MLZ3Tym7sZ3Qc3y9hda0Q5a1KkKs/UMgG
         Z93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q0+YoSHRj4i59Hq5zqHYovA23h9TjLTOKx8r65OjhV0=;
        b=lttqYqVVyjvGGFmWIB9mRyDFi7w3yzeU9YI9EALYsdJKamOftwre+YL+iw6FAKo6//
         E7jf2b0rdFZF2t8P0gGDiI8TBQL24e+kB2qCt/5lr8CM94fZ4+uNzb4M1IQIOpX3fx5f
         SF4c86zdOF2oFr9UedA2VCUgzOoGTd8H7lK8i+cL/fqAbj9qJ1R1CNKdMyLiDMMcFcIv
         HxIvdsJWnfecdRyeoZgZS//I2JW07KNoP6iHz+0A+ASzmUgnQCvrZdD88jt0gfYlb+EC
         0r1DpY+tT0DcySUQR1SQI82H+Gx6bAv/eo1jeBOoDQE/QO2aakWUWZVEz2cRwTQq3GQc
         Gt4A==
X-Gm-Message-State: APjAAAWvudWQxqqw+Yp6NNVVc8kKVLwwifnxjFQTNO83IqoMTHSLGT6q
        0b+3mYdsvm6QXZJV/KUMqW4XmpHB
X-Google-Smtp-Source: APXvYqxLsH6MArIdpCjtFmgXu1KXwZhORObSuZvzUJm9Si5QijwhNAKNFDE5QYx+z2fCM2ccsgGwDg==
X-Received: by 2002:a17:906:c106:: with SMTP id h6mr5609545ejz.112.1560005024242;
        Sat, 08 Jun 2019 07:43:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b6sm1317015edi.72.2019.06.08.07.43.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 07:43:43 -0700 (PDT)
Date:   Sat, 08 Jun 2019 07:43:43 -0700 (PDT)
X-Google-Original-Date: Sat, 08 Jun 2019 14:43:42 GMT
Message-Id: <1dd56d034efb6ff251bdac8d099052175f4777a0.1560005022.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.151.git.gitgitgadget@gmail.com>
References: <pull.151.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] t0001: fix on case-insensitive filesystems
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

On a case-insensitive filesystem, such as HFS+ or NTFS, it is possible
that the idea Bash has of the current directory differs in case from
what Git thinks it is. That's totally okay, though, and we should not
expect otherwise.

Reported by Jameson Miller.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0001-init.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 42a263cada..f54a69e2d9 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -307,10 +307,20 @@ test_expect_success 'init prefers command line to GIT_DIR' '
 	test_path_is_missing otherdir/refs
 '
 
+downcase_on_case_insensitive_fs () {
+	test false = "$(git config --get core.filemode)" || return 0
+	for f
+	do
+		tr A-Z a-z <"$f" >"$f".downcased &&
+		mv -f "$f".downcased "$f" || return 1
+	done
+}
+
 test_expect_success 'init with separate gitdir' '
 	rm -rf newdir &&
 	git init --separate-git-dir realgitdir newdir &&
 	echo "gitdir: $(pwd)/realgitdir" >expected &&
+	downcase_on_case_insensitive_fs expected newdir/.git &&
 	test_cmp expected newdir/.git &&
 	test_path_is_dir realgitdir/refs
 '
@@ -365,6 +375,7 @@ test_expect_success 're-init to update git link' '
 	git init --separate-git-dir ../surrealgitdir
 	) &&
 	echo "gitdir: $(pwd)/surrealgitdir" >expected &&
+	downcase_on_case_insensitive_fs expected newdir/.git &&
 	test_cmp expected newdir/.git &&
 	test_path_is_dir surrealgitdir/refs &&
 	test_path_is_missing realgitdir/refs
@@ -378,6 +389,7 @@ test_expect_success 're-init to move gitdir' '
 	git init --separate-git-dir ../realgitdir
 	) &&
 	echo "gitdir: $(pwd)/realgitdir" >expected &&
+	downcase_on_case_insensitive_fs expected newdir/.git &&
 	test_cmp expected newdir/.git &&
 	test_path_is_dir realgitdir/refs
 '
-- 
gitgitgadget

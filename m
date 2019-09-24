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
	by dcvr.yhbt.net (Postfix) with ESMTP id D61581F463
	for <e@80x24.org>; Tue, 24 Sep 2019 10:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409530AbfIXKkc (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 06:40:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51365 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409505AbfIXKkc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 06:40:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so1655147wme.1
        for <git@vger.kernel.org>; Tue, 24 Sep 2019 03:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I7Muowv9RdCxz1lwn/XZfC1suFePJY/t0D1gzi3v2N4=;
        b=u8mUs2yPRDVNG5tCEZ6+AzqYTco9RESC8rfd2EGFMOqrQTtd6mbDQ+XfXQnBK+RFbT
         mSDMBZvFuRBs8lowBlbD9q7HrHVxn4QuznGpwl8/HkZWysJEBcJZ9I/ARb9ITz39o1Rd
         +JfX3b8kw09aLTbWmljSjZLjCIPuDgl1JgNNf1OWBKDQlWTN2gaCJco/66tZwktbu5Xm
         Q05PydB+YjLEzWUZm27t4lO0VBMKFIG7Tz8y+PzUpVSnvv8jZTDl7hmWfTVEAC5Yiwvw
         BL40svnjtBpMfe9aDwZ/1Q7NAP63h8lWAkRtkr1rv/pv+N7ZPf07KNXYRsQdohbMNXF5
         6dHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I7Muowv9RdCxz1lwn/XZfC1suFePJY/t0D1gzi3v2N4=;
        b=ufUs8oNClmxGzUGEkuDDSxhucYow3TvFDapl4LWu0dDSL6TrADOo2+BU9IoGyl1u4Y
         3J9QLuuoX3fELzs7MA6tnsEVcuB8R6SPHAOURPKOueJyYTZm6pV7RcjZ+l+h660hSpzl
         Txt8c6cSbEe2K7wVb4/Ut0DmNqoloHCOcTXrqj3YQCGXN+iB4ERgKmZWwfNA2TlijsUo
         XdWtcvmGz4d66Xy2DAXCfIkFwvBpVnlaznyyrrKBpZeMtrgo2l6R3D25A2uUcFCUPPhR
         5umEFuQnnsOBGGndgb9IXHFRVWSB0e264pnyJ4osWGSd57wl78HS/M+/eL7F4+q/crvx
         sW7Q==
X-Gm-Message-State: APjAAAXKuohzW2Ju9k+D5cAi6hyRCAo7XzHDKmhA7eZ7baj3qYPgGbgb
        GyHkVo/BMM881I9QVJL3cGtUpATN
X-Google-Smtp-Source: APXvYqwRY7rPP2JC2OWyyQbm70+L9bv2QxmVgM4tWHS+jP8GhuCfWSGZJ6xqgZ5VeUIS04pJAcHaAw==
X-Received: by 2002:a05:600c:2311:: with SMTP id 17mr2086277wmo.39.1569321630105;
        Tue, 24 Sep 2019 03:40:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s12sm3940029wra.82.2019.09.24.03.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 03:40:29 -0700 (PDT)
Date:   Tue, 24 Sep 2019 03:40:29 -0700 (PDT)
X-Google-Original-Date: Tue, 24 Sep 2019 10:40:27 GMT
Message-Id: <438ac961a559b656326ebef0b3a7cf924f4ccfd2.1569321628.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.347.v3.git.gitgitgadget@gmail.com>
References: <pull.347.v2.git.gitgitgadget@gmail.com>
        <pull.347.v3.git.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 1/2] t0028: fix test for UTF-16-LE-BOM
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

According to its name, the test is designed for UTF-16-LE-BOM.
However, possibly due to copy&paste oversight, it was using UTF-32.

While the test succeeds (extra \000\000 are interpreted as NUL),
I myself had an unrelated problem which caused the test to fail.
When analyzing the failure I was quite puzzled by the fact that the
test is obviously bugged. And it seems that I'm not alone:
https://public-inbox.org/git/CAH8yC8kSakS807d4jc_BtcUJOrcVT4No37AXSz=jePxhw-o9Dg@mail.gmail.com/T/#u

Fix the test to follow its original intention.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 t/t0028-working-tree-encoding.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 1090e650ed..5493cf3ca9 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -40,7 +40,7 @@ test_expect_success 'setup test files' '
 	printf "$text" | write_utf16 >test.utf16.raw &&
 	printf "$text" | write_utf32 >test.utf32.raw &&
 	printf "\377\376"                         >test.utf16lebom.raw &&
-	printf "$text" | iconv -f UTF-8 -t UTF-32LE >>test.utf16lebom.raw &&
+	printf "$text" | iconv -f UTF-8 -t UTF-16LE >>test.utf16lebom.raw &&
 
 	# Line ending tests
 	printf "one\ntwo\nthree\n" >lf.utf8.raw &&
-- 
gitgitgadget


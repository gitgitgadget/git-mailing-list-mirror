Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 933171F597
	for <e@80x24.org>; Fri,  3 Aug 2018 17:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeHCTj0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 15:39:26 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42570 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbeHCTjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 15:39:25 -0400
Received: by mail-pl0-f68.google.com with SMTP id z7-v6so2853320plo.9
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 10:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jTTvzwVdH9r+sX8kHvpDgV9GDztZ2ZvJi/0rPxOjMKY=;
        b=aCEXiEI2Y5IaMPW04b1Zeq6m9zNBV0gKb0/mzYP8AisQwsIksqhBmky9BDnOyiHaUe
         bIEqP+8WSQHFalcFxOOFVt01YXjXMeB7v9Z5TLMhwNKNs1rmsQfjwTtlYsCHadJwDvOK
         ti6tIoJmx29cmw2TTJhkM79et9/hzfU153Nl4lu1Ud6SoUYcsFVnWO/lET8YMRsoXLNz
         Vpf2m87a4Z7n/vcJoHQNbzNVHMfajqc08plsHJvTa9hlBufhZn5cKQNlJkUBJcPwkRdV
         Z85bUbwUrCFzMNkO1EKNahN7M6K+UPnBOzZ1aTHPdS6sBd1DtSsgdYRrHCx1wOYpYKD/
         1caA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jTTvzwVdH9r+sX8kHvpDgV9GDztZ2ZvJi/0rPxOjMKY=;
        b=Jf4OW5qM/xGE1T1Q2thMA7jjqLF6hufR/QxLkLWD55khrXiPEC16Lcf6540AVGd1A3
         /cv2u7Z7hotxBOQCcgxUt2qx+IWQUrMKxP/tC8naQIFc/rpwKUyDVTzo6PSAvK878ukS
         js7/MUPASBRV3vGRN/7r7npq+vqbCghO8SXseaIxK/jcsTouL1PR+nEScowNI3U/viAR
         G+7TplhYDD8CxtQr6Js6XkLx8k8qeEuk0N1fMdTK2lvIYXuNjWqpsClK+/zzyPRVmpyL
         vOCKzEJVerpCEnnZbSHtit0aaz66EMkrNaB/UOTeDow2+xJU9nrk6/c7xA3oTbkhOi1Q
         GcwA==
X-Gm-Message-State: AOUpUlF4tRpCsFyP2y4it4TBq0dMzSZYEddE5ap1oefB72ytFzlIOYYP
        UadySTJOMZJliS9GEiYVvDJomIC5
X-Google-Smtp-Source: AAOMgpffUVJ9bh/77BKDejWhcg5GsXEmazYhRLSmSIKAshKTKNh7ZUtrjKKFHs/yODOoENczwTtWXg==
X-Received: by 2002:a17:902:7c0a:: with SMTP id x10-v6mr4423291pll.77.1533318128097;
        Fri, 03 Aug 2018 10:42:08 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id r23-v6sm14069906pfd.144.2018.08.03.10.42.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 10:42:07 -0700 (PDT)
Date:   Fri, 03 Aug 2018 10:42:07 -0700 (PDT)
X-Google-Original-Date: Fri, 03 Aug 2018 17:42:02 GMT
Message-Id: <1d82eb450378c5d9ebdadb2f785df1782cf3a1d4.1533318123.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.13.git.gitgitgadget@gmail.com>
References: <pull.13.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/2] t3430: demonstrate what -r, --autosquash & --exec should
 do
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

The --exec option's implementation is not really well-prepared for
--rebase-merges. Demonstrate this.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3430-rebase-merges.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 9e6229727..0bf5eaa37 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -363,4 +363,21 @@ test_expect_success 'octopus merges' '
 	EOF
 '
 
+test_expect_failure 'with --autosquash and --exec' '
+	git checkout -b with-exec H &&
+	echo Booh >B.t &&
+	test_tick &&
+	git commit --fixup B B.t &&
+	write_script show.sh <<-\EOF &&
+	subject="$(git show -s --format=%s HEAD)"
+	content="$(git diff HEAD^! | tail -n 1)"
+	echo "$subject: $content"
+	EOF
+	test_tick &&
+	git rebase -ir --autosquash --exec ./show.sh A >actual &&
+	grep "B: +Booh" actual &&
+	grep "E: +Booh" actual &&
+	grep "G: +G" actual
+'
+
 test_done
-- 
gitgitgadget


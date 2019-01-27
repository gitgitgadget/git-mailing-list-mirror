Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE5A41F453
	for <e@80x24.org>; Sun, 27 Jan 2019 23:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfA0X1J (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 18:27:09 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39154 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfA0X1G (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 18:27:06 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so11593771edt.6
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 15:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dxzqfZAxZ+TPwgPiHydUMW7hZp+IB66oCyS61ZHth2s=;
        b=ZPf/7CM5qjB4x6/9SZJ1oXIAzNMiXy7PBbdJ8wAV755CwCb6Gq2aeNDbQcTSNArQwi
         QfcRnYoKB9KqYx4ez7I4ZNzW+O94jZnvoP35FyRZyltg4gDBUwmgJyPT6pXFSxtkD4wQ
         Y5nkVCZy1gdEzoWBnhwPhKP9Lhe3+kTreIsLslPNrYNUY/x4EyWjNrPgQvlKqtLPZMZs
         EYMFEKpTNJ4ol9o5a0/axE34sxBAhl8M/G9Rz47zz0aOhYdTf15gmfEhrKpmaW/44QqZ
         b3Bxnhuotd17raua5ecR0dcGOBwS944iD30y738tkBuhvYK1xyv8MBLRKBVyYwa5UaHZ
         SiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dxzqfZAxZ+TPwgPiHydUMW7hZp+IB66oCyS61ZHth2s=;
        b=g4YRH8PNqgGjCQaIb6IIlNnkSSRPdSkTxX4+pf4KRjAt8ra7EtkrpUDy4wNmdP0rJe
         /qjdVnmwxR4d0DCcHHnLoANw2FEJVTDipfS/tjZEgzjelBx/qoArlohRe6WZr7i4BVe2
         C933//OenV2FTVAD4UAGMOW4scnEItwY8zmf5BjNJt6xWv1E0ZWeVd0stO/vumBBggN+
         fsSFpgU8n1dLpcODixNsOJWnFvMJMkt1SrongXuXx4bh+/WCd2OxmaKE+a5vOo8a9kF3
         mPB2yJoZznZ+aVDqaWEvRAY87lloc1cDHKm/9lDnbYoPDtYbMyqkhiQDdarkyyokYw2M
         pskA==
X-Gm-Message-State: AJcUukdjsZHiLt3cstQxJkwTus8kWOq54M+5oGW5V1rMQwv7h5lNNvEO
        RbaY7pzVXreu5/sDEDjXN1bHsJ6E
X-Google-Smtp-Source: ALg8bN5/IdBCuloGLRZnImkf1EeJvr6M6fSiQMknpJ+rVvu+liie+2SKit1/+RJKqehzmwxsYOWDpA==
X-Received: by 2002:aa7:d749:: with SMTP id a9mr18848627eds.223.1548631624400;
        Sun, 27 Jan 2019 15:27:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v25sm2320962ejj.8.2019.01.27.15.27.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 15:27:03 -0800 (PST)
Date:   Sun, 27 Jan 2019 15:27:03 -0800 (PST)
X-Google-Original-Date: Sun, 27 Jan 2019 23:26:44 GMT
Message-Id: <7518266a19e4167fbe6459ff54f452573176c296.1548631608.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v5.git.gitgitgadget@gmail.com>
References: <pull.31.v4.git.gitgitgadget@gmail.com>
        <pull.31.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 18/21] t0061: fix with --with-dashes and RUNTIME_PREFIX
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

When building Git with RUNTIME_PREFIX and starting a test helper from
t/helper/, it fails to detect the system prefix correctly.

This is the reason that the warning

	RUNTIME_PREFIX requested, but prefix computation failed. [...]

to be printed.

In t0061, we did not expect that to happen, and it actually did not
happen in the normal case, because bin-wrappers/test-tool specifically
sets GIT_TEXTDOMAINDIR (and as a consequence, nothing in test-tool wants
to know about the runtime prefix).

However, with --with-dashes, bin-wrappers/test-tool is no longer called,
but t/helper/test-tool is called directly.

So let's just ignore the RUNTIME_PREFIX warning.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0061-run-command.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 99a614bc7c..5a2d087bf0 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -166,7 +166,8 @@ test_trace () {
 	expect="$1"
 	shift
 	GIT_TRACE=1 test-tool run-command "$@" run-command true 2>&1 >/dev/null | \
-		sed -e 's/.* run_command: //' -e '/trace: .*/d' >actual &&
+		sed -e 's/.* run_command: //' -e '/trace: .*/d' \
+			-e '/RUNTIME_PREFIX requested/d' >actual &&
 	echo "$expect true" >expect &&
 	test_cmp expect actual
 }
-- 
gitgitgadget


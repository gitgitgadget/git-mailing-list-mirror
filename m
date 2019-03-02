Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ECAF20248
	for <e@80x24.org>; Sat,  2 Mar 2019 21:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfCBVTr (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 16:19:47 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:44714 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfCBVTr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 16:19:47 -0500
Received: by mail-ed1-f42.google.com with SMTP id b20so1177677edw.11
        for <git@vger.kernel.org>; Sat, 02 Mar 2019 13:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=f2Jb7uS+NIpuFdcTGJNVP0ND7bu0lo2dezMo/BIJB+E=;
        b=KbEE/am6JvR7rq3isBcZJ4ySzMkEoqOh7hYZIRjCyH91Z0nWdF2MZ2RuqEVnSROEgb
         XGWEN+qFbWinnLmj8MYiG9UPoibXGkZ3QE1PkPR8RjlOS+PJk0nD4YqbjgYO04b96NdW
         mgIvRxdXmHiOwvUaUHSg2Fu7xUToYmpdlpzWKw360Bs+qWQTazMzRunNrPL/TnkU12E/
         MfC07ZcEybBZE3Pv5LznFKybw21wbl6gE5XOk8NhldEi+XJMVxKPFhPLvGq1/NeO9zOt
         p9KKP9e1T7WsEWLZSNNIjJ3nYC6niZ5kgvegRnB/lwe46PPJRtTpMFdfxfGtkYVxwSEa
         HsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=f2Jb7uS+NIpuFdcTGJNVP0ND7bu0lo2dezMo/BIJB+E=;
        b=DGj8tk8oFr3dFPqRRAwQLofm8SgACJXX7+ASnbDBygIXYlnGzbdlmM1l9qLf05tzSn
         k4kVDABnBcVqJ1EPLuaxURsUJFMkQSAjVuHv7nGc06Z5tdMZxsqbmWHHFKTIoI9RJqsY
         c+fuqLKZ2BYXMooyYlYOPzLvh6G6Je/+VwfsMQhWb5YzATOOlwSGD4ederZjaT4SRyjV
         bEs5IesoQx7JVWjlj5yHwRuWnz9EJbY/mqjqOzNAWGHmH7q86a/NFu+MP1UPFI1srwmH
         X6i4Zp5RYpWUroLTn4qSJs4qgZoAJM2EpDxTFXM6j0K1NbJCaoYboe2Df6Ts82ED9927
         BYgA==
X-Gm-Message-State: APjAAAXcROFoJeEckNGyAlbdgJJma/EtJwq2nTZFJcufBg8sKHMeGQX7
        IZci/9tvwEp+iScwT1vyMGSfya7k
X-Google-Smtp-Source: APXvYqxVSlDJaHJoFJmGt/nupOuPXS9o4VvIxR5fzS+K5+bOFcJw8bmyLWzBns+5kKT+NcGsST/Z5w==
X-Received: by 2002:a17:906:2969:: with SMTP id x9mr7208743ejd.223.1551561584791;
        Sat, 02 Mar 2019 13:19:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z39sm640890edc.96.2019.03.02.13.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 13:19:44 -0800 (PST)
Date:   Sat, 02 Mar 2019 13:19:44 -0800 (PST)
X-Google-Original-Date: Sat, 02 Mar 2019 21:19:42 GMT
Message-Id: <281d3f1d19d1c93e8d1e66ae16fe3fb286554c0a.1551561582.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.155.git.gitgitgadget@gmail.com>
References: <pull.155.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/2] tests: introduce --stress-jobs=<N>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The --stress option currently accepts an argument, but it is confusing
to at least this user that the argument does not define the maximal
number of stress iterations, but instead the number of jobs to run in
parallel per stress iteration.

Let's introduce a separate option for that, whose name makes it more
obvious what it is about, and let --stress=<N> error out with a helpful
suggestion about the two options tha could possibly have been meant.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index ab7f27ec6a..6e557982a2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -142,10 +142,16 @@ do
 	--stress)
 		stress=t ;;
 	--stress=*)
+		echo "error: --stress does not accept an argument: '$opt'" >&2
+		echo "did you mean --stress-jobs=${opt#*=} or --stress-limit=${opt#*=}?" >&2
+		exit 1
+		;;
+	--stress-jobs=*)
+		stress=t;
 		stress=${opt#--*=}
 		case "$stress" in
 		*[!0-9]*|0*|"")
-			echo "error: --stress=<N> requires the number of jobs to run" >&2
+			echo "error: --stress-jobs=<N> requires the number of jobs to run" >&2
 			exit 1
 			;;
 		*)	# Good.
-- 
gitgitgadget

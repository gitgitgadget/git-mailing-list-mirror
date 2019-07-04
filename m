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
	by dcvr.yhbt.net (Postfix) with ESMTP id A22601F461
	for <e@80x24.org>; Thu,  4 Jul 2019 09:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfGDJrD (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 05:47:03 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:38803 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbfGDJrD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 05:47:03 -0400
Received: by mail-ed1-f49.google.com with SMTP id r12so4842161edo.5
        for <git@vger.kernel.org>; Thu, 04 Jul 2019 02:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FEL07sVLZVhLVyMM4xOkECsJsnMLW7NgBa0uw9rVJlA=;
        b=EI1pG8n6ult66NfzDQHgTCulgevW0iqB56kaUD7oEJxs8FqW0C5ViHx0sYnIl4Y5Df
         H4ElOUwwnoHgXi4Fe78/1ti3A8to73dNxEHOLkZu4Iebvoe3mR5J8PYeSwr80VTzH+Vs
         h10A3/G4SXMl6Q5m7FX/Smz3DSaABa4izKmbScrB9dR8Snz88lnVpKBK9wS7/qgw34DZ
         pO8oFUetdnrBpsm9qZLOmp0NVLQv1em/pLda3oLQ4o2zTGgWqNtEghd17ns3Ko8ll0c+
         1GG1W/533tvcqViigcArTZmC2tZnF0Lo/voyM8eI4F+QIBFa4DFEFOWEp+lKuMNG+q1W
         uO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FEL07sVLZVhLVyMM4xOkECsJsnMLW7NgBa0uw9rVJlA=;
        b=ejZYiEkA1ZbBNqyg7BC0cgxc5KLaF8xyrVxv1DFzeiekp1j+xieY0a0nPu5lCfONIo
         z8FgB/yCSwmLtEtoeYIcoxrU46fCyuBZFHYW20y3N+26WnUtchi/7iNNtLk1dumYymy8
         zl58AUW+CwfQVQaMHPISgQo4mzwF3RefFQ9rEihx71VmB+qJ1iJtkE9muXUG2bel3CeZ
         wYTXKtYgAPoFWImLCZj+XMTWnO4goGGAw9Fsd9fAJiThDL4PYQkSXvx5jtuzC2OYYML0
         DaBBCZc0xYoILqshBXYBJSMljZE/qLx0cZPmofBLgRjfGr8EnFAqrnFQA4nzQEWOTbbl
         u34w==
X-Gm-Message-State: APjAAAVX5Kz1FOxfYC5TXZjKXm9+/qyvSS5O8I4SY7E2xA6U0l3LYImy
        h/7tBSw084HmTtT/DpRM9G2wjJ5x
X-Google-Smtp-Source: APXvYqyweTQY0dh9N+9+Icxz3tFb/kPhaaqPkmRquwopibN7780IdQ9SP1o6PsboVj2kTEUTOIImsQ==
X-Received: by 2002:a50:b122:: with SMTP id k31mr48161806edd.204.1562233621951;
        Thu, 04 Jul 2019 02:47:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s17sm968887ejz.70.2019.07.04.02.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 02:47:01 -0700 (PDT)
Date:   Thu, 04 Jul 2019 02:47:01 -0700 (PDT)
X-Google-Original-Date: Thu, 04 Jul 2019 09:46:59 GMT
Message-Id: <pull.276.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.276.git.gitgitgadget@gmail.com>
References: <pull.276.git.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] t3420 remove progress from output
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove ugliness in the tests that check the output of git rebase

I've updated this to avoid repeated calls to printf as suggested by Junio

Based-On: sg/rebase-progress

Phillip Wood (1):
  t3420: remove progress lines before comparing output

 t/t3420-rebase-autostash.sh | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)


base-commit: 5b12e3123b7b70e3875404a4ffe571ca079364fe
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-276%2Fphillipwood%2Fwip%2Ft3420-remove-progress-from-output-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-276/phillipwood/wip/t3420-remove-progress-from-output-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/276

Range-diff vs v1:

 1:  52501623f6 ! 1:  e1b4023bc0 t3420: remove progress lines before comparing output
     @@ -20,6 +20,16 @@
       diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
       --- a/t/t3420-rebase-autostash.sh
       +++ b/t/t3420-rebase-autostash.sh
     +@@
     + 	echo conflicting-change >file2 &&
     + 	git add . &&
     + 	test_tick &&
     +-	git commit -m "related commit"
     ++	git commit -m "related commit" &&
     ++	remove_progress_re="$(printf "s/.*\\r//")"
     + '
     + 
     + create_expected_success_am () {
      @@
       	q_to_cr >expected <<-EOF
       	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
     @@ -53,7 +63,7 @@
       		fi &&
       		create_expected_success_$suffix &&
      -		test_i18ncmp expected actual
     -+		sed "$(printf "s/.*\\r//")" <actual >actual2 &&
     ++		sed "$remove_progress_re" <actual >actual2 &&
      +		test_i18ncmp expected actual2
       	'
       
     @@ -63,7 +73,7 @@
       		fi &&
       		create_expected_failure_$suffix &&
      -		test_i18ncmp expected actual
     -+		sed "$(printf "s/.*\\r//")" <actual >actual2 &&
     ++		sed "$remove_progress_re" <actual >actual2 &&
      +		test_i18ncmp expected actual2
       	'
       }

-- 
gitgitgadget

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B97A20248
	for <e@80x24.org>; Thu, 28 Feb 2019 10:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfB1K0v (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 05:26:51 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37497 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfB1K0v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 05:26:51 -0500
Received: by mail-ed1-f65.google.com with SMTP id m12so16513419edv.4
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 02:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1Lq2QOEHh4o/J4I2rRA9/77nIoZIr0sdvKdEFy33mko=;
        b=Z5YeK3yZfr8mvzmY9qjfhItJDq1MIqyqC/d1eOQnvdthSXQHOplbw3GiXSmG78KwYx
         XBSWZ01awy0CQTbabKLAUrCjkXD60KFkpZtGCsOMSxd4vTcqgUUgsqSHJBHoXtwk+Fld
         s4BTncPYptZJL9DAg3ZfQ6tR3itV4mVXTPEEYm0QEAptiKn4bx4g+3x+Zc49wVGdbbC+
         NiuLcOzdeuE+rYU39vuTYk6WDM1/CmxMPvbZN9W5dd1PcRLctDOMYbJCuCUoQt8EW0jK
         lmrSwNObZfkJWiR6uZi4bU6mpyMC8XDGcRAqE+xMlK4WAC4Byxjyqy02NA9VVx834aX4
         5VJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1Lq2QOEHh4o/J4I2rRA9/77nIoZIr0sdvKdEFy33mko=;
        b=S+iF5q4z5G5K21nZ5dHY4iwxh6IhJ513EyTT8JD1jfwaIB7NydDFNkpbFSUwuoNv/Z
         EYCAqjkk2t6Mi1CNprW9+lUj0zxk6HbIXBYN1o8wPexfmG+hXrtZBaeAmtZ1CV3C7Vsx
         SpeXBF3bD1z5J8th9i9Li0DJKU4shZhY+phFpxd3rJQ/GNCqkoAIl2G83yfRv4Ldou3e
         6j7P5DpaiWnZKwscGpRaMEAYrz9Vd1/sYlOYbUh7Kd0e00d+J5Sy4+SQA0Oz3SoneT29
         FGFSENMzPEv2B/hIXXEktqT01FmoCYdQVzM6tU1dGABUD9v9mpoySXU1zlOozRM5S8DE
         UcPQ==
X-Gm-Message-State: AHQUAubQvE/5wkFIrB7UBLN7HfgsXWgCPY8Eod1vWuWhecQ8rDky8pQb
        GjqSv0EMUOAcdkvxE8IQq1PLlC0P
X-Google-Smtp-Source: AHgI3IY25Bp+CTEfIYOgVoaA73fuX44bjLT1TYz9VdPcC15N26HoDqcbVDWLOqrFN1+4+08YBbIqYA==
X-Received: by 2002:a50:b8a5:: with SMTP id l34mr6101956ede.196.1551349608810;
        Thu, 28 Feb 2019 02:26:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r48sm3416186edd.87.2019.02.28.02.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 02:26:48 -0800 (PST)
Date:   Thu, 28 Feb 2019 02:26:48 -0800 (PST)
X-Google-Original-Date: Thu, 28 Feb 2019 10:26:46 GMT
Message-Id: <pull.152.v4.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.152.v3.git.gitgitgadget@gmail.com>
References: <pull.152.v3.git.gitgitgadget@gmail.com>
From:   "Rohit Ashiwal via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 0/1] [GSoC][PATCH] t3600: use test_path_is_* helper functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace test -(d|f|e) calls in t3600-rm.sh. Previously we were using test
-(d|f|e) to verify the presence of a directory/file, but we already have
helper functions, viz, test_path_is_dir, test_path_is_file and
test_path_is_missing with better functionality.

Rohit Ashiwal (1):
  t3600: use test_path_is_* functions

 t/t3600-rm.sh | 160 ++++++++++++++++++++++++++------------------------
 1 file changed, 84 insertions(+), 76 deletions(-)


base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-152%2Fr1walz%2Frefactor-tests-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-152/r1walz/refactor-tests-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/152

Range-diff vs v3:

 1:  bfeba25c88 ! 1:  f881f01e4f t3600: use test_path_is_* functions
     @@ -20,11 +20,48 @@
       --- a/t/t3600-rm.sh
       +++ b/t/t3600-rm.sh
      @@
     + "
       
       test_expect_success \
     -     'Post-check that bar does not exist and is not in index after "git rm -f bar"' \
     +-    'Pre-check that foo exists and is in index before git rm foo' \
     +-    '[ -f foo ] && git ls-files --error-unmatch foo'
     ++    'Pre-check that foo exists and is in index before git rm foo' '
     ++	 test_path_is_file foo &&
     ++	 git ls-files --error-unmatch foo
     ++'
     + 
     + test_expect_success \
     +     'Test that git rm foo succeeds' \
     +@@
     +      git rm --cached -f foo'
     + 
     + test_expect_success \
     +-    'Post-check that foo exists but is not in index after git rm foo' \
     +-    '[ -f foo ] && test_must_fail git ls-files --error-unmatch foo'
     ++    'Post-check that foo exists but is not in index after git rm foo' '
     ++	 test_path_is_file foo &&
     ++	 test_must_fail git ls-files --error-unmatch foo
     ++'
     + 
     + test_expect_success \
     +-    'Pre-check that bar exists and is in index before "git rm bar"' \
     +-    '[ -f bar ] && git ls-files --error-unmatch bar'
     ++    'Pre-check that bar exists and is in index before "git rm bar"' '
     ++	 test_path_is_file bar &&
     ++	 git ls-files --error-unmatch bar
     ++'
     + 
     + test_expect_success \
     +     'Test that "git rm bar" succeeds' \
     +     'git rm bar'
     + 
     + test_expect_success \
     +-    'Post-check that bar does not exist and is not in index after "git rm -f bar"' \
      -    '! [ -f bar ] && test_must_fail git ls-files --error-unmatch bar'
     -+    'test_path_is_missing bar && test_must_fail git ls-files --error-unmatch bar'
     ++    'Post-check that bar does not exist and is not in index after "git rm -f bar"' '
     ++	 test_path_is_missing bar &&
     ++	 test_must_fail git ls-files --error-unmatch bar
     ++'
       
       test_expect_success \
           'Test that "git rm -- -q" succeeds (remove a file that looks like an option)' \

-- 
gitgitgadget

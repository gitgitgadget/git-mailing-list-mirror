Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BAA820248
	for <e@80x24.org>; Mon, 25 Feb 2019 19:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfBYT1O (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 14:27:14 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:46510 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfBYT1N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 14:27:13 -0500
Received: by mail-ed1-f44.google.com with SMTP id f2so8537029edy.13
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 11:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=0kcbjSyZHAIiapUH6r0/1FueCCiSDZ5jLHYBiz2XP+k=;
        b=IXU4PBHP2IBMUXOorG0Qd2DEmL8+u3DLMXBOmQfulBEoaBBxzVgeaUlYwP24cNGvwo
         6/wfkIlBvXflmPaQKaM8m3I/DtGbAe2Xp4YeTPbgu4VDvc9TsKkpkGUJ7pf8vvIWlFjj
         FxL4X7epztR+emNGIeVevVPn0PFL9Vt4EYe0n0ug8rq6dhBB6ZjYwGf9u7XiGLF0/Fs3
         tAe87HoWVp4gDLng9Xx7kjcd7hKQURy4ejUi4/BN4dC+mJztVy4IEArRzHdv2cmBCgoV
         FgVTcrKiwgkn+eotuuAlSzeZeIBxFjC5MJ/mhtHLUGgXnjRr973GOjilkbG+xh47TM3z
         kuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0kcbjSyZHAIiapUH6r0/1FueCCiSDZ5jLHYBiz2XP+k=;
        b=SbKXbXT+ZToWQwVeAqa+KBWnCWgEvyxrAzKk+ekbnBFBYmWGFDX7DJJZpY6BpcPF7I
         qMWlHpZ5g8H1Ngkuy+Cwz2RIlXqfriZlIR4GXoUuFENuxSsZDoMFwWjs4uM+ijxj+SA0
         cITQD7KEqYYREmY6tCxmWvPHf87VvPQFva7wIMDrY3QJXD6EvnHTg2tPfRsKY4Chg+pl
         c99M+35h+jHiX9+lD/pVMO7jRzykKf0zb2tcq1qscm2ECuCLizhE+Lxuvsz1hUBhxLvr
         M98wl/HcFlaKtpQq8167XhannKWn2wBZathlEowO+1Cc6rSf4p0UiM+PQRAkBNa8z2iD
         EMjg==
X-Gm-Message-State: AHQUAuaEC177zhx3kt3susvyQjgbVmIZM/YsXK6SvZJRzMgE4i9EAefH
        PUfdUsJOM9O0UFoW6/yLrS8vMUIS
X-Google-Smtp-Source: AHgI3IZiCI72WOw3PY+61tOqaFfLOakR0dYG7GC5Mb6In6wS3gLqsvniQc6ptpHt5TiZ5oGAzukfjg==
X-Received: by 2002:a50:90b0:: with SMTP id c45mr15842592eda.44.1551122831727;
        Mon, 25 Feb 2019 11:27:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l24sm1870231eja.57.2019.02.25.11.27.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 11:27:11 -0800 (PST)
Date:   Mon, 25 Feb 2019 11:27:11 -0800 (PST)
X-Google-Original-Date: Mon, 25 Feb 2019 19:27:09 GMT
Message-Id: <pull.146.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Drop last MakeMaker reference
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

Back when we stopped using MakeMaker, we forgot one reference...

Johannes Schindelin (1):
  mingw: drop MakeMaker reference

 config.mak.uname | 1 -
 1 file changed, 1 deletion(-)


base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-146%2Fdscho%2Fno-perl-makemaker-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-146/dscho/no-perl-makemaker-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/146
-- 
gitgitgadget

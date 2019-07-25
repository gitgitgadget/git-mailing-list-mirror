Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F6971F462
	for <e@80x24.org>; Thu, 25 Jul 2019 09:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390296AbfGYJQf (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 05:16:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36605 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390285AbfGYJQf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 05:16:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id g67so39927281wme.1
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 02:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=IHT0Lw7X4ErWMThoTA4mQ74xWry5zjhfIcSXscfQ+oU=;
        b=Dyd384ZbffEKl4tVEII02k9bhkYBS9dCyZ6DMDfm64QsfIZDoQFJSGgYHJvj61bLkS
         y8zDZHcgqUl1nn8V22zd1t93NehmV2DMHKrJvRJpcaNTb5wrGNnD9A8Mqqum8Y+M0Phq
         3ZyRot9SL24FavLZ3zmlgm3vOiUvyoPtnattcQxb3fJ0jSSsjCixRoVzIYf3wScMPDC9
         OFYuPPermitNgct+FGZ3bkSr2MBulZNhI483eeaoTTUmqIO2SH3cPkg/kiG1jfbtTneO
         PjIy+32g4LbzV14kAi8U5Mn4VGIDeTZAvNjCzGCDeM+XQ+2BPfMQLXwxaTEKWNwRP3dt
         Huzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IHT0Lw7X4ErWMThoTA4mQ74xWry5zjhfIcSXscfQ+oU=;
        b=ilMs9Ie8IJJ2CNsGHw3S2BhtzbvkJv/QZxn4knmLQ7WjoZ8354vvaE1ul1vTg62ssP
         2XTca8pmhxyZUlXuMZL27aWilqMwQ0K/MpIzvFXBHhx9ymGaFuWd2NC3a5ro0/4lUIrM
         i1oWFtGBw89hI8j8h8oz0536lU1T1ru1ddgjqfQxiFNbz3O/PGvC59CQly5jADLf2swg
         sXRCz54FW6tcoaHcY4JhxpmRmLbzfA17bBOA3GaCtmt1Ogsfde/OuHyyMDNCotEExFOT
         1LNgUgBPDt9CUWHjkYp24hAfDwYBtdoOexcbwtjLyCdD7FUy3KeZlQG/6beG1LrDj2kI
         IFXA==
X-Gm-Message-State: APjAAAXmL47zhQXFOYgOiaiHeFLUMYCBbrPFvDzYrod5jaxizDrwCrtE
        mB0LlrLdRPH2hq6dVFEaZNTVvnpz
X-Google-Smtp-Source: APXvYqxNEu3VtNGUAg1l9ZyltDvwgwPso6pYhOZeabYvoW9+on67bqR+4nfaSMOjtAuyFNDseVI/EA==
X-Received: by 2002:a1c:7c08:: with SMTP id x8mr78930521wmc.19.1564046193130;
        Thu, 25 Jul 2019 02:16:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j9sm54867827wrn.81.2019.07.25.02.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 02:16:32 -0700 (PDT)
Date:   Thu, 25 Jul 2019 02:16:32 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Jul 2019 09:16:30 GMT
Message-Id: <pull.296.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Add the REBASE_P prerequisite to two more test cases
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

I had forgotten those previously. Sorry.

Please note that there is another set of test cases in t3427 that desires
the REBASE_P prerequisite. However, I would like to address this as part of 
https://github.com/gitgitgadget/git/pull/294 instead (because I kind of had
to pour substantial work into that test script as part of that patch series
anyway, so...).

Johannes Schindelin (1):
  t3422: mark two test cases as requiring support for
    `--preserve-merges`

 t/t3422-rebase-incompatible-options.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: 082ef75b7bfc90ac236afbb857a9552a026832b8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-296%2Fdscho%2Frebase-p-prereq-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-296/dscho/rebase-p-prereq-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/296
-- 
gitgitgadget

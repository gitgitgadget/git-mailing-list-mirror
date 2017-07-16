Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E1682027C
	for <e@80x24.org>; Sun, 16 Jul 2017 17:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbdGPRhV (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 13:37:21 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35946 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbdGPRhU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 13:37:20 -0400
Received: by mail-qk0-f171.google.com with SMTP id v17so100385062qka.3
        for <git@vger.kernel.org>; Sun, 16 Jul 2017 10:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ghAU4ZAH1eq9UX4VQzlBlNIAztyp26d0b8/Rt5sBvBk=;
        b=nkOS5VzVObfxMszoHNjhYMp4tCvx62dq1pk8753lE72SNAxJcmdLPK0E6VV7HwPKOk
         iZ947ysWGyAQcolTJ1jCYtSMSwUGY7V5L0a8R9+uF/8wyBVWT8HtQtt6zG8yny0fyCsN
         SpvqbtRMbf8qXtNxWE0Vpq1QPWYpEWGTYlUJ/q9C4ntbmyLl+5weZrNGyTVzM7trR7MF
         +Mhfl3WdJJkUsAal8hWnvgytTaRl3cf7lmtt22LGD53q5I6oYUAFZoPqnEinWKMdfKFW
         BtvAUkxCuULSwt1FnKq3Y+gSd7oMfITJtqfusmT6UzgdXYKdXwBTtLZetfUowGYzz3+S
         spgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ghAU4ZAH1eq9UX4VQzlBlNIAztyp26d0b8/Rt5sBvBk=;
        b=YCU/BsKnVeyKjTfbSM7OhQexvmd0SK4l+kL4UzKpVqQ1LgJqRYOQSGQ2u3HjGRP/JZ
         Wx85mmZG7MeUWoiYIx4kYRPAcVlLs9ftMbbQewW3FV/clxz+1UfjDYqnmyyDYKBtbHZF
         G6mtSZcMm/9yvdg+chb67mUQKrjZlzssKxXygQ3GLN5RROhfaBQ+CYDAQC7t45Rs2T0m
         s8WJe7OufxGGGS9cL1X9R3s//8ulLJLZ/mwitg5qvQ1Dq8s1oa0rxL4Tlk9jtpCQDkmr
         O63k4aieDIp7Ls5X+KiS1Z3Uz3NE+ldPhwwsNZQheGCwaXc40sgxIin/GGs7VTX8EJyh
         exIA==
X-Gm-Message-State: AIVw1129uFWlRhNDNw51PzoQmqxEjvB5K/0SiDck+z4uCuJ+tUlbHBYl
        mnJJY4aGR2KVAF7JaH5eSe32mdFFP5VkTjc=
X-Received: by 10.55.198.4 with SMTP id b4mr22799810qkj.200.1500226639518;
 Sun, 16 Jul 2017 10:37:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.178.138 with HTTP; Sun, 16 Jul 2017 10:37:19 -0700 (PDT)
From:   Jacques Viviers <jacques.viviers@gmail.com>
Date:   Sun, 16 Jul 2017 19:37:19 +0200
Message-ID: <CAA=CdW25uWyZA_7RVnr35dNuK06=8_+fk_tBMt5OSf_xY4LWFA@mail.gmail.com>
Subject: [L10N] af.po: New translation workflow
To:     git@vger.kernel.org
Cc:     Jiang Xin <worldhello.net@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I have started a new translation af.po at:
(https://github.com/jbviviers/git-po)

The translation is far from complete. Should I wait until it is all
done before I submit the patch, or is it better to submit as I go
along?

Although it is unlikely that someone else is busy with the same thing,
it would still be better to somehow notify other potential translators
that this work is in progress.

There is a few of my colleagues that indicated they would help with
this translation. How does that collaboration work? Do I merge
everyone's contributions as I see fit and then send in the set of
patches?

Some advice would be much appreciated.

Kind regards,
Jacques

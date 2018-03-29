Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD3E41F404
	for <e@80x24.org>; Thu, 29 Mar 2018 01:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751403AbeC2BtW (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 21:49:22 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:37150 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbeC2BtW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 21:49:22 -0400
Received: by mail-oi0-f42.google.com with SMTP id e8-v6so3862857oii.4
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 18:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=Wi2SJzCxpm7D+/+w1fXEWuVUv8HRGG4BnVoUL4aNXMc=;
        b=qmSjMxFnlLW6ddFUILUpbfes2vqcPOdGR+PGWntd1Ft30StmZhK6869xPDyzXdJSfD
         IPTE9+YY46+0jscen6lj9G7HhvWcASugTdQAFmKGeHxqATceOIjbA/IFUVTp5a0UNETf
         YNw2Y0Scb6uFLX3szEpoJdttsdVbAxVWKbzjcHE15Lhuqk9HRmAeUY7tkQmD3l0DG4K4
         rO6uZ7lPw3vgU6wvZ0+bLtJlmNBV6gCAJfLSS5ZsCfhc0UHD01yRQMQrVqcOmyLdwCaT
         lQtZ3TUrBH4D3TmbnjIfBojb8Sl3Ko0IpvCUI73HIcTt+6hYeU8X/eAEldnxHWb/fo1R
         Nhjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=Wi2SJzCxpm7D+/+w1fXEWuVUv8HRGG4BnVoUL4aNXMc=;
        b=rxmPN9ysQJqBZFskdOZ+GHz3Q5d3Bu1+Hj6SQ5AKZ1fHYUHbvATsK3V5oMIoXL6TXK
         9FQ0Prs3CjeDZydtVOWJga9UNvd2C/v6wFZZ21Cx0zvoFJL6DfwWT4rDvgPZ39Pa1ZdI
         GcSpfkqivaIjQugtb9c4yKF80NMEcbzzJfMZsyL1KhAkpccR95nfgPZh9bIbF4EONN5V
         d2cyHUZ+xIpNQjJoHjlRimS1JP96lMV8w6AuAnkW8zRKQkQPtxxtfB5MQNP2kmFclR1R
         4ffZU2Z6AF+QIp7NhqrPeAewKDprpI4Bt4zarpDC3pZ5UCkxrAUv7pqW4Ol1OL4P9qvT
         auMQ==
X-Gm-Message-State: ALQs6tC/iLbFFNExu454esGpik1TqGqBxisY3ayqH0nkQNcQziR0/6+X
        6DTYvID1py0EFm/GKKt3g17Dj1bF
X-Google-Smtp-Source: AIpwx4+10oWAYXnt3JIplTsjBm623/XHBScjDAT/im4cweAbCdK1/v2d7yByM45giF4tF9Co5R9xOg==
X-Received: by 10.202.84.132 with SMTP id i126mr3108393oib.219.1522288161219;
        Wed, 28 Mar 2018 18:49:21 -0700 (PDT)
Received: from [10.0.1.4] ([71.221.132.60])
        by smtp.gmail.com with ESMTPSA id w12-v6sm2776264otg.9.2018.03.28.18.49.20
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Mar 2018 18:49:20 -0700 (PDT)
From:   Mark Wartman <markwartman1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Git Question
Message-Id: <CA263ADB-E23D-4C75-ACDC-C9C0B75A4A85@gmail.com>
Date:   Wed, 28 Mar 2018 20:49:19 -0500
To:     git@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am currently running git version 2.10.1 (Apple Git-78).  When I run =
git config =E2=80=94list:   it returns
credential.helper-osxkeychain
filter.lfs.clean=3Dgit=3Dlfs clean =E2=80=94 %f
filter.lfs.smudge=3Dgit-lfs smudge =E2=80=94 %f
filter.lfs.process=3Dgit-lfs filter-process
filter.lfs.required=3Dtrue
user.name=3Dmarkwartman1
user.email=3Dmarkwartman@d2l.lonestar.edu

I am following this tutorial and I expected to only see user.name & =
user.email, so what are the filters.lfs=E2=80=99s and the =
credential.helper?  Should I ignore them, or try to get rid of them?  =
Please advise. =20

What is the best way to upgrade to a newer stable version of git?

Thanks,

Mark=

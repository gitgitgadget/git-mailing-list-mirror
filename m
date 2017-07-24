Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 694AD203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 19:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754445AbdGXTRj (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 15:17:39 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34666 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756107AbdGXTQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 15:16:28 -0400
Received: by mail-pg0-f44.google.com with SMTP id 123so61003675pgj.1
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 12:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=I++HBAA99z70mJEFa5k/zHLM2wTDLm0VGaV1UIq9rrY=;
        b=UQ3zUGUMxlZk8P6mbAsZ1b2asBsp+jR7jydGvvMlPuCfnNupf+Ke9wCDyQCiakQM8N
         Ljud6uiHvLYwJZZpfHpIRJD4Ur71GATTnSQh9uqcMHlAnzg1enr72Tdpw9FdKtJr8AzQ
         WbAoVCVhCSyYFRDfyJFMwrDx+cGu57AtNNrY2yezHYAiOREs8br8dgbSXSNDSmwcFgDY
         3mSz/gOuTyYzrmk4O29rZkOMZmR9z7AqqF3mty5lZx8EbTY5+4eeV39+dts1cU3T/QOj
         rcGP3R65CnALBHuXocQREcmxJUnoNbQ0usgh6nM9+aFT/nvUCd4AQSNIgy6EkhYVt0SB
         4L/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=I++HBAA99z70mJEFa5k/zHLM2wTDLm0VGaV1UIq9rrY=;
        b=c25JyHxiBRMdrK9G5PFpZep4r+2wQA9qFDoxz9M0xxrjfrr7qsMvt16p9PSKVDKEi3
         34ioxXsF02mCnolHOkYa/s0wvyXWlkVXWUPOsO5+T+4YUlgF/ObHJo/a58aYH+7tsezh
         FI4IaYM48h5n6L57nQGS9Vz5N79foUaTw7+m7GDiCA4Yaw6tMEiX2SXSeTuxIM3QguMO
         I34ZgZLpktpa+GtjEAjvZgnFNWEeGU43G/kHXuBB9VIIoDEJt3omrZLFUHfOsjIgIfoO
         ctpFNjrH4AxkZSFTK+vyOucOmmUNUVa9vPcKZWO69RaqOn58S9ATUWjyms+VwzNF3LV7
         JuQQ==
X-Gm-Message-State: AIVw110fNSIfpKlGJcPBKiMp0jXIEA7p4jO9aWGaOXHE4JXW97qPw6oF
        J6lSJeLMcNayD9wv4wM=
X-Received: by 10.84.209.165 with SMTP id y34mr18747608plh.200.1500923787767;
        Mon, 24 Jul 2017 12:16:27 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id 16sm20206124pfq.151.2017.07.24.12.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 12:16:27 -0700 (PDT)
Message-ID: <1500923812.20078.8.camel@gmail.com>
Subject: Change in output as a result of patch
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
In-Reply-To: <20170724154119.2926-1-kaarticsivaraam91196@gmail.com>
References: <20170724154119.2926-1-kaarticsivaraam91196@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Tue, 25 Jul 2017 00:46:52 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The patch in the previous mail results in a change in output as
specified below.

    $ git branch
    * master
      foo
      bar

Before patch,

    $ git branch -m hypothet master
    fatal: A branch named 'master' already exists.

    $ git branch -m hypothet real
    error: refname refs/heads/hypothet not found
    fatal: Branch rename failed

After patch,

    $ git branch -m hypothet master
    fatal: Branch 'hypothet' does not exist.

    $ git branch -m hypothet real
    fatal: Branch 'hypothet' does not exist.

-- 
Kaartic

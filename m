Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F2CE743C4
	for <git@archiver.kernel.org>; Thu, 28 Sep 2023 21:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjI1Vfe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Sep 2023 17:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjI1Vfc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2023 17:35:32 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EB9F3
        for <git@vger.kernel.org>; Thu, 28 Sep 2023 14:35:30 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40537481094so138302725e9.0
        for <git@vger.kernel.org>; Thu, 28 Sep 2023 14:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695936929; x=1696541729; darn=vger.kernel.org;
        h=reply-to:date:from:to:subject:content-description
         :content-transfer-encoding:mime-version:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbGGnZ+iGKH5SYARMXqmimlqWFsmyKsQrB+/z51DaMQ=;
        b=nDLxFlW/3H7IDTnEqMV0BaDG65ODhXFUbbumySFzqGaEnaN0qpiwM/CZdzaaZV6pCT
         n2UICxQzzpF2jD+J2z6RslpqoFhOzHw+jDlghBvXMPPiLVC1oV6TaRnuHVURy22QF6Pl
         kLNNiM6WxoNnOu/a9spI7TAOA//e082SfgbwmnmNpMzOLtHYCkHzzkPAs78QoazoX0YR
         MwYga3dvVAEC7r8NFCjotvjENaE2Fn5BJ3VaHVZImaZcGg0b/1SuKWDauM9OG9PIS4zo
         aOU+m4tCoVpoiVGJx6zc6nkuY9Qv224c6rhiykDpPgeSUVATZPV3vghIFTm03pe7bfaE
         Ncvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695936929; x=1696541729;
        h=reply-to:date:from:to:subject:content-description
         :content-transfer-encoding:mime-version:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kbGGnZ+iGKH5SYARMXqmimlqWFsmyKsQrB+/z51DaMQ=;
        b=jsoSWyLP0UW7gZ0TvKbi2sEyQaPqm3Y3i+R6d88vMFHAPoXb6ONtxAMLtck+XujlB0
         nyvHCuMg4ciTQvbjwlH4t+fst3kA4jQMeE52TRBmwoHBisPWXWtoR0brxOC/qo2EY69Q
         CVy7yNtEIzOUAfZ5CDlOg5rw99RuySgTIpepl8CT9dr9c0ZJW/Zlu7qW3ZWnllxPiu/5
         2EolTCGAs6tIr3WodgCKEPCw6EGdC1BJENL5ZaPMaJFR4lOiQnesmcdKKSIdzi5+FyLp
         r7mxfysGwT+ymRiZJQciNY0mYq/48uEoqi/3LywwaCX4vVFYm+jgtvHB8Sf14NVkJnBU
         t0Xw==
X-Gm-Message-State: AOJu0Yy2xgCJX6AalX8ixIZ1Dyb12K3RI/q1r3jvOZbL07g+nfQtLy8w
        Z0w/XEXWsHqZDkiQgs5KynHFVHMfmmcwpQ==
X-Google-Smtp-Source: AGHT+IFu0zF1ebhAuWUKyTi6FuzRVYQLgXSPTo0T7i7ZWYojnqz8cVH8BFoCGNFUCyvs8Y125rwJcQ==
X-Received: by 2002:a7b:c5c6:0:b0:406:51a0:17fd with SMTP id n6-20020a7bc5c6000000b0040651a017fdmr2114578wmk.18.1695936929005;
        Thu, 28 Sep 2023 14:35:29 -0700 (PDT)
Received: from [10.27.226.3] ([105.113.62.3])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c020b00b003fe2b081661sm23472wmi.30.2023.09.28.14.35.27
        for <git@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 28 Sep 2023 14:35:28 -0700 (PDT)
Message-ID: <6515f1a0.050a0220.6ed0b.0139@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Please I want to discuess something with you  reply me Urgent
To:     git@vger.kernel.org
From:   "M X" "chris colin" <chriscolin994@gmail.com>
Date:   Thu, 28 Sep 2023 14:35:27 -0700
Reply-To: inf658@daum.net
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Holle,
Please I want to discuess something with you  reply me  for more informatio=
ns.
COLIN

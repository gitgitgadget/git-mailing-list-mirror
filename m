Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB900C43381
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 07:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5586160C41
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 07:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhBAHGM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 02:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbhBAHED (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 02:04:03 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACC3C061794
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 23:02:10 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id k142so3322997oib.7
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 23:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=n1/7E1U5GKPPuEXqOlFs9GrqHNNeILjYagV3lrNJI0E=;
        b=FC2SRB6CHVftw3+oJBt3dnutbyPMVMM3Jude57hFVqnmA8EEUH/QpmR46hhtP5Unqc
         n9yokVkFwWIOGEfRxoVL13WLo3AdYzE7DDg/pcL3sLAEiAnL77NkFNvOWaH4UFUmScff
         QI3530B7r0a0d4enUa8z+GaOn0QzMWiu/Ivi0wXeirC1sp3lE94lx3x4+QxRNRsyhlBs
         pl5LIjKo7JdUj+57a55hWnkxvRS1HZIUF3mQbXnNw5R2eWTjyDXbbaUMDGXjm7K6N0zc
         RyVmErLxUj+g+oJipFvE0+/TBcVz+999LtdxfvjtrxLy29wEICfcz/q6hG6ERT9Nxl4d
         B4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=n1/7E1U5GKPPuEXqOlFs9GrqHNNeILjYagV3lrNJI0E=;
        b=UMw+/+ESGZAhW7t023pwAoWnuIidg4IwvjFnQgwJiqAjvNuVNFuSsjRAlvNhGkM/0E
         on4U5AmZyWbN89hu6M0m7G8wumO98Vm5XLOfy1kZ+SLgB7zmigy97/lbAQogFYr+xru4
         RN68zssy4ocZ5forALtQ+8y0Z6T8r7VXUzq0LqevdlYGkPP57oWrXA3R5dCotMnuq5gk
         9NMfXbxnxMioX8I8+jvq4HHhQOab9SOwG4l1BSWd5NRpmSKEQ60xNGss2i/t1ov345dm
         JZwoG5HXpxjzrVAH6mFGs9YfBdITK420s/nL6WUfbpVgek11HdOupDNszKNLR9R3GCht
         oY4A==
X-Gm-Message-State: AOAM530tKFw70m0D27EfJgdIJ85dTLF7VM5qODkOJpnhmQSpQjx+rFMC
        zx5Fnckqlctu1lD0PPK8/NC7z/7y3L1g6OLP+jk9IXvJByU=
X-Google-Smtp-Source: ABdhPJyUgE9eyXhBQdvZavW39DxVZS0w8XVx1NbvXCFIChq+pfLZAFXcZLKlQFYb52pgcvFePuD/tzoLTx7uFDjIc+U=
X-Received: by 2002:a05:6808:c:: with SMTP id u12mr9434662oic.163.1612162929861;
 Sun, 31 Jan 2021 23:02:09 -0800 (PST)
MIME-Version: 1.0
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Mon, 1 Feb 2021 12:31:58 +0530
Message-ID: <CAPSFM5epundzB6ZGgQJWiDPbC2nPt6hcuRjX3xHDshUaY=mhEQ@mail.gmail.com>
Subject: [Outreachy] Project blog - 7
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone !

Here is the next blog post regarding updates on the project
(Implementation of amend! commit) :
https://charvi-077.github.io/week8-progress/

I appreciate any suggestions and feedback.

Thanks and Regards,
Charvi

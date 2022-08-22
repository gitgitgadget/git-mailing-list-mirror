Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7158AC00140
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 00:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiHVAuA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 20:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbiHVAt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 20:49:59 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73CC1F629
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 17:49:58 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id m5so6893076qkk.1
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 17:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:from:to:cc;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        b=M7SVxGNuLkiZVAlnEG5S2DkAmbK2odZrfy2ouwYOcnnm9PLH4+kqBpV7e73K6TxI01
         PwHD/F2ghY39M8U4TWaOeUd83YOuylLi5rwpXT26I4bZ9qeLEZ1akt/zCJr/VG3KzOcG
         Sw97Cz4KVJC/Yw8/5ub6WcJEDhZcJraaONiqS2qXZGgAGUOl0IIhNTDF0pm15YCMm/Ib
         ohNGW9dwBpXAc2Rl+uh7XosVfcSe2PNo+QSIiilSSWBxQM/+aq1UI83trxP1IgwQi6cr
         DElfRRLH0hOjGL9wCChZrBlEnqHncIVq75/hONpxqqiOe+bnQNAg+tQ13QOAzk5LyLis
         CTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        b=Um+4c3YgOwNp78IsFQMtpz2Ad00KJdAoQiGX0RkCeIBz4+xy+wShm2r6aUcKdcILIJ
         NvpvKiy2dK0zhnePWso8XCQ/kmHo0K8ChfPwdNlMlFQLppO9eHvEkVGPJlB+gFfVTUJz
         sm06X4InbiQ2FiRvfjCjJI7jGXpXxB1RXZ3eFtCIouYkLcoBJq2jyc273N0jxRd6Z2mX
         pJC+mOsQLQ5vQ0dEuVOk7UkFynMPhAD2smh8tMp9+7WFc9FZ+PkuyiWoIxDd3B48Ymqe
         vKyPKfSfS+siss8o9chzF/F5VvCjYjMpAC8NSuZBgRWPUkbLV+BJSq02lo5gS12EWsUT
         vioQ==
X-Gm-Message-State: ACgBeo3yDLY5X1rMNlo4NcmXTE7ntgC2a6L1jyGWjIojeM28SiHU3AYz
        gjok/QjA03jFx5pdNNCk8tOl504TFSVVyGcn
X-Google-Smtp-Source: AA6agR4Hy+q5EyoEu5KhP/7o5qT4N231UEa2I9ENoCvYCEuNQSw9SC33ajKOTjBzBXags3+8YOppIg==
X-Received: by 2002:ae9:e841:0:b0:6b9:c69e:ac99 with SMTP id a62-20020ae9e841000000b006b9c69eac99mr11054921qkg.450.1661129397818;
        Sun, 21 Aug 2022 17:49:57 -0700 (PDT)
Received: from smtpclient.apple (2603-7081-4cf0-7d40-9c97-78ce-5d8f-2739.res6.spectrum.com. [2603:7081:4cf0:7d40:9c97:78ce:5d8f:2739])
        by smtp.gmail.com with ESMTPSA id bj25-20020a05620a191900b006b93ef659c3sm9581168qkb.39.2022.08.21.17.49.55
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Aug 2022 17:49:57 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Heather LaDue <leeelee3685@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Sun, 21 Aug 2022 20:49:50 -0400
Subject: Hello
Message-Id: <2FFA9201-7994-4A55-95EA-1D39E37B1A9D@gmail.com>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (19G82)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sent from my iPhone

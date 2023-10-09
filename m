Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7417ACD6115
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 17:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377467AbjJIRio (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 13:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376760AbjJIRin (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 13:38:43 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A159994
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 10:38:41 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c131ddfc95so59984431fa.0
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 10:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696873119; x=1697477919; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RstbBk16JB58MpwJf3NBJ17YWvjZbpJzIi6mHSMeWuw=;
        b=PHxOkBRzR96vOw2GtBL9eUqQSfcDw/WhbyHg+HGE+5uNoHdyOytJuEtILvU/wAftao
         PXK2y6ei9g6pWPayZefQIPz0b0w/oP7fDC1+g9q85l1TQFVkL1yuD/WbduU8Ec7+lQ0i
         k4DysJdNJYW/r5k/sxiKkO5A7VJeapd+n5RqcmwDC09o8+NfAUIe7xdwLIz5CmzuwT4K
         FFROY7IZevzNAYrQ91HiJHsKDWmHiqGiOKr3M1wm03eagX/x/FkvXFlVFocjOvJDCV3W
         +XEe2qVAlW80bdBrRkSXFans6yM6IUGUYWA8mgLXW6Ksdrj5NkNkBj0Ea7gcWRh1CF7I
         9otA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696873119; x=1697477919;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RstbBk16JB58MpwJf3NBJ17YWvjZbpJzIi6mHSMeWuw=;
        b=wpA0bMnmYOEt1TzeIVpPmKSkoyX31TKZBtaE1oaX+fLvZI3qAKMEj3D+P7AvJh1oGf
         CIUlHa4hzapKXhN9cpxJR0D3sIgMLjbKD6LjakFKhfqPsHNwpnAt0u1EvKWC/iKWOo7m
         qEJLqpFm11NgmmNrInz7Vb+m5X6H0Nes2APO7trUcBsx0RFpOsRA96PfKoGAm2cCq2jj
         F7pLZ4CJStDDnRiUZ+KX3r20D6SaMlea9HS4n89nfEbrO4GtLe8Shqp3i8Z9PmLz79Ea
         SgNr1MttafBSe847rsCq+L77J2A2XuybHFXAwtubMjoXFX++sBytt/T2KZxQrpXi5Grv
         9i7Q==
X-Gm-Message-State: AOJu0YwTQ3vDKsPqoIYr7jEsfzFzglpCUjDat/jqJaYCyZ3zZ6lE7DpN
        Sy7tuaTC1bunF6v1vDn2ASqMKcu809Tz2KpiCSRpERTMZSk+pA==
X-Google-Smtp-Source: AGHT+IHKCdCfddnQliKxu5bpBfPbb27tEkNpWnRN34geRG33H2gelPkmY6IaDDhuebzpEqgNhkfzeovnZtG8QuHjCNM=
X-Received: by 2002:a2e:7c15:0:b0:2b6:e2e4:7d9a with SMTP id
 x21-20020a2e7c15000000b002b6e2e47d9amr14643497ljc.38.1696873119404; Mon, 09
 Oct 2023 10:38:39 -0700 (PDT)
MIME-Version: 1.0
From:   Doreen Wanyama <doreenwanyama20@gmail.com>
Date:   Mon, 9 Oct 2023 20:38:27 +0300
Message-ID: <CANhBNnu6jbhNqAowBzyfcKDamXtcqCtZpY=QniTGTEJoCrwWOA@mail.gmail.com>
Subject: Outreachy Introduction and Interest in Contributing to the Git Community
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git community,

I hope you are all doing well. I am writing to show my interest in
working in the project titled move existing tests to a unit testing
framework. This is because I have always been intrigued by the work
the git community does and hence I am interested in being part of
this. I have gone through the links provided about getting started on
this. I spent yesterday evening and a better part of today trying to
understand the resources. As of now I would like to start working on a
microproject since I understand this is the first step. I am finding
it difficult though to start. Someone to please help me understand how
I should go about this or how I should go about finding my first
microproject. Just a brief explanation will help.
Thank you in advance.


Best regards,

Doreen Wanyama

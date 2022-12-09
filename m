Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FAAC4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 23:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiLIXfq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 18:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiLIXf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 18:35:29 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16C79D898
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 15:35:25 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1442977d77dso1592651fac.6
        for <git@vger.kernel.org>; Fri, 09 Dec 2022 15:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ttkhGcDrI+qqpAL40HmpqBfbcU25CE3/IdAuAwP9Vdc=;
        b=mesjfUcylKQfcgjZSlg30E2GD2MFC399oZ9gAgM94ePpWb0am+b4SslfSjATmt0RFF
         TFIrwoIIXE7vFSarKKMO1jjYvqDAB8hluXCNW52551pLAJ7FWVRbU4AXcBWvF1hgivNL
         8HvQU9SPslusW9MdUDj3c3drGPnq7i461TujgQU4xlYP3eP0jptqUgadMov3x3FzRlgB
         RCgjS3xIuWRJGqv/Q5fVER56knDSTGJSadA6yrceBxZutmSmYUfdsBqsSDmBxPDuXNJ+
         OO2Jl+fGg0fVh74ARVoU+lamMIoWT8yxSO0LZWeVbBWX0VCMWRzb3fWIiYTBS4yb0bMW
         wwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ttkhGcDrI+qqpAL40HmpqBfbcU25CE3/IdAuAwP9Vdc=;
        b=HgiPaa7RZAx7+zL9k14Uu6Ic8uFsAAVnZAg4oL9szDormU9xx+DICq8oSdnDu/l/9N
         932riPadlYdP1Y0M6SBZ7iqgD9QF+Cd6IMvmelldvgFCyXZ45Hw20ZTXYlrp5MOoCUh5
         Ike9WJdnddwbly9kzJFG6ENORCPvJWfuS/drfj3uO1VXhOcE6m5GSApGpcVPAK3nz8LJ
         kEjbVJWepfo/Xp/jUdKRuMNLzhOozeK9kt/d2whQ3HYNu+hHw2H0azwyAPxXl8lsynqP
         okuHPidR9OKzqPYoJqoLhXm5UuBXkSD7i/CsAZSzi6N/eDuY+FUaxMwfhJ2BFJE/KVc1
         Ysdg==
X-Gm-Message-State: ANoB5pla2JVsta/9BsulJ2jUrqPfbFrR/OWnwR9pz702lSAqgjM8mDU4
        hW+PoDzNxZKnx6Jfl4UWmaPNtT+fGgSqzv1+
X-Google-Smtp-Source: AA0mqf5xkpvGokxjbatqFMRFuizGafg4ah6O53BreO0ZPowQaJ0myOwsXg/Uk7guonexPruPCNms5Q==
X-Received: by 2002:a05:6871:4497:b0:13b:c728:b475 with SMTP id ne23-20020a056871449700b0013bc728b475mr3632426oab.48.1670628924429;
        Fri, 09 Dec 2022 15:35:24 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.109.17])
        by smtp.gmail.com with ESMTPSA id b2-20020a056870160200b0013ae39d0575sm1508199oae.15.2022.12.09.15.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 15:35:23 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH] mailmap: update email address of Matheus Tavares
Date:   Fri,  9 Dec 2022 20:35:16 -0300
Message-Id: <05ea404f111d598e2772c2ebddf6a335ec75845a.1670628915.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I haven't been very active in the community lately, but I'm soon going
to lose access to my previous commit email (@usp.br); so add my current
personal address to mailmap for any future message exchanges or patch
contributions.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 07db36a9bb..95aaa1c833 100644
--- a/.mailmap
+++ b/.mailmap
@@ -165,6 +165,7 @@ Mark Rada <marada@uwaterloo.ca>
 Martin Langhoff <martin@laptop.org> <martin@catalyst.net.nz>
 Martin von Zweigbergk <martinvonz@gmail.com> <martin.von.zweigbergk@gmail.com>
 Masaya Suzuki <masayasuzuki@google.com> <draftcode@gmail.com>
+Matheus Tavares <matheus.tavb@gmail.com> <matheus.bernardino@usp.br>
 Matt Draisey <matt@draisey.ca> <mattdraisey@sympatico.ca>
 Matt Kraai <kraai@ftbfs.org> <matt.kraai@amo.abbott.com>
 Matt McCutchen <matt@mattmccutchen.net> <hashproduct@gmail.com>
-- 
2.38.0


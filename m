Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4846C433FE
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 17:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbiI2RSS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Sep 2022 13:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbiI2RSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 13:18:16 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D141C6A56
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 10:18:15 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d10so2013626pfh.6
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 10:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ULNGb9tTnDq7AKi7M3dLNiZZYNkelCgD96pUcBVLyoM=;
        b=IRDbPH7efBGH9aU6ANrf0yVh1NGUm5ouE32+dXEKkylZm4U/1pHXPaNTDt676TDZrk
         9dUPH7/gJG7A6RQtczpH2ohtzLZO/9x8SfA2kQewWbFXtgFrt1Z+SsXpCTO6V7jHhoav
         6UiDo5Q4Vu8sBluifgViOoe01zRFjuKZxYcjegEQVf02c+Fs/ol3OV1SeBP7eGiUXQy3
         iSktgBtfKrvvXnD1azTOkyjC6vfY3aYPrB0HJDYttO4icQHkSzXhG680xQQ06OD0aMK3
         XicYBlXKWZ2FKdQa86/tdA1vUgGiubVVloE4OV/CFCpVeKPMydbp8plq2Ln3E7u1BujG
         clNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ULNGb9tTnDq7AKi7M3dLNiZZYNkelCgD96pUcBVLyoM=;
        b=B9h8AzurXu8vV91Xi1H/Jf0E6Zc62hlbguc7ur3EgFhiYoX11qbF2B9ovEOE5rwend
         s+ZEMgqS4j7QzdVvlyQiP65CgaTcfqGXJMuAxNHAlWO20f7qUmxeDjrmHtfN4dF4Cb2D
         h7XmWm/7eXWZG0G/ui6GI5KkCGAk9WQI/x359qwm/Dh2WWYCq7+FUqmNN9B7AJPlCLBH
         ZR6XSdAHwm+rQSB+6M4TFGzw17TZSsc7iUgvqU6eMPzGF1byriqazso6C+48xY+cH7Ag
         sSe11PNnfSa8Gyp9NM7Eb7hdiVwFwRsk764TtvDupyHF8TmOLZ+93qtJtLWIWhOmY0Pv
         bisg==
X-Gm-Message-State: ACrzQf3oSxgNP0BaLkO4hrt7e+EDlmeU1JnaR0toHgYITq2zWROc7KTs
        eesZJXmc136uF3eXiQlZPBbHEU/bpMJ9Qw==
X-Google-Smtp-Source: AMsMyM4Q3ZuANQ6357HssYfGkrNCZriv6Cn/19sahWTtlINf6yAiIfaMMZ8VMYhO5RrNACNiu+6B7g==
X-Received: by 2002:a05:6a00:acc:b0:530:e79e:fc27 with SMTP id c12-20020a056a000acc00b00530e79efc27mr4531001pfl.61.1664471894944;
        Thu, 29 Sep 2022 10:18:14 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a5e3:efb7:4e1c:4a5c])
        by smtp.gmail.com with ESMTPSA id c188-20020a624ec5000000b00537b8deef41sm6437791pfb.136.2022.09.29.10.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 10:18:14 -0700 (PDT)
Date:   Thu, 29 Sep 2022 10:18:05 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com,
        arthur.chan@adalogics.com, david@adalogics.com
Subject: Away from the list for a while
Message-ID: <YzXTTVPcpRimOke5@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        gitster@pobox.com, derrickstolee@github.com,
        arthur.chan@adalogics.com, david@adalogics.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Apologies to those folks (CCed) who are waiting on reviews from me. Due
to family health reasons, I'm going to be away from the list for
probably the rest of 2022 and part of 2023. We are expecting twins who
unfortunately seem determined to arrive quite ahead of schedule, so this
situation will be taking all of my attention for the next several months.

Thanks for your understanding, and apologies again that I didn't get
your reviews finished in time.


-Josh

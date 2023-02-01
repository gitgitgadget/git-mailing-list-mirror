Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3945C38142
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 16:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjBAQj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 11:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjBAQjz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 11:39:55 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6175C3A9A
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 08:39:54 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id 6so6743517vko.7
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 08:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        b=g4tTRnuhvrg/WbOyfGhBIe9dgvRGF0AyoX6LMKhyPBUE7TqkkSxtAp1yBfHsGSRla/
         0E6yNLET9guq8nAz3kh7xds6wspQ3L6W2AzBnXyl4XfKPdyv/TG8tHS1iIO26mKcRy2w
         SyId+3d/iU54PK04OmktryR4yX8TG3v+mZbJ1A6nGhWGB73rC9aYKcYAo/ZSuc4UnmgI
         y6g4/HzGODAxsBn/PbH3qbxr/gbRXU8ovL5IPjc6WVZpjLYvq32SHY80oo6R5eyRkohY
         ZuCyPkB4SS4jvtPiQ9jIHQue0kv4IDAsN+7oRChQWcdF62KYnQaQbfYL1p8d19iD0/tt
         uDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        b=A8L9zeVTcpWIXI4CdVeD2Rlh7FuCLgj/Jy9bCO9MT4RDDBaVZlaL2sCO9o4fVG2buO
         0xbyDevzbGoHFDHidtNCyxToB6usJvDQSwX0boTEXwq91WzeUkMmiR98l5FymdbzJC7U
         jsTwrWQDK2h1kyfGUXMvX0gLH8h/F1W0W2Xti6AuVarSlI3vu8RwVx8VSJADdfVyWild
         ZqIPwmj2tYlFl8H7b6mbnvquKq2qvOWRdN54nWneRurIgBc5U71rqK6FQfcF771VqF6L
         a51PdYwNEMtFm7wEYHCcOZGZ/BVL4rD/nVCcrJIX0hJTuQoTboVrFVNKqsUQ6OIsaW55
         bQsw==
X-Gm-Message-State: AO0yUKX+bzw+znXXxGe3R3lWeU1hcJkD6pEO7oapwYSplbpU/mmyqydF
        42a2B7zxqrFfvq3/LmQ6a5NG/QENr+w=
X-Google-Smtp-Source: AK7set/e3tE8cjIYeZFc3Cn9ktHfr1lkiFQT/A8viL16SESKKPkGjSi0U/PY15DkrKKioa2AOJcjuA==
X-Received: by 2002:ac5:ccd1:0:b0:3e1:7586:c382 with SMTP id j17-20020ac5ccd1000000b003e17586c382mr1446871vkn.1.1675269593386;
        Wed, 01 Feb 2023 08:39:53 -0800 (PST)
Received: from smtpclient.apple ([45.152.182.20])
        by smtp.gmail.com with ESMTPSA id f124-20020a1f1f82000000b003e9c3c2d7c9sm1211250vkf.19.2023.02.01.08.39.52
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 08:39:53 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   ian gibson <pondlife3232@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Wed, 1 Feb 2023 10:39:41 -0600
Subject: E::mailing list::::
Message-Id: <F8E07F15-7EE7-418A-80B8-DA0D066FB5EE@gmail.com>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (20D47)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sent from my iPhone

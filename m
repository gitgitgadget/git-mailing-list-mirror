Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140C5ECAAD3
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 07:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiISHO4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 03:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiISHOz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 03:14:55 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451BFD13F
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 00:14:54 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l10so27091852plb.10
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 00:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=F8+AZpZ/m6iVHLS3hxG4g2Q6v0w7krM7VoOWAtOFGjgAH2YlypGl8N/NnqkBITrBo3
         UrwdNW6PJ/jgGlWkPdm0ePt79dbYjsrIYTpWvRisJzuqUYaSsqcnUZouLvGYC4eyIRPO
         VSGNmjC3IARxbmixodJ99wLvFP3egZMkknJ54fde20VE8aupt1CDaiYLfVj5JIHFLbvv
         TI/8LqtRez0htxsJs++Kh7kQRjKskl63qnt1nN4R77XqVL4w0aFmLlIYcl2iuy9a15je
         mXuct9V8Ugz0ehj3lTYqo3QvFskg3YUAeWdHNwc1hkpjvTcr0S111UC7aPOecDRIMbBh
         Jr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=00tpXsv6fg/s/kVaAGHQpioXPfTIAAHdOmaI7V0uJkNg/JFa642JH7I0u4bR9/QQq3
         kl0v6Hv4SeDLkoJgaX+qdnaD+IQrSbwbUPic+znTSoYrm50x+Uz5SkVkMZyvUAvxu3ks
         dJFFcnFalRUrakx2b4UPfy7zJXawMHxFvhq60ADFR0ZVmCflYPcR0e7WH4LJQ9nGSejf
         llchuxv4+7qkx8fVL1AwWqF06DTcd6YJ8VRBnSobC77TJ3wqQPjmuSSCXTvV3A8Q5iS7
         +FeLsge2yO9dSFy+blRYSX3ynEDhKnU85KYxV60hCjTd9EJ2S7U78Q/+lRAGMuZ9wbKK
         CnLw==
X-Gm-Message-State: ACrzQf3hkXHJmTIlU8NBAC54eSh4Svmt77aVGPutl0HafDhxTq1dcUQa
        NZkoaSYOt9Ef4sRM3RwUSH+DMQQXzetP42M/IAz/M5qJ
X-Google-Smtp-Source: AMsMyM7Ubk3A6JzzXq4KvhtiMypFMkoAOK3kDL6+eVQ9ZkggOYWVoqkf54bhrIap+CSrUirQh1XJBZPY/kaARDvTkLs=
X-Received: by 2002:a17:90b:4c07:b0:202:c1bd:ae06 with SMTP id
 na7-20020a17090b4c0700b00202c1bdae06mr18592701pjb.9.1663571693595; Mon, 19
 Sep 2022 00:14:53 -0700 (PDT)
MIME-Version: 1.0
From:   Skrab Sah <skrab.sah@gmail.com>
Date:   Mon, 19 Sep 2022 12:44:42 +0530
Message-ID: <CA+J78MWhp3qmbBhhSoioJP+d5eh-iEd_vHZdTNB69o7EvvXWYQ@mail.gmail.com>
Subject: what if i use makeheader tool to generate c header file, it would be accepted.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



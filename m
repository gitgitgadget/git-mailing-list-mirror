Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9749DC433EF
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 03:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiDEDUY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 23:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiDEDUN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 23:20:13 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB8333890
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 20:18:15 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id p8so10849807pfh.8
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 20:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=yvNenF4pxh6LmQuBm1efQVviCVYytNnAx+g1HFROfSY=;
        b=ST3X15CjGgAhr+YWuPhm7zt++AKgtqO0IXZZz5Ks6MKAKjcn+FVzsocz6LxhifNXEx
         +eiP5zs5OHE/bOLe2DHClIekFTdIocos8vzld6VguhUgL8bAfJ5pQAdEsIj+4j0//1kv
         fQDELfYUiLyLGGe3FKRZHXEN8a3FENp19uSQY9dnQ6de6g9MbBxHc1cAyCSmso6OyPGh
         t4lRMCIolb4R1Ue6ZveFtZps0+6TAinZImmAmmbZw7bL82aKq3LDnR0/DCGRN8VXKGUU
         9/5SKw/+36/EgB3JZq8tw3aqWPZynkhg+WACAsWoT72QwTZsu+JE3vS2a61OhWBbAv1I
         QE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=yvNenF4pxh6LmQuBm1efQVviCVYytNnAx+g1HFROfSY=;
        b=Zsz3pxPg4R3onW8Yzl4Mnjc+OR1KrIddasXgOaGj8z6hl8TrE8xyOmCzT3JTymDEpl
         X7Prh/xwbQZ9pj6NrZ9LYSkd/60+PTAKkf84OQrjceIrLqLi+pALJNeOgfrRqmiyzvse
         H+zimiRCrDg0srdS5Xxcqj6N4kJzjBB3ehIam3vJE2/hX2WtsP4qTm2y46cReQOBX8P6
         vyO1B6Doz0sqQGzk/goTOdl2mdJIQDtX8xLxVqPSntcZ6pXyY67yDqkM0QoBAM1rUdG9
         p+p2zv+4ipr5+avmvYPN8u+lkxPwZjESNSCN1+5rYeW5hKaBHLjYTX1w1CV09eJ2SEXF
         CYdA==
X-Gm-Message-State: AOAM531cBwqJzU6fzzZv620NEm+nWCZAbDktUlxQ8d7XslxQjP+WIcRx
        xhXkaR/HiTp3CASaoKDm6ZmHjMmNP6E=
X-Google-Smtp-Source: ABdhPJxN/HID/qwXFfFqggH4wTfoXjtRnQaGuHlkvU1TXZm99ZIOS1dMcdhKEnSWrOWBZMwawPL9xw==
X-Received: by 2002:aa7:88d4:0:b0:4fd:ad26:c52f with SMTP id k20-20020aa788d4000000b004fdad26c52fmr1361022pff.25.1649128695075;
        Mon, 04 Apr 2022 20:18:15 -0700 (PDT)
Received: from [127.0.0.1] ([49.204.131.145])
        by smtp.gmail.com with ESMTPSA id f15-20020a056a0022cf00b004fb32b9e000sm14044323pfj.1.2022.04.04.20.18.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 20:18:14 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:44:31 +0530
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
CC:     Dan Moore <dan@fusionauth.io>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] git-scm.com Heroku credits update
User-Agent: K-9 Mail for Android
In-Reply-To: <Ykt6lPF0JC1Mg2Tx@nand.local>
References: <YkcmtqcFaO7v1jW5@nand.local> <Ykt6lPF0JC1Mg2Tx@nand.local>
Message-ID: <6BD35402-7646-4B00-8831-A186C0E7CC02@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5 April 2022 4:39:08 am IST, Taylor Blau <me@ttaylorr=2Ecom> wrote:
>
>Dan: thank you very much for your gracious offer=2E Does anybody have
>objections to having some external support? I think the only change to
>the site would be adding an entry to the "Sponsors" section of the about
>page [2]=2E
>

If that's all the change that's required, I would be in favour=2E

Thank you for offering to sponsor the git-scm site, Dan!

--=20
Sivaraam

Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F6AC433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 18:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347382AbiDRSgk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 14:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiDRSgj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 14:36:39 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D054824F07
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 11:33:59 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p10so25440687lfa.12
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 11:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xYfFOqkFdfps2aZ1Djn1n88TjKq8HhcDMYXh5Ai3mM8=;
        b=CP2Cf1jDuQqameFDSDRHpWXoNu2rHnl7WBdKS5fNhabm8TYLlPJR5OQo5ZMe+bLhAL
         R6qrMcb0BBah32TfxrS7IEpcxNCcKE0XDd8hIWr15QSsIgtPnS0RZwN1NeeMp9z940yJ
         md5NlLDTxGkt6/bYAkistW5QZT53MI91iVdFGf61ybKX6KSTWsKnKeMyhe9xe0DbYXY/
         +WvQf6kabzwYBCDYrjAYo5gf1LfTLIaGZ/CARMj8OZ7azKvec+QZBUFp79Wey2SDNkQM
         +0HwaoGO0w8Tgr0grGy2+GxDOWHOfwPMVOsWdCQ4JhzNRxdcKfqSjYgfiUxNHn3AxkWF
         xLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xYfFOqkFdfps2aZ1Djn1n88TjKq8HhcDMYXh5Ai3mM8=;
        b=yJN/WEaJXVIx2UjlvmOJwsGvsg46zauExheQrAJBNupek9GxsYk67yj/BMD+qzVbVV
         cxupwFiErIYcL3y2uefxHuFnIAq4ir2DqjYxHs5GGiMO/Ld3LterkmekFwfENQoObgpR
         8MgLRPfioKhd0C95067SdmLdJn1z+E2rAeOd96bLpiOcF/EiI9755gSEi5FTJkYmL/1q
         WthrSLmSCuYzu5b9H2I4xDZzYQTxlWDSzA4mlogB7JfMmWk69OmtwsfGx88oHC3egQmc
         zPCkURluYh7+ijGoEglawsMuFTdrmPrvt+bZ2BUon9yPHeuYXAsqhXl/3+nyPfeCYlFh
         T+1g==
X-Gm-Message-State: AOAM532tN1R0C769rtGDi6bppi5Cy8ZAL80aZj0mIqNRKslJ0EWHko0R
        ITihQK4THPq11CRcnI8jeKxLIhsm127fd+fHoU8=
X-Google-Smtp-Source: ABdhPJzSEahiSn7mqsoykh/m3tLsAlFekVshDceSfkwn2GfTlSeMo8FzFPcpYPUS2EjBEot2o9c+LtXQCGPnXgf5PSo=
X-Received: by 2002:a05:6512:3403:b0:448:5f92:7b0c with SMTP id
 i3-20020a056512340300b004485f927b0cmr8353682lfr.237.1650306837878; Mon, 18
 Apr 2022 11:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAO2gv81zCGbxNN_7a2j7sJZ_fbHiFXf4YxagddWLBWw7-ki5zw@mail.gmail.com>
 <660025e5-637d-8e93-e7ba-65a3ad474bad@gmail.com>
In-Reply-To: <660025e5-637d-8e93-e7ba-65a3ad474bad@gmail.com>
From:   Plato Kiorpelidis <kioplato@gmail.com>
Date:   Mon, 18 Apr 2022 21:33:31 +0300
Message-ID: <CAO2gv82L_AYkXMKO7tuxF7AoZMU-LW+q+2S4nCVQvhuM4+UMFQ@mail.gmail.com>
Subject: Re: [GSoC] Contributor candidate introduction
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Shubham Mishra <shivam828787@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 18, 2022 at 8:54 PM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> Hello all,

Hey Kaartic,

>
> Just a heads up that the proposal deadline (19Apr2022 18:00 UTC) is
> approaching shortly. I noticed that Abhradeep has submitted his proposal
> so far. Others, do make sure you submit your proposals in the GSoC
> website before the deadline. Only then can we consider your proposals
> for GSoC [ref].

Thanks for the gentle reminder :)
My proposal is nearly complete. I'll sent it for review in the mailing
list and If the time allows you I'll be grateful if you review it.

Thanks,
Plato

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B65EB64DA
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 04:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjGREkP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jul 2023 00:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGREkN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 00:40:13 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C23E52
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 21:40:12 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-262ef07be72so2548350a91.1
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 21:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689655212; x=1692247212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W0nYlGBMcB3gI/PHcGiKtOrUfhUNqDucvBPe7EMTYu0=;
        b=JiDyBB30GyRQrKan3kL5hY6acu4k2aXZuho+ToLc71r1mYgHt7I0tigg4L7Exhbx1e
         /oTHuTSoFk8bbGJRQ7VBNxF8UTlf97klPeBGL/luesR157TTHU/f2tKnIF+POjE0lVoR
         jrkJim4E97BubrWdmWJEC4xDw2rf3XtdqbOpORWRx2P6mraUB9fa02GFcpBNxrEQqbXD
         Wru8v6EdygVvcJwHUIyFwxD6kF4uGnZBNRErpFGsdRagoisuqj+Y86ax9VMRTcWsxvGR
         L+BSN4ft2XAW323FCpUjKjkoKI7xQ9XZ97+lTC27kMiFu0FrY82vYbjCDijAavjTO6bw
         /vIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689655212; x=1692247212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W0nYlGBMcB3gI/PHcGiKtOrUfhUNqDucvBPe7EMTYu0=;
        b=b23ulWHliOMGaPWniyOKlBeaJkiyaup6/Ybqe9xjNATkOx/2iY16GEDTu1vuUmXEz/
         93Abbmf8pxwi6ltLbc1V6kTYZeoU9jhJMWGXPvi+XHBQAJzzLv1znSFs5TY6jnmdr0CR
         6S9DhXCFiRL2G+MtSARp+2Hv3uz+gFTkZfGk6gUz6W8n1NlvEGxu+pljfWJI/TPEyAfm
         +vRkvQ8b/S6V4+Y4C/eKU7hhshFVkn1mzNBn270DHLnJ34kbPTDgfwt+xib7/mHZ2a+f
         K0mD2X2vx+nNcVQTqQykl11wNA5+2LCQwVr/Vlli72VEhCVV6Lk2LX55Rh/zmSrB0F+3
         Ol0g==
X-Gm-Message-State: ABy/qLapbROwJwKcNm6/OQkQ0cKprDEjjuCK+hn8JV2/vf44BEKVAtyv
        v5arnwYrh7v81yaV00laT/eieYXdecZfzXCdQhb/le6Rf0Y=
X-Google-Smtp-Source: APBJJlFCyUEBLMN9LHoF3YDpcD7lLYh5tUOp0W550iDrc1570Jrq31+UeynOc+rHO1PrPLNNKnRpp1AzXTHJEi0nQoY=
X-Received: by 2002:a17:90a:fd06:b0:263:30a0:643f with SMTP id
 cv6-20020a17090afd0600b0026330a0643fmr10285890pjb.21.1689655212308; Mon, 17
 Jul 2023 21:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <kl6lilai18zu.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6lilai18zu.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Luna Jernberg <droidbittin@gmail.com>
Date:   Tue, 18 Jul 2023 06:40:00 +0200
Message-ID: <CADo9pHhyjeZoRX8b00U_CCHXBPTodsrYgW6oJL4pmyFV02zHGw@mail.gmail.com>
Subject: Re: Join us for Review Club!
To:     Glen Choo <chooglen@google.com>,
        Luna Jernberg <droidbittin@gmail.com>
Cc:     git@vger.kernel.org, Andy Koppe <andy.koppe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

17th July not 19th ?

Den tis 18 juli 2023 kl 00:21 skrev Glen Choo <chooglen@google.com>:
>
> Hi everyone!
>
> Review Club is happening this Wednesday, 17 Jul, 16:30 UTC. You can find
> more info at [1] and on gitcal [2]. We run a session every other week,
> and you can find the full schedule on gitcal.
>
> This week, we'll be discussing Andy Koppe's new ref format specifier to
> pretty-formats [3]. Let me know if you're interested and would like to
> join (off-list is fine), and I'll send you an invite.
>
> See you there!
>
> [1] https://lore.kernel.org/git/Yfl1%2FZN%2FtaYwfGD0@google.com/
> [2] http://tinyurl.com/gitcal
> [3] https://lore.kernel.org/git/20230712205608.1806-1-andy.koppe@gmail.com/

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEBBA1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 19:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbeDJTOz (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 15:14:55 -0400
Received: from mail-pl0-f52.google.com ([209.85.160.52]:40669 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752558AbeDJTOz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 15:14:55 -0400
Received: by mail-pl0-f52.google.com with SMTP id x4-v6so8139996pln.7
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 12:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rckzzhihsuk3PRB8cU9ZE244HmOalDLDryhIS/HOIes=;
        b=HRV6vO2upoWuy8UmSaBhk/Tg/18Jbmzg/BUZEQTbRHiuzP4whhlJQ/o0GEu6IkhNbv
         z31jQKjFkxmWIMrbUjHwHzk7fqaM1p4RI0PKQ2DxJcH91DDTKtHaKznPKIVUaoHu8EiP
         W3NvluGUei28ZS0IUHuGzPaA9EfpMB74erbY/NsUNRlijmrUgL+a+Ljb4MnprwKXP8CX
         KLEaSwbIVxfZ/SWMM08l++StY+cQxYaabfL3ti2VC53EUz9/81JQcgu4zgVkwgT+xJ9Y
         I0aiPaGKt3Q84MC0M7cHNtEOBIIsREo1nEiRxQpnqkxziCv2X6FQBfRSRvCJLM09VN8/
         thCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rckzzhihsuk3PRB8cU9ZE244HmOalDLDryhIS/HOIes=;
        b=k1R6jH2lLO4uThHoExoy5fpH770bIKsKVYCTqCDFH+vdcPFLOk2oJ0Djeyid8niJ3N
         mfPJyswaiDrqUocx07tJI9m9f3WsPxVUdi1Yd4Rg/P30ibguTzFP94WXxkk+osL2KMR0
         z+F9WaEzmZEmRyWMOhaw26efpMqYHFxlo3zTnrwAPbVH60upDhJU5QgBh+I8GaVrGF3v
         4SCvjm2akq6B9XtduKEfNe5sdeZXQvJ/c4KYzWgXKKMWtAmxQRIWpNFCQ05T7kwatEk0
         pC6nMf7j3RniuUlev7iaY5CarHGxouojLbn/2x+Kgrz2bfIs7narWE5+OWmpC0x9yLFc
         QShQ==
X-Gm-Message-State: ALQs6tAQWvNPcgrbBZxoygDX+4tbLrnkbLfp9UI8NXvk5Ad7nvPAsPkl
        HRzGWVMdg9NAxozu0wVSwVoiNaidZqhm9zpYo561hg==
X-Google-Smtp-Source: AIpwx49RCg6NC9Vn86TAL4W/R0M5ArJQTaoBXkcQtbLfjLw53bSbOeESXfbZfx68pimEgGJ2siVM0q5kqlV7U23W9BY=
X-Received: by 2002:a17:902:7683:: with SMTP id m3-v6mr252088pll.340.1523387694871;
 Tue, 10 Apr 2018 12:14:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.178.66 with HTTP; Tue, 10 Apr 2018 12:14:54 -0700 (PDT)
In-Reply-To: <20180410183224.10780-3-asheiduk@gmail.com>
References: <20180410183224.10780-1-asheiduk@gmail.com> <20180410183224.10780-3-asheiduk@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 10 Apr 2018 21:14:54 +0200
Message-ID: <CAN0heSrGrtRi-xCsSEOrW0D+OvMHjbE_YEvFtQd9f+FH+h5iiQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] doc: align 'diff --no-index' in text with synopsis
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10 April 2018 at 20:32, Andreas Heiduk <asheiduk@gmail.com> wrote:
> Comparing
> The two '<path>' parameters are not optional but the option
> '--no-index' is. Also move the `--options` part to the same
> place where the other variants show them.

That first line should probably not be there. The diff LGTM.

Martin

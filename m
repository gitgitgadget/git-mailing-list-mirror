Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8E6C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 16:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 322AA206E2
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 16:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgD1QLe convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 28 Apr 2020 12:11:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56021 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgD1QLd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 12:11:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id e26so3421593wmk.5
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 09:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pD9rrHP3OqWbUTIAdL/4kgFHpT5pRYbvfwEZdBdxUeM=;
        b=rqyJ1ziStju5We+Q2c/IKIxamTDSDuJf7UnUmqUbZhixClcKDCcjb58dvndLLhmEDx
         UcjqlAi23vUnLezh8cDj9og7iraUc3GU0EvLnKjPXx8lU3b/VwluYKuue72fttPU1ues
         zvAHj8pxo8LTaPKHFvP1BtQjHqyf1CxZwFLCdXCd6B/nN9FuiYlBX+4zpCrNfP/XFdAm
         0MsVwsa4wF3ht/DnKww4Y/u/Lu2AbpQ+nVCeplp8nXYP8rB3cHo6h2e4Yn0FdRPt3+29
         PuasNRSBSB1zpcFc/t8KlbmFW1Vf7aLHxNi8V5dewyvVoD1ejmkedb/PTySN3Jzb2Yeo
         /pJw==
X-Gm-Message-State: AGi0Pua2T8ZfaGswf1hSXOFSdJtib9Gr4KXVxW8cG71rfpOVkKopIu5G
        ZwaWwXcAfSsIqLVooj0xuOwescv0Nq/nnVqkcDV8N8eb
X-Google-Smtp-Source: APiQypKL3W2SGMlUWeJpfgxu3kxTSJWqUwcABWJCwG6MU3ju5L4di+CUmUskfivv82o2Kc0VZvTGzSFzP9VIMK2S/Ow=
X-Received: by 2002:a7b:c213:: with SMTP id x19mr5252926wmi.53.1588090291877;
 Tue, 28 Apr 2020 09:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200428104858.28573-1-carenas@gmail.com> <20200428105254.28658-1-carenas@gmail.com>
 <20200428105254.28658-3-carenas@gmail.com>
In-Reply-To: <20200428105254.28658-3-carenas@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 28 Apr 2020 12:11:20 -0400
Message-ID: <CAPig+cTjZQ7csu78jFx-w1SfewptTrOeR68aEwst7F2qvowR4Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] git-credential-store: fix (WIP)
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Dirk <dirk@ed4u.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 28, 2020 at 6:53 AM Carlo Marcelo Arenas Belón
<carenas@gmail.com> wrote:
> From: Jonathan Nieder <jrnieder@gmail.com>
> Subject: git-credential-store: fix (WIP)

Um, what? Did you forget to squash this into the previous patch?

> Helped-by: Carlo Marcelo Arenas Belon <carenas@gmail.com>

No sign-off? (Jonathan's)

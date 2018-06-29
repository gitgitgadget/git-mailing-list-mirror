Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C7601F516
	for <e@80x24.org>; Fri, 29 Jun 2018 11:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754747AbeF2LKm (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 07:10:42 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:40145 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752730AbeF2LKl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 07:10:41 -0400
Received: by mail-wm0-f53.google.com with SMTP id z13-v6so1647901wma.5
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 04:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oeJkKA/HnKSTYtNnLoNfj/yXs59disqgqC3Z9/QzfrA=;
        b=Ak3jTXIO68tDdXKgliS2z88RotlU33zw4cQZa+ZO1p300D488/lADGPvYsYhFdx7Rk
         6uggkVusXPCGJi5btAvQtQkxS7/Uw9inFWgtRLs2tV53TDgv/DryQl1UyO/ZRo/LfE6+
         dxDmcV36n/SNG2zA4SEWnnd2ALuPt0cEDQvnmWju3rXLly59rT45tAE/VjvcxLtr43Ay
         OFrzfH8hL57OKoloASmUpVw6mp5zmavrFtLPsXkmGcSTI3bmWXDgMM/3i9NEgTOtHHQJ
         7U/hTQLSI7GJBOtzxl+arVl0sR88r2cK6L2Zf2KrZQQRi3hvZR0x/6Mz7EMyyQL20Old
         0KjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:cc:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oeJkKA/HnKSTYtNnLoNfj/yXs59disqgqC3Z9/QzfrA=;
        b=toNSHV2W6Pi4BNqVvyyE2IeNd+EL6hu1N6gQvRVmP1AhsYRf5PHHMoAoq/Ti2nGuaz
         JYI1WACo4El6yDab3FwvQnY54wPAVoNLiwNNhVa+7lDhIIN+SdlecUPaJYn1iH8Tk7RT
         UDZFqI1bSKcw/l0N3a9MHNLen6q8+zO91mIcs4xHAeV86Bzf3XW4G3K2vQ+y9Mw0TyGh
         gNSZ0wGep94SJQPBVA2D7No84ZOx5z0e9PPBDBTg6zS1SFHIGHgpMu4wkotDkGln+B6f
         dIIxauwNNtLgGMkySqgznH2iLqd3vzMSWoDx+VJC/STLal4esQmTnFcEnld5ObC6Bq0O
         SvOg==
X-Gm-Message-State: APt69E2dtoFnUtnmTXfzykJgeZsrJ3Cx8pCkL0+Pg490qSIzYMN/FPMY
        FGLTGICWg6NL43df0ZOuvvcVvxOY
X-Google-Smtp-Source: AAOMgpdHLOxHIf4HZZOGg8KHO4INlc0BLJcv0k+SdcY9fFA0Xsjk3Dsa3WaOKtSQFJvv3QW+I7zyKg==
X-Received: by 2002:a1c:abc6:: with SMTP id u189-v6mr1479269wme.64.1530270640005;
        Fri, 29 Jun 2018 04:10:40 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-72-143.w92-156.abo.wanadoo.fr. [92.156.124.143])
        by smtp.gmail.com with ESMTPSA id r2-v6sm1634392wmb.39.2018.06.29.04.10.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 04:10:38 -0700 (PDT)
Subject: ag/rebase-i-append-todo-help, was Re: What's cooking in git.git (Jun
 2018, #07; Thu, 28)
To:     Junio C Hamano <gitster@pobox.com>
References: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Cc:     git@vger.kernel.org
Message-ID: <56fc2859-6fb9-62c5-f327-26efae0f38fe@gmail.com>
Date:   Fri, 29 Jun 2018 13:10:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 28/06/2018 à 23:40, Junio C Hamano a écrit :
> * ag/rebase-i-append-todo-help (2018-06-14) 2 commits
>  - rebase--interactive: rewrite append_todo_help() in C
>  - Merge branch 'ag/rebase-p' into ag/rebase-i-append-todo-help
>  (this branch is used by ag/rebase-i-rewrite-todo.)
> 
>  Stepwise rewriting of the machinery of "rebase -i" into C continues.
> 
>  Needs a reroll.
>  cf. <nycvar.QRO.7.76.6.1806261125330.21419@tvgsbejvaqbjf.bet>
> 
> 
As I moved append_todo_help() to `rebase-interactive.c`, it should be
because I did not changed `msg = _(…)` to `msg = N_(…)`.

It was pointed out on IRC that it was not necessary, after all[0].
Basically, N_() is needed for static variables, not for "dynamic"
variables like `msg` in append_todo_help().

[0] http://colabti.org/irclogger/irclogger_log/git-devel?date=2018-06-26#l44

Cheers,
Alban


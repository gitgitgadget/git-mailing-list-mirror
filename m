Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C46C1FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 18:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751573AbdBFS7o (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 13:59:44 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35521 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbdBFS7n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 13:59:43 -0500
Received: by mail-pg0-f65.google.com with SMTP id 204so9783431pge.2
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 10:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7GxN6JbrdoLKkFLgY4/9lX2uIc8btJhsRmExDyu4uoc=;
        b=msEHK4W6CGRkguL3HgcgBn2AuNanTSx9/Xb4qD3ev5b1e38WtEeth5cc+BAQPYr+5t
         cue8IgQvptpL0ggnS2+ThP5LJcYbl1T8xhTits/IOGOneAEBIGlcJAPfrUw8KrlyZVKI
         BLKZ/Sj5Yj1wwz9sBVv/kwcaQTXhR+hk4Od7i6leNgZ7OCbDxpAUg7QEqXp4P9JAO3QR
         KZ7sHnvzint0VyGS1lyl5mCR16CWT63mXnVFiPrPb0rB0qZGCJs+jcZ96LLc9fwEwTvq
         ysShKJAZel0cq9PD03iUEh57aQS8ciphxKVjAn9modU9GpgeNn1XPNBi9aexulur1DZ0
         1ong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7GxN6JbrdoLKkFLgY4/9lX2uIc8btJhsRmExDyu4uoc=;
        b=R7oc8wx7FtrrP25X+sMjlnDD0oEd7DQINOoupVeRMvDJ9YZHvdknpbSEC60vRQCHjD
         yJ+P/bX2Z09ri1O6dydVwT5ieGfDDhErA+4db00yRCStUPOOE7JNvs30N94JyMxWxRlw
         5n/SL5JmN4SmdQbDJ4kYFWx9VtCLMmH9u+/g/F2s7Wt+jpICBL88zHXZ5NXbczxyIzcW
         KA0Y5QHxxJM2SjF3LU9q/anzmyDhnVA1jazCmFeVOWinzOCJbG9Xp2Ave/8d6prC4ote
         OO6R06IzuAF+EKrdw2bWfZ0O8Kw9U+elvbu+bboM7S++S8S59HVJ49rsEeD1sFAfx3IA
         964A==
X-Gm-Message-State: AIkVDXK2JGV9quPH5aL5xz6avKmXaiR0dIDN+drYs3N+1fbqjzQfCFnPxE/A1dffhKICoA==
X-Received: by 10.98.57.154 with SMTP id u26mr14850446pfj.136.1486407582435;
        Mon, 06 Feb 2017 10:59:42 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:310c:cda4:fdbc:2aa2])
        by smtp.gmail.com with ESMTPSA id t6sm4637410pgt.8.2017.02.06.10.59.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Feb 2017 10:59:41 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <patrick.steinhardt@elego.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        ps@pks.im
Subject: Re: [PATCH] worktree: fix option descriptions for `prune`
References: <c2af75361b7b357fa905ab072bfdc45ad055ca49.1486386803.git.patrick.steinhardt@elego.de>
Date:   Mon, 06 Feb 2017 10:59:41 -0800
In-Reply-To: <c2af75361b7b357fa905ab072bfdc45ad055ca49.1486386803.git.patrick.steinhardt@elego.de>
        (Patrick Steinhardt's message of "Mon, 6 Feb 2017 14:13:59 +0100")
Message-ID: <xmqq60kn2lia.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <patrick.steinhardt@elego.de> writes:

>  	struct option options[] = {
>  		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
> -		OPT__VERBOSE(&verbose, N_("report pruned objects")),
> +		OPT__VERBOSE(&verbose, N_("report pruned working trees")),
>  		OPT_EXPIRY_DATE(0, "expire", &expire,
> -				N_("expire objects older than <time>")),
> +				N_("expire working trees older than <time>")),

Thanks for sharp eyes.

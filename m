Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50BA6201A7
	for <e@80x24.org>; Fri, 12 May 2017 20:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758595AbdELU7e (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 16:59:34 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36456 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758464AbdELU7d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 16:59:33 -0400
Received: by mail-pf0-f193.google.com with SMTP id n23so7100654pfb.3
        for <git@vger.kernel.org>; Fri, 12 May 2017 13:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XRn/1HG7PNBipGGLjUGQkrysik+XIvqxpzhchtxNCa0=;
        b=bEcHKusS/+/t9dQlQFdNtIWcvvic0FHQZXKcX4o93FLcXuQjMxcbPxjPtw95ilHqlA
         IJ6ifTj+MBZdH7U0eeyGDsaQfl2ysN/2RDRGJ9UfpngeAUh79aq16Trqud9TBMpjOqP4
         k+WXPTa+uloZ8ORVQCL6iEArCXmgW2anFpIYGaa/uyY6eLLxT4wfg6HNFXJxdXeRIw69
         QsrS0r0fiyTwqbhLomKpS9sbmUqUADaiFm2jewIWZaTGpPo8wthdstYYoxQp2JY3tdfF
         QoygnsCNFfwQ3HH/+P59+sAmm4Zqc9fig3yvHzy/K114FgtEHw628l5nDibd3LW7/+FR
         bYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XRn/1HG7PNBipGGLjUGQkrysik+XIvqxpzhchtxNCa0=;
        b=uKWrMoaoGQlDD009s9uIrFlp3PaKvbosEaUgVH1ajil4lJwjortn6UH5Y/CzX0EfXs
         qzG9Ce7RsSJeU2/YqEFaLf2UxOLecQ+KE3VG1GorfRJSKsIR0ShUyP4TO9njU7uP3IMd
         eD4YtHnvxfeEZhaEZe78QiCPcyKWeDMFEKVWDD6vNG668XAtX4hRwqq+jumeDTnoRApJ
         AOpBcXQhvjXvcKRb+Vl6hoc7OUWlShaw1jOpVhRtUWWbzNS6U1rtKSfkpTfQidn80RnO
         hNwWqjD108Tn8sMoh8mmM34nM5qoC8buTz28dYTOqNjpnFtRkfrY13vX1pUJURaLq9Px
         bZoA==
X-Gm-Message-State: AODbwcBTGj5S42D/wi0CVxQZwgo7GYkJUkW1RBlEOWG+Gkp6ksESdqcW
        v5ipjv5vcL8cqBFTJErhTA==
X-Received: by 10.98.252.8 with SMTP id e8mr6697119pfh.190.1494622772793;
        Fri, 12 May 2017 13:59:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:954c:c08b:c855:8b7f])
        by smtp.gmail.com with ESMTPSA id h28sm631655pfd.55.2017.05.12.13.59.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 May 2017 13:59:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefano Lattarini <stefano.lattarini@gmail.com>,
        =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>,
        "Arnold D . Robbins" <arnold@skeeve.com>
Subject: Re: [PATCH 1/7] compat/regex: add a README with a maintenance guide
References: <20170504220043.25702-1-avarab@gmail.com>
        <20170504220043.25702-2-avarab@gmail.com>
        <xmqqwp9m99zw.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1705121214470.146734@virtualbox>
Date:   Sat, 13 May 2017 05:59:30 +0900
In-Reply-To: <alpine.DEB.2.21.1.1705121214470.146734@virtualbox> (Johannes
        Schindelin's message of "Fri, 12 May 2017 12:15:37 +0200 (CEST)")
Message-ID: <xmqqbmqx6bbh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> - rather than scraping the files from the CGit website (which does not
>   guarantee that the first scraped file will be from the same revision as
>   the last scraped file), I would very strongly prefer the files to be
>   copied from a clone of gawk.git, and the gawk.git revision from which
>   they were copied should be recorded in git.git's commit adding them.

Wow, I didn't even notice that was how the "original" came about.
No question that we should be taking from a known-stable snapshot,
not from a moving target.

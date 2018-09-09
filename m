Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 793391F404
	for <e@80x24.org>; Sun,  9 Sep 2018 18:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbeIIXAI (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 19:00:08 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34434 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbeIIXAI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 19:00:08 -0400
Received: by mail-ed1-f66.google.com with SMTP id u1-v6so14889728eds.1
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 11:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=WMjkn7jsZBQ8WHtXiL6MaK57fDR97hePCMHEsunIobI=;
        b=cfoySaFwxbSx5Npg9rbvUUNdRiTlhUzc+kcOdOOh5LMT4/Ky6EZAT4ZFvX+2d1ZJji
         4IMWNymCoKOzRLAyiIxOUnW2+o40C/6CTw28WNMuK3RxguAB/RcCNtnFK9qExkkuiZi9
         e7wS6YTmensxuD4uC/6LqbwjfLIx2Lc0lUkbGtGc5b+TH8z3N7U8PRuKH9RG9C4mQ+qZ
         9lR2/IUNfO0qqh/owwezsYpOOpw+kzNcNL9SgCRfYz2hICHAC62HKlIfNJA2KzVAP0N4
         fc5UUQiBQA3tpgPiT0dSdfC/f4eQUEJwy6UNDkCdml/9dRBPAYPqNC4VxKBJWC8p/wBM
         3l3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=WMjkn7jsZBQ8WHtXiL6MaK57fDR97hePCMHEsunIobI=;
        b=ik4lrLvPFCuarwoHPICBRnfMjkmSN2A+2ASEIEvL46zMfq5dasN59ab9qGWfeQCQ7A
         0XKzYp+DXPfNDeA+rG9DZig2vHHKPIEglqy2ia0HI2MerMwDXWnAaIJhDzuBvR5wlWec
         ckVWV8UmmJo6IDB9KT5cZ1k/HMrPvDNPnr4dcyY80Ln/QXOUchXMfGKPMqD+NTbvEHRP
         Hqqb2nQWL3HqyyCfYW/tw5zMzMmjqEDIv16E77RZvGh4256/RURrlINbcQ6KtSORc1w2
         aDcotfmCnm+gPVtCy8Z0nguM66NBw0exEDf+7w55Uva4XRXiEWvbNzq9cqcwsqUwzoDR
         fkHQ==
X-Gm-Message-State: APzg51C5cPJcSsSXRmXYByYCQayXSEwgnAx4oief+aNAbS8Z53AHxI/S
        Srj6IruIGyxdiNn5jA9xvyA=
X-Google-Smtp-Source: ANB0Vdbdlh2//rPAzI8FhqAPt7xJi2YW0bYaBGJEDUCMjz46jWlMWuIP+OO8HtPQ0JaXoivbD//8EQ==
X-Received: by 2002:a50:a8a6:: with SMTP id k35-v6mr18613009edc.135.1536516580644;
        Sun, 09 Sep 2018 11:09:40 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id x22-v6sm7389042edb.8.2018.09.09.11.09.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Sep 2018 11:09:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/6] Merge remaining t/helper binaries to test-tool
References: <20180909173631.1446-1-pclouds@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180909173631.1446-1-pclouds@gmail.com>
Date:   Sun, 09 Sep 2018 20:09:39 +0200
Message-ID: <87o9d6lezg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Sep 09 2018, Nguyễn Thái Ngọc Duy wrote:

> Last time when I added test-tool in 27f25845cf (Merge branch
> 'nd/combined-test-helper' - 2018-04-11) I left out a few test programs
> because there were a couple in-flight new tests that used them. All
> those topics are merged now. So we can merge these to test-tool and
> call it done.

This is great. Just a small side-note: Am I the only one who misses the
2.8.0 days when you could do "git clean -dxff" in the t/ directory to
clean up various test crap without breaking subsequent tests?

That went away in e6e7530d10 ("test helpers: move test-* to t/helper/
subdirectory", 2016-04-13) when we started building stuff in t/helper/.

So now that this is one binary perhaps we can build it in the root
directory and get that functionality back?

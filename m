Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7F131F404
	for <e@80x24.org>; Mon, 17 Sep 2018 19:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbeIRA4j (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 20:56:39 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:39818 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeIRA4j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 20:56:39 -0400
Received: by mail-pf1-f174.google.com with SMTP id j8-v6so8021863pff.6
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 12:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=214vM5I293fmV5EaR+ltCHzi4dbeI5+35jmXOX5qUdM=;
        b=qPiUpzsHhDrjyuZ8VbP1P8fo+i6kHTSLX2HrN/ENJGSITk3VHiD40eb11eBlY/3fRd
         bV1E88PRm38BfyAxlxau1Hs9NRnZ7/DmglFEQ9DYjxTVwCkgp/Cnq+jvUEo2KlOJ5tKu
         qsqCpgbOeX+zzREvkbScQtf1MIJrxdd9L8PK3lpUunGEAybYTc8CzkJodZsjZ5R4FqFM
         TjsSfoAhCI5RRzhrNkI34wl4kXaL/8wOQv4wpt4jHq7r1HhIxYQNJBsXnSDleGJOL1xS
         ONpKhQZbTUPseoqbWw6xCJczSRakMhM2DSt7Y4XiDiLd7FFb9gOgC5pTOwCbxzX0Q9d7
         BOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=214vM5I293fmV5EaR+ltCHzi4dbeI5+35jmXOX5qUdM=;
        b=I6++HBlgtaGEAccfeCbz/eZOinc2ibZsFc4qYWtEj6KDv12tQMnPgZIE2h39BwrBEQ
         vybwPA68eIaq6h1W3lUJyELWW6SFYwKRvD8Wyba6JIlrI87z7tyXG4iiQEOP/A4PTwPq
         n2S+6FGruu93yyeWCg4/lAoGWuTDSPJjJpi0qu91OPwZGwCvuIjIqV2i6UP4eM7aBknz
         iRqMFJm3sD9+DjD4gf0jFa3j6NCt1fAne7Qbiu/5Ckb04zCdYmMH3BhlI/TtT/L+zFBe
         qoIJchMqNA7YrA0fFNXXql/um6wP7AUjcMRe8J4vUCfu/wfkz2wcdFLEHdQaxvDg1jor
         lRZQ==
X-Gm-Message-State: APzg51CUWzLEkkqLFHoXmIOSdEJFmcgayOFRTp1Mrl4CQ8yBWddXAgIy
        VmuUPOmJgt8EESrGriS5937xUKZQ
X-Google-Smtp-Source: ANB0VdZQhrus13xqX1Ckg//TNDOji9YW3F170lDRi2UHX3midYX53gFGi/KTu9pahlam2LGRDOewsQ==
X-Received: by 2002:a63:ef4f:: with SMTP id c15-v6mr24351269pgk.368.1537212475527;
        Mon, 17 Sep 2018 12:27:55 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id r85-v6sm28440707pfd.144.2018.09.17.12.27.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 12:27:55 -0700 (PDT)
Date:   Mon, 17 Sep 2018 12:27:53 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org
Subject: Re: [Question] Alternative to git-lfs under go
Message-ID: <20180917192753.GF140909@aiede.svl.corp.google.com>
References: <008d01d44ebc$0d668df0$2833a9d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008d01d44ebc$0d668df0$2833a9d0$@nexbridge.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Randall S. Becker wrote:

> Does anyone know whether it is practical to rework git-lfs under a language
> other than "go"? GCC is not even close to being possible to port to my
> NonStop platform (may have tried, some have died - joke -  trying). I would
> like to convert this directly to C or something more widely portable. Is
> there a protocol doc out there I can reference?

Can you say more about the context?  You might like

 git clone --filter=blob:limit=512m <repo>

which tells Git to avoid downloading any blobs larger than 512 megabytes
until you know they need them.  See Documentation/technical/partial-clone.txt
for more details.

Thanks and hope that helps,
Jonathan

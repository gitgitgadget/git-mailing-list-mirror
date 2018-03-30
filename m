Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 936CA1F424
	for <e@80x24.org>; Fri, 30 Mar 2018 09:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751322AbeC3JY7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 05:24:59 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:51118 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbeC3JYz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 05:24:55 -0400
Received: by mail-wm0-f45.google.com with SMTP id l201so14749943wmg.0
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 02:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=IhEaBINMOt21xyDLDwNy15/AjdvWwNFihN2hMjcNRmo=;
        b=XHEIhSxpoEVgIm0SU4Zk38LhjmrE0qGiyaRcuuTRF5qHVt2IacBpUCybbrZx6cCUGn
         dKNyX3q3P05cYbyL7mLT+TAc6Uz/5eVjfwMlb/dbQerTkHRdMCg4akjH0fBiz+verGHy
         wv2sfyBLigjFJDaSWkZBpydSq4faSuGHwLGF3mx5jyNqRQXf7yccGy5Eao3v+zC1redx
         OpSvqHABl1Oqobi50lIE6zE+wjTz7cHS0qM1+T+SN93MHtPi6e69mkKnyxluzy4b49/c
         TK+ZpGIde7gOgg8d9SeJOr2nAdDxUbo2WZNZNR1BeyARPWDfPNytBFOtFUW1TX5EJomm
         uG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=IhEaBINMOt21xyDLDwNy15/AjdvWwNFihN2hMjcNRmo=;
        b=c5SQY/AG3w17zaFoklH5A1bPomihbHoRuEVnke57d4lBcCOqgclKd98ePujyPsCDoJ
         CqBNXj1vnzbE66oGlxm/OObxQBb7jXCZjO9P2PjBYRoHoW7MnV8Mq3Voawl8fTQhGIWr
         NiWKGtFszJi5rbyl9owaadTDz75ziQtmv9uTJo1nTVpv++1iKxPj5UwKTKdu6HctKvCs
         MTzm7wfoz12X6d5P3O+1RnsskkGgAanG7gY2tpymXb+Dc1zjYc1+qUqJ6NFI+R+5+GAR
         L53Yz4uMtMXTmLVFXcsBd6cEF4wXpDg/s8tkW9HsT1YnnaFEvau7JMg4QwwEWRUDY51c
         JGDg==
X-Gm-Message-State: AElRT7Ey1407eAstbzXFfNDL4X4NzcL/QAV6PWEb0KrCbClZ6koNoJbn
        JzMx0X6HmnwfdZewgJRR9yM=
X-Google-Smtp-Source: AIpwx4/NUONaLpIoJLhpyEg6zoEn9u/Xo1t+yMUhnXsOF4zOJObz4Y4GKhrk790wO4dN2+tPoxTCPQ==
X-Received: by 10.80.136.107 with SMTP id c40mr2230934edc.231.1522401894268;
        Fri, 30 Mar 2018 02:24:54 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id h33sm5785279edh.1.2018.03.30.02.24.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Mar 2018 02:24:53 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2018, #05; Wed, 28)
References: <xmqqsh8k6khj.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <xmqqsh8k6khj.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 30 Mar 2018 11:24:52 +0200
Message-ID: <87lge9x6e3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 28 2018, Junio C. Hamano wrote:

> * ls/checkout-encoding (2018-03-16) 10 commits
>  - convert: add round trip check based on 'core.checkRoundtripEncoding'
>  - convert: add tracing for 'working-tree-encoding' attribute
>  - convert: check for detectable errors in UTF encodings
>  - convert: add 'working-tree-encoding' attribute
>  - utf8: add function to detect a missing UTF-16/32 BOM
>  - utf8: add function to detect prohibited UTF-16/32 BOM
>  - utf8: teach same_encoding() alternative UTF encoding names
>  - strbuf: add a case insensitive starts_with()
>  - strbuf: add xstrdup_toupper()
>  - strbuf: remove unnecessary NUL assignment in xstrdup_tolower()
>
>  The new "checkout-encoding" attribute can ask Git to convert the
>  contents to the specified encoding when checking out to the working
>  tree (and the other way around when checking in).

There's an issue in ca16fc3635 ("convert: check for detectable errors in
UTF encodings", 2018-03-15) flagged by Coverity:
https://public-inbox.org/git/CAGZ79kbAOcwaRzjuMtZ_HVsYvUr_7UAPbOcnrmPgsdE19q=PrQ@mail.gmail.com/

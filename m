Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CE1A1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 18:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbeHMVOQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 17:14:16 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42172 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbeHMVOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 17:14:16 -0400
Received: by mail-yw1-f67.google.com with SMTP id y203-v6so14278105ywd.9
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 11:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KUwB1D76/PAl2YBFDym3stnOvhFiG44egDvpo1Xqu9k=;
        b=fQGy94v/Cm8+geYeTrZq0BH2qiPIKGgrGaW7xyDpVk96nW3LVFg63oJ/nEr6WZ8QjX
         pkr/fdDC4VAorWHAlr21NGnPXRCEDXsDO9zVUYWk+w5GdSRHKyOr88hJIMjL7VFK45cC
         3Zzu9XOsYsMqPtiDy4lTFF4zC3z6tdHqf+vkQB7js/50mSInxyV6lrD0B0p5kxdFO8tu
         1frtGWzZYKcmI7y8qtBq7p6asPz4qW9xiAYBe1s47nUC9ndBZj/h3pf3NRU5lD4VPwjU
         BigOTyG/Pmv9pF2s54mGVfgml2HAAavheWf0zuFwaWsrL9F18kOJabxxk6YjKYLP3PU4
         TbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KUwB1D76/PAl2YBFDym3stnOvhFiG44egDvpo1Xqu9k=;
        b=RiVQwifimb88sJr7q7XZ7a1qrJFbUgmixBRtNmZUwxnTRCjVZWsBJoKVIxfbz+Bl2/
         dDoKhCDCgvOYh/qZJqQeCJEPg9GDCKShbDgY6pDYqW39lwF8orTf/71KMyau4tkeZVVM
         2MG9BpW376B5VclnJsGVvwNsIIYYcXZWSl4L8bY79V889VNPgOgvOF7mMrAA7gKuZpiO
         CTXH/dR1AYebX/7k+ac7K7aA+w5NE3vB1ek77f2HpleoSCbdNxzZjmqy3tw37CZDXmlZ
         Pzu0BlFN5gFY+1URAdzK2R3G9y9el924O/mq1YZc9DLA8wJgtAon76maqMxGJ3pThoK2
         a3JQ==
X-Gm-Message-State: AOUpUlEhcWsaLr3dZXimqy4LmHL/RyKRfO7i+lA4o7a+bQVMTzNeeS7S
        lanrp7LX21ohrQl1GOd5cbTXipdS7BIln+APkugwYQ==
X-Google-Smtp-Source: AA+uWPxWTD8tSEuEnKG5Ua5mTcgxs12aURRmKvjpPXtIu+OdsJaCFxkircLzXwDwPOTFgsikl1WN73aQkneQHk7dZCc=
X-Received: by 2002:a0d:c5c7:: with SMTP id h190-v6mr10773166ywd.421.1534185053733;
 Mon, 13 Aug 2018 11:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180810223441.30428-1-sbeller@google.com> <20180810223441.30428-3-sbeller@google.com>
 <nycvar.QRO.7.76.6.1808131404370.71@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1808131404370.71@tvgsbejvaqbjf.bet>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Aug 2018 11:30:42 -0700
Message-ID: <CAGZ79kbnSD5oiHLMy8b7o_SHFzquqttm1anak-4cnVzy10ns_w@mail.gmail.com>
Subject: Re: [PATCH 2/8] t3206: add color test for range-diff --dual-color
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 5:05 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Stefan,
>
> On Fri, 10 Aug 2018, Stefan Beller wrote:
>
> > +test_expect_success 'dual-coloring' '
> > +     sed -e "s|^:||" >expect <<-\EOF &&
> > +     :<YELLOW>1:  a4b3333 = 1:  f686024 s/5/A/<RESET>
> > +     :<RED>2:  f51d370 <RESET><YELLOW>!<RESET><GREEN> 2:  4ab067d<RESET><YELLOW> s/4/A/<RESET>
> > +     :    <REVERSE><CYAN>@@ -2,6 +2,8 @@<RESET>
>
> That's a neat trick to have an indented here-doc that contains
> indentation. I should use this myself.

Thanks to Junio for applying this trick!

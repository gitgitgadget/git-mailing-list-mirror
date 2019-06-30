Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_03_06,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A2841F461
	for <e@80x24.org>; Sat, 29 Jun 2019 19:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfF2TsL (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jun 2019 15:48:11 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:42757 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfF2TsL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jun 2019 15:48:11 -0400
Received: by mail-lj1-f174.google.com with SMTP id t28so9153686lje.9
        for <git@vger.kernel.org>; Sat, 29 Jun 2019 12:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QHzow82xVao1LAZa67ZUa/7zNjc5XgGmcyt6WxEjm0Q=;
        b=acMD0N5L+9GijVvNlf0QTclLvKUhjg3N/LB08dpkgNRbzPlCNQq717AN12auLCejWu
         Uwuhdr4f0QdINnFgp8cuKBLH0mtUDD9X/Ru5w1V+dQw810zm0DpJjFRfJu64M0jYVq9n
         KWhAeMBRdf1+u34FNUyCRRjVbdZP3jiGnbWZEm5s8Y0UzrBdqc9YWUwc5UZPxMejdDCH
         IjCpiBCgh0JmW0PTgJaVvFLp4Gro05QUQMZ2En1FbELKGUf08Wa/ph4AvZOme7tSB0pt
         uJnpFg6DwIzbN8CtxCkyIgc2Qe3raBxjpSRPTmNuF3jkttU5K/Hbk6GR8e+8KGSm2qdC
         nxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QHzow82xVao1LAZa67ZUa/7zNjc5XgGmcyt6WxEjm0Q=;
        b=eTAbkbLSfKx72MpVDu5nJMvALF9I/YfX9wINcjfsvXXUSFTqnfto4avk115pCoAdOc
         VL3h6Ji+2lnFZmNgHdOTE69VBIQ1Ok2uvzE8P7M4ApNjPkZxtWD7tW3CCwXDM0yoBDsm
         ma908IIKIMOObxstjjL94zwH636eljpH7iO6NvjXwj06BLQu1ZCt2WS4ZXT3NYehKJY4
         5zGScqCqd76/Le6QpJwlK7UGGhXp/Nb0uyo8L+S0KjeKaALUlPi/fznYI9a2793X4aYq
         ftvjgHYbbFzrCAlYMLGBoTA+vub9QIYwqxQ0F+hGCEgcHhwxqyXGbpls7ha0Tt+YuG1z
         REMg==
X-Gm-Message-State: APjAAAV7ANniE2FeFhI7KRtIg8Al2QLyNwJi+ZEpJC3y76DiBintpQZ8
        1kZQQPa67xGorLLryXenn804yHqitfMXnyVArGufudaV
X-Google-Smtp-Source: APXvYqxbkAvi3aMX3Afqlr2te3rKTyZaR9tLDmstxQLihOiEH+QRSm113pmWM3COX9s4+DtZBB3sdbXiYkpoZ5REIe0=
X-Received: by 2002:a2e:5c6:: with SMTP id 189mr9841063ljf.22.1561837688796;
 Sat, 29 Jun 2019 12:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190511001421.25283-1-rohit.ashiwal265@gmail.com> <20190622205253.13360-1-rohit.ashiwal265@gmail.com>
In-Reply-To: <20190622205253.13360-1-rohit.ashiwal265@gmail.com>
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Date:   Sun, 30 Jun 2019 06:47:21 +0530
Message-ID: <CAL7ArXoVTRssKeK3pw39MTR0-8AqHDZLQHXHw91mYQZaRtSV3w@mail.gmail.com>
Subject: [GSoC] Blogging with Rohit
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Everyone!

Here[1] is an update of my past week.

Thanks
Rohit

[1]: https://rashiwal.me/2019/first-evaluation/

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1566211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 20:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbeL0UeN convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 27 Dec 2018 15:34:13 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45382 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729867AbeL0UeM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 15:34:12 -0500
Received: by mail-qk1-f196.google.com with SMTP id y78so11495010qka.12
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 12:34:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4OdBtbrHeOnwGZKZO0i2y3NFjH68VwoKNIj2CJp+URI=;
        b=jqjEW+j6W8KEcBGND0xcgtfYkWjLr4Ng0Usyv3nczVyBL+cmhUi23Tn3gHp2gOIfkI
         C89rnivcTwBruWvx1h6RxBaKXirG0n0eyjRBGiHRIsODmx11U8VeKfpUymGUlkVDyQez
         Am3wGWlL3HSWovPkjgyNcrEvjWsh44Pqm3KYp+wQzcEd3n7Spd7XyUrg01LIhme54Lfs
         oFLQZP3LN8XiYyGhuoyJno506uk4pw/FqCEhA0dpnOP9jx6mc4FiQesEvKvkxi0Fdxzk
         /4UIdUQlxkKFlSiMFoRlzmmfa1w7idnnGzGHLB4PTq4OVw/SDNRYPFJpuZYwQoSJdzU9
         v19g==
X-Gm-Message-State: AJcUukcIhIa+NDoFF4agZaqASDUIGr54d5owDI6kZFOARrljtqc2puvO
        qp6LnEs4T7mtkJbtWaENs0yC7eSu7U79VP/T3HGzSdu/
X-Google-Smtp-Source: ALg8bN6tlwKonxo0uirXv587NK/41eMjSyiiNCuch4kNlpJEevTtiwOpjaQHdGNXIlX/WiZLo7Xy1D4d/SA/xt6D4Zc=
X-Received: by 2002:a37:5e42:: with SMTP id s63mr21817091qkb.220.1545942851809;
 Thu, 27 Dec 2018 12:34:11 -0800 (PST)
MIME-Version: 1.0
References: <20181227162536.15895-1-pclouds@gmail.com> <20181227162536.15895-15-pclouds@gmail.com>
In-Reply-To: <20181227162536.15895-15-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 27 Dec 2018 15:34:00 -0500
Message-ID: <CAPig+cR5xo75B3sjHWjh+2Z5Wn+CTt-S2mcd0BrdfyVV=yv0Bg@mail.gmail.com>
Subject: Re: [PATCH 74/75] diff --no-index: use parse_options() instead of diff_opt_parse()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 27, 2018 at 11:26 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> While at there, move exit() back to the caller. It's easier to see the
> flow that way then burying it in diff-no-index.c

s/then/than/

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

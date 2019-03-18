Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5BA420248
	for <e@80x24.org>; Mon, 18 Mar 2019 20:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfCRUcT (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 16:32:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36147 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfCRUcT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 16:32:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so5827066wml.1
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 13:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GsUOV2+KRRyw4v5M8SvWGKjbQR7SjQj9GlZHjmlAjUc=;
        b=t1c1cclPptse5UX9yJEeFYkK/O3jvJMjkt29S/bPtzqU+x5TlVkpyIR57uYQk0m8wU
         NAja/5wulcJoMcvugi1P5gxlvTD26v8gil2JjgY+7CBQ0JE80G+nMAghafv72CrTv4Pu
         Eh/m1MXXXY8Pcz1PIOb7OVAcmaC+1gTRv34lqsd12OILdwUalAE5tGkh3QrKP5h66WPz
         aryYtQBMt8vLEq+ptVWRFIqyk/BLG+3puBPOp09AFgbxAX9Jc0I7MXQvvlKCqLFGC9+0
         CT6iX3PLF/76/xZsuYmupPmeztiRnhsZYYAYD7iTRK39nO1/WFcVCGR9gSSjvqBa+cye
         Chtg==
X-Gm-Message-State: APjAAAVZqi+jKKycS+uze1vcR4gEpIajDAZ8KFfCDBRYZgSk+pL2Asdk
        jQ4gKV0QHRd2yGKyzT01YpdOIb6ZxOzANk8ik/A=
X-Google-Smtp-Source: APXvYqyyf06SGzbLNcUiRcUd2Cx69JDBxd17YLRljH7STo17YTGunWspFyDLtJzcNeL67v4Z+T9rOjBewWYLm1g4FGw=
X-Received: by 2002:a1c:730d:: with SMTP id d13mr561836wmb.37.1552941137852;
 Mon, 18 Mar 2019 13:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1552275703.git.liu.denton@gmail.com> <cover.1552817044.git.liu.denton@gmail.com>
 <4edca9db0b2a32621a7622b5b709db23b2512d1e.1552817044.git.liu.denton@gmail.com>
 <CAPig+cRmz2C7mAzc7Z=ZStAxd3qDSmbC4sbwyLGKqvkf2yzVPA@mail.gmail.com> <20190318203007.GA14875@dev-l>
In-Reply-To: <20190318203007.GA14875@dev-l>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 18 Mar 2019 16:32:06 -0400
Message-ID: <CAPig+cSAVLh7eahoqitC0tdYdDa6j4=iBZMiNw3ab-ysR=i_Cw@mail.gmail.com>
Subject: Re: [PATCH v8 10/11] sequencer.c: define describe_cleanup_mode
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 18, 2019 at 4:30 PM Denton Liu <liu.denton@gmail.com> wrote:
> On Mon, Mar 18, 2019 at 04:04:22PM -0400, Eric Sunshine wrote:
> > These two Reviewed-by: lines should be dropped for a couple reasons.
> >
> I was using it to give credit for changes that I incorporated in
> response to a review. In addition, it was helpful for bookkeeping who
> suggested what where.
>
> Would a Helped-by tag be more appropriate in this situation?

Using Helped-by: would be quite appropriate.

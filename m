Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E7E41F516
	for <e@80x24.org>; Sat, 30 Jun 2018 09:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754120AbeF3JM1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 05:12:27 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34751 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752494AbeF3JMY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 05:12:24 -0400
Received: by mail-oi0-f65.google.com with SMTP id c2-v6so10584140oic.1
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 02:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TxCx5q7fDFnNbgEggvJ2Fwu7K4ehvHKZIad7xetF/WQ=;
        b=Ms+e9YeYnx4R5b0UJ1Kq5tEu0E39hnhQZJXy1P+IzjTq92NwtDrE0O1jkzH0guDDiI
         HEOgiOxqP4rwe9PJWHSxGQlztMqWzzqvf7LNirYbwgzq07YvAhgM03PX7xoGCdFuY0hU
         fol+p5U2KhGe/3kmzOVHx8I5Hj9OYOTB0KO1peBX2EcPU7TCvb44IiqP0jeMpPoGCeDU
         k+X2VUKXbAOKiZ2jJvcvZOrjRc8WegUIssy12qOc+U6PXafLc3JPCsG79qg9Sau23fP/
         2svg3f13XAlH0Uqq2BvakOBr0/+3buY9sa1A9k2ccOVOHrYet2iWW6MaZyzX83GERRdM
         iSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TxCx5q7fDFnNbgEggvJ2Fwu7K4ehvHKZIad7xetF/WQ=;
        b=H6pqUbwOWlthmpEwCnSCfeLuoAOzeL30Jlf4+kHTggmtXmpvZ9W9IP8v9KNvaOy3Bs
         RKBSb3YSpdGCpVM2Qj+UrTHV22oINRNQEtRSXOaNLWpc+uXn5paVlc4mNhUzUqDiiaro
         jx3LqSnTawsWT6GSsqbbGzpPzyU9jEQ8PZHyIcsFLP/nwFRtQY0R0j0maj0Cdf8tKyiK
         vsgG7+2fXApaMA2AyR33TBGAUywqBE3OGEzs8tUxZsWziQ5tpz8BYEzlxd3HPbuOCa9N
         /jonW2Nv/n+xggH+poOEv0uGfej40iHvwFqZeVOgkU0+mPUoWnBH610hArAxG/yDND8y
         BLHQ==
X-Gm-Message-State: APt69E2NTEXEHxnknHDlxik7BGCzPO6MKCX5iIpxTE4E+TREFZNPHjjb
        e9X8SX4pS2i1ghTIbWS6wvElipwWCwlu30ZZeU0=
X-Google-Smtp-Source: AAOMgpf2A+oLVtGqNj4aKzJbBUzWMZi8VOwbvPh/JHeoyfJloYTLOiZHwog/xdn933bsD1FOLqtViJGj+I2SZaqvnec=
X-Received: by 2002:aca:f516:: with SMTP id t22-v6mr10690552oih.56.1530349943893;
 Sat, 30 Jun 2018 02:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180621142742.28575-1-hertzog@debian.org> <20180621142742.28575-3-hertzog@debian.org>
 <CACsJy8DcXo3HURwZXbvGYjrJpfku+RXESP=ErLzYj3NhNabRTQ@mail.gmail.com>
 <20180621152145.GA29912@home.ouaza.com> <20180625152922.GB27849@home.ouaza.com>
In-Reply-To: <20180625152922.GB27849@home.ouaza.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 30 Jun 2018 11:11:57 +0200
Message-ID: <CACsJy8BNVBQFQPKo1SZifS4asi4+_hm_0j4MxQk02aPoQqsisA@mail.gmail.com>
Subject: Re: [PATCH 2/2] i18n: bisect: mark two supplementary strings for translation
To:     Raphael Hertzog <hertzog@debian.org>
Cc:     Git Mailing List <git@vger.kernel.org>, jn.avila@free.fr
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 25, 2018 at 5:29 PM Raphael Hertzog <hertzog@debian.org> wrote:
>
> Hi,
>
> On Thu, 21 Jun 2018, Raphael Hertzog wrote:
> > On Thu, 21 Jun 2018, Duy Nguyen wrote:
> > > Nice. There's another string in bisect_common() that should also be
> > > translated: "revision walk setup failed". Maybe you can mark it too?
> >
> > Sure. A new version of the second patch is attached.
>
> I haven't had any other feedback. Is there anything else that I should do
> to get my changes merged?

If Junio has not picked up the patches and did not object either,
there's a chance he missed this, so just resend and include him
-- 
Duy

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 475A31F463
	for <e@80x24.org>; Sat, 21 Sep 2019 03:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbfIUCtE (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 22:49:04 -0400
Received: from forward500p.mail.yandex.net ([77.88.28.110]:58730 "EHLO
        forward500p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730800AbfIUCtE (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 20 Sep 2019 22:49:04 -0400
Received: from mxback2q.mail.yandex.net (mxback2q.mail.yandex.net [IPv6:2a02:6b8:c0e:40:0:640:9c8c:4946])
        by forward500p.mail.yandex.net (Yandex) with ESMTP id 1639B9401FF;
        Sat, 21 Sep 2019 05:49:01 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback2q.mail.yandex.net (nwsmtp/Yandex) with ESMTP id Hzpy9bt3B8-n0s0R3kW;
        Sat, 21 Sep 2019 05:49:00 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1569034140;
        bh=ZberBRGDjL7o3nUISrHUAcxLy8yN8DRVfmwKQFYqS4c=;
        h=Message-Id:Cc:Subject:Date:References:To:From;
        b=EIyy/Cfe61Hzf0ywB7kRtf5u63GfkxHE1F7CY80ND9K3iGNsSelvqGB26JReFW/K3
         9cmLspcDnBxNFvRxNko0VzlB1kbtTkVBMjEb2xDCJPwOm6Sr0j+2nfV+CO+5dmqUEu
         XiAlEHaw+eamkpN8/oCl5GbPQNYgvY12LirzBScc=
Authentication-Results: mxback2q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla1-b1f71bfb4f06.qloud-c.yandex.net with HTTP;
        Sat, 21 Sep 2019 05:49:00 +0300
From:   Andrey <ahippo@yandex.ru>
Envelope-From: ahippo@yandex.com
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <b8cd556ebb4715d2111422d4bacf4075eedea8f8.1566879764.git.ahippo@yandex.com>
Subject: Re: [PATCH 1/1] .mailmap: update email address of Andrey Mazo
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Fri, 20 Sep 2019 22:49:00 -0400
Message-Id: <86791569034140@vla1-b1f71bfb4f06.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,

27.08.2019, 00:25, "Andrey Mazo" <ahippo@yandex.ru>:
> From: Andrey Mazo <ahippo@yandex.com>
>
> I don't have access to my old work email since 20 Apr 2019.
> Replace with my personal email address.
>
> Signed-off-by: Andrey Mazo <ahippo@yandex.com>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
>

Do I need any acks on this patch?

> diff --git a/.mailmap b/.mailmap
> index 9a5ff04753..14fa041043 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -16,10 +16,11 @@ Alexander Gavrilov <angavrilov@gmail.com>
>  Alexander Kuleshov <kuleshovmail@gmail.com>
>  Alexey Shumkin <alex.crezoff@gmail.com> <zapped@mail.ru>
>  Alexey Shumkin <alex.crezoff@gmail.com> <Alex.Crezoff@gmail.com>
>  Anders Kaseorg <andersk@MIT.EDU> <andersk@ksplice.com>
>  Anders Kaseorg <andersk@MIT.EDU> <andersk@mit.edu>
> +Andrey Mazo <ahippo@yandex.com> Mazo, Andrey <amazo@checkvideo.com>
>  Aneesh Kumar K.V <aneesh.kumar@gmail.com>
>  Amos Waterland <apw@debian.org> <apw@rossby.metr.ou.edu>
>  Amos Waterland <apw@debian.org> <apw@us.ibm.com>
>  Ben Peart <benpeart@microsoft.com> <Ben.Peart@microsoft.com>
>  Ben Peart <benpeart@microsoft.com> <peartben@gmail.com>
>
> base-commit: 745f6812895b31c02b29bdfe4ae8e5498f776c26
> --
> 2.21.0

-- 
Andrey.



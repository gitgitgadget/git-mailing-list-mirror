Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CA601FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 23:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933757AbdBPXdu (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 18:33:50 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34219 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933745AbdBPXdt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 18:33:49 -0500
Received: by mail-pf0-f193.google.com with SMTP id o64so2610888pfb.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 15:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/7xIUoQcPfhKe/jiczjcyol5XaaYD3z8mTDMYMsvQsQ=;
        b=mizywbWxhDW9Lat/+o1FNXT9RH4WWqIZ0RVbhG7HmTp9DhK4SgNvoFe2QPNsvMiUvE
         1qszGEAHyTOcWzOwf2lJCtyRzu59u7IEqeF5syYDofJ4eqNl/9G17zJ7LTkHxBofjtqo
         CZyimwnQs/tyPVo7EQKX9hJ9MC0rfCMut95+U/jtldkylrrxQjD7p7G9nibHnOKroEbq
         MlVZnCgL4ITU4epPl49A5EkVuSYnBErKR8/blcCjsJUkk13yFtNLBEnr40EIqyhLKWta
         7lcDpiutx9WLI9vLY+wWk2hHr2M6P5rCZaJqdoEP2WL/QmkyMcKX0pxpBOuHxlV3Iafw
         RGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/7xIUoQcPfhKe/jiczjcyol5XaaYD3z8mTDMYMsvQsQ=;
        b=dTXkaxCPKMZuBtc2x5Sy+2FTw8RzBF1kYjqovVtmOlO/y5/yodoNLmAx/YMUqqwOjB
         5lCMeUH5qKm4xAfqimi51fUdmWx0aAePYtuxjiEyZsxDZJYjBjdhWoukWGtMPLnTVDJa
         I0fzYeEy1A3xRP3FamyLz9pJmvxyUlIwVNLNxuBoWcsBhfhoq5o6v01neGOZoTAEhvFy
         a10WX5wjCIhhl0eSNwaXgLiy+W9QiJTWXnnJX27SK987mWs+tvXKbqfPJgck9WFlT6h9
         k+17P2ewa22b8GV+J/WC7ILz7wrXp7BQbxANnPpN+xtAGPKykjwkCK+5ABok3zAXlHZc
         OADw==
X-Gm-Message-State: AMke39k79Bl+HmNNss5lMvuGTR/G1TZDPby2osX+BlW8ZXfv71vWsUe6qFF5JSor1W3Qeg==
X-Received: by 10.84.169.67 with SMTP id g61mr6842787plb.137.1487288028964;
        Thu, 16 Feb 2017 15:33:48 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:9476:4c5c:6ee4:ba3])
        by smtp.gmail.com with ESMTPSA id n123sm15622278pga.9.2017.02.16.15.33.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Feb 2017 15:33:48 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com
Subject: Re: [PATCH V2 0/2] Fix l10n
References: <20170216170713.10065-1-franchesko.salias.hudro.pedros@gmail.com>
Date:   Thu, 16 Feb 2017 15:33:47 -0800
In-Reply-To: <20170216170713.10065-1-franchesko.salias.hudro.pedros@gmail.com>
        (Maxim Moseychuk's message of "Thu, 16 Feb 2017 20:07:11 +0300")
Message-ID: <xmqq8tp5vhgk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com> writes:

> In some places static size buffers can't store formatted string.
> If it be happen then git die.
>
> Jonathan Tan: Thanks a lot for your help.
>
> Maxim Moseychuk (2):
>   bisect_next_all: convert xsnprintf to xstrfmt
>   stop_progress_msg: convert xsnprintf to xstrfmt
>
>  bisect.c   | 9 +++++----
>  progress.c | 9 +++------
>  2 files changed, 8 insertions(+), 10 deletions(-)
>
> --
> 2.11.1

Thanks.  Queued with minor log message fixes and pushed out.

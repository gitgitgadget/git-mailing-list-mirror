Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CDEC433FE
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 06:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3DE560560
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 06:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbhI0GhG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 02:37:06 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:15944 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232821AbhI0GhG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 02:37:06 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4HHtDY3DbGz5tlK;
        Mon, 27 Sep 2021 08:35:25 +0200 (CEST)
Subject: Re: [PATCH 2/5] *.[ch] *_INIT macros: use { 0 } for a "zero out"
 idiom
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
References: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
 <patch-2.5-d612e7df7a5-20210927T003330Z-avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <68c9c6da-d215-a39b-64f5-8b8930ce5a09@kdbg.org>
Date:   Mon, 27 Sep 2021 08:35:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <patch-2.5-d612e7df7a5-20210927T003330Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.09.21 um 02:39 schrieb Ævar Arnfjörð Bjarmason:
> diff --git a/entry.h b/entry.h
> index 7c889e58fd7..04bc8bb59f0 100644
> --- a/entry.h
> +++ b/entry.h
> @@ -16,7 +16,7 @@ struct checkout {
>  		 clone:1,
>  		 refresh_cache:1;
>  };
> -#define CHECKOUT_INIT { NULL, "" }
> +#define CHECKOUT_INIT { 0 }

This is not an equivalence transformation and does not belong in this patch.

-- Hannes

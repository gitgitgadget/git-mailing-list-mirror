Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0B82201A4
	for <e@80x24.org>; Fri, 12 May 2017 05:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932698AbdELFUS (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 01:20:18 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:39355 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750720AbdELFUR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 01:20:17 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wPJFq47hxz5tlG;
        Fri, 12 May 2017 07:20:10 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id DCF544307;
        Fri, 12 May 2017 07:20:08 +0200 (CEST)
Subject: Re: [PATCH] C style: use standard style for "TRANSLATORS" comments
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Jiang Xin <worldhello.net@gmail.com>
References: <20170511204334.GM83655@google.com>
 <20170511212012.6782-1-avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <afa831d6-efb2-7e20-64a8-9ef338a28016@kdbg.org>
Date:   Fri, 12 May 2017 07:20:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20170511212012.6782-1-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.05.2017 um 23:20 schrieb Ævar Arnfjörð Bjarmason:
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 7b891471c4..fb856e53b6 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -340,8 +340,10 @@ static struct notes_tree *init_notes_check(const char *subcommand,
>   
>   	ref = (flags & NOTES_INIT_WRITABLE) ? t->update_ref : t->ref;
>   	if (!starts_with(ref, "refs/notes/"))
> -		/* TRANSLATORS: the first %s will be replaced by a
> -		   git notes command: 'add', 'merge', 'remove', etc.*/
> +		/*
> +		 * TRANSLATORS: the first %s will be replaced by a git
> +		 * notes command: 'add', 'merge', 'remove', etc.
> +		 */

Rewrapping lines is generally frowned upon because it makes it difficult 
to see whether something was changed. Keeping the line wrapping will 
also reduce the noise in the next .pot commit, I think (not sure if that 
is a worthwhile goal, though).

<rant>
I hate it when J. Random Developer insists in a particular line length 
and when they have their editor do the wrapping, logical entities are 
suddenly split into two lines: it is "git notes", one logical thing; not 
two words "git" "notes" that happen to occur in sequence.
</rant>

-- Hannes

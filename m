Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00872C33CB2
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 12:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CE120702
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 12:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgA2Md2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 07:33:28 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:36625 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbgA2Md2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 07:33:28 -0500
Received: from [192.168.3.145] (unknown [146.247.95.34])
        (Authenticated sender: jn.avila)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 51BDE2003EF
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 13:33:25 +0100 (CET)
Subject: Re: [PATCH 1/3] doc: reword -B option of diff into something sensible
To:     git@vger.kernel.org
References: <20191212204655.10425-1-jn.avila@free.fr>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
Message-ID: <24a43810-0ad7-9cd9-808b-5c7b68269a34@free.fr>
Date:   Wed, 29 Jan 2020 13:33:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191212204655.10425-1-jn.avila@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/12/2019 at 21:46, Jean-Noël Avila wrote:
> The sentence seemed to miss a verb.
> 
> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> ---
>  Documentation/diff-options.txt | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 09faee3b44..350d0a2fb0 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -452,14 +452,14 @@ endif::git-format-patch[]
>  	create. This serves two purposes:
>  +
>  It affects the way a change that amounts to a total rewrite of a file
> -not as a series of deletion and insertion mixed together with a very
> -few lines that happen to match textually as the context, but as a
> -single deletion of everything old followed by a single insertion of
> -everything new, and the number `m` controls this aspect of the -B
> -option (defaults to 60%). `-B/70%` specifies that less than 30% of the
> -original should remain in the result for Git to consider it a total
> -rewrite (i.e. otherwise the resulting patch will be a series of
> -deletion and insertion mixed together with context lines).
> +does not appear as a series of deletion and insertion mixed together
> +with a very few lines that happen to match textually as the context,
> +but as a single deletion of everything old followed by a single
> +insertion of everything new, and the number `m` controls this aspect
> +of the -B option (defaults to 60%). `-B/70%` specifies that less than
> +30% of the original should remain in the result for Git to consider it
> +a total rewrite (i.e. otherwise the resulting patch will be a series
> +of deletion and insertion mixed together with context lines).
>  +
>  When used with -M, a totally-rewritten file is also considered as the
>  source of a rename (usually -M only considers a file that disappeared
> 

Hello,

It seems this patch was never merged, whereas the two following ones are
indeed merged. Was it refused because a complete rewrite was expected?

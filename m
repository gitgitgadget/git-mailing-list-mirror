Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8479A2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 21:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S3000951AbcHEV02 (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 17:26:28 -0400
Received: from siwi.pair.com ([209.68.5.199]:61126 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S3001028AbcHEV0X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 17:26:23 -0400
Received: from [10.160.15.137] (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 0EA9A845CB;
	Fri,  5 Aug 2016 17:26:22 -0400 (EDT)
Subject: Re: [PATCH] wt-status.c: mark a file-local symbol as static
To:	Ramsay Jones <ramsay@ramsayjones.plus.com>, jeffhost@microsoft.com
References: <ff4862e4-da97-deef-b2dc-5201df184484@ramsayjones.plus.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
From:	Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <57A50400.9020101@jeffhostetler.com>
Date:	Fri, 5 Aug 2016 17:24:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <ff4862e4-da97-deef-b2dc-5201df184484@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 08/05/2016 04:55 PM, Ramsay Jones wrote:
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Jeff,
>
> If you need to re-roll your 'jh/status-v2-porcelain' branch, could
> you please squash this into the relevant patch (37f7104f, "status:
> print per-file porcelain v2 status data", 02-08-2016).
>
> Thanks!
>
> ATB,
> Ramsay Jones
>
>   wt-status.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index 3396bf5..a80400e 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -2152,7 +2152,7 @@ static void wt_porcelain_v2_print_other(
>    * [<v2_ignored_items>]*
>    *
>    */
> -void wt_porcelain_v2_print(struct wt_status *s)
> +static void wt_porcelain_v2_print(struct wt_status *s)
>   {
>   	struct wt_status_change_data *d;
>   	struct string_list_item *it;
>

got it.  thanks!

Jeff

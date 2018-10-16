Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD47E1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 15:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbeJPXYX (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 19:24:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:42342 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727075AbeJPXYX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 19:24:23 -0400
Received: (qmail 7480 invoked by uid 109); 16 Oct 2018 15:33:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 16 Oct 2018 15:33:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11073 invoked by uid 111); 16 Oct 2018 15:32:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 16 Oct 2018 11:32:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Oct 2018 11:33:22 -0400
Date:   Tue, 16 Oct 2018 11:33:22 -0400
From:   Jeff King <peff@peff.net>
To:     Tao Qingyun <taoqy@ls-a.me>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] branch: trivial style fix
Message-ID: <20181016153322.GC29432@sigill.intra.peff.net>
References: <20181005095213.12509-1-taoqy@ls-a.me>
 <20181016141919.2268-1-taoqy@ls-a.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181016141919.2268-1-taoqy@ls-a.me>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 16, 2018 at 10:19:20PM +0800, Tao Qingyun wrote:

> Signed-off-by: Tao Qingyun <taoqy@ls-a.me>
> ---
>  builtin/branch.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/builtin/branch.c b/builtin/branch.c
> index c396c41533..0aa3dac27b 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -716,8 +716,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  		print_columns(&output, colopts, NULL);
>  		string_list_clear(&output, 0);
>  		return 0;
> -	}
> -	else if (edit_description) {
> +	} else if (edit_description) {
>  		const char *branch_name;
>  		struct strbuf branch_ref = STRBUF_INIT;

Yep, this looks reasonable. Normally I would complain about an empty
commit message, but there is really not much else to say. ;)

-Peff

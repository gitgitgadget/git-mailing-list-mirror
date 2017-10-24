Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C6981FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 20:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751618AbdJXUXl (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 16:23:41 -0400
Received: from mout.web.de ([212.227.15.4]:56054 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751573AbdJXUXk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 16:23:40 -0400
Received: from [192.168.178.36] ([91.20.60.28]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MN87U-1e9Jj81wsa-006bjk; Tue, 24
 Oct 2017 22:23:38 +0200
Subject: Re: [PATCH 2/4] xdiff-interface: export comparing and hashing strings
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <20171024185917.20515-1-sbeller@google.com>
 <20171024185917.20515-3-sbeller@google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <9f5c5cd5-9491-3163-60d4-ad36d75981ce@web.de>
Date:   Tue, 24 Oct 2017 22:23:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171024185917.20515-3-sbeller@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:51HlirXKeQ1kRbNTGRAh+JIirhCITtnqVeoNvbxzBKmBia3kMgO
 4KWMFFrhRkfoGZuTSuJiXGSQ4cX5x0ufiOEYgJ//bWPiopVXPUIqZtk1PeFYfk5buNcib5i
 j7gUimLTNNlRsxjzrYRhq4Dr3oL0VoX/zbtTQ2D9E+nkpKBijL2FjWmlyypTw0Dy2l5M82p
 JvzRgw37XJGWhCUYHpGxw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ncG1sYmzZnM=:7Kx12IuLFEbSl/ZwUXVOq4
 3F+SCmVC+Cr3Wwu7vuf7v00aNvnz/Capgbee7pPzQYD2woB6J1LKDzYFbBkPA3Q/UKlijlYh0
 k4laqE+Rp3B2bKkDkXdvm9rKRL7G1vWP2LpahAodqLGfAD+Yb/E4PalTaLsbjVWttwuZ9TrKf
 Rn8pJ3OgK4VW5hJCPKY/d91lwKtNOn3vVgo8OQMx3oQBfWyzPOf4vn4FISec1noh98RfHH14m
 D9kJIy8ZdQEO27unrW2866giesNvznGFspVKhRQckC9w/nXsrKb+JroRVxMSIRFbjER3qU3JL
 Ga1U0qy3Gmgaj9VyXIwNC1CvhJMM/14h6a+tNcD8KnA71EzXGHnjqr0CMiyV4MXSKfsFi12ge
 XdbuVsiWagbAq6nEEjayrQsvLWNxMDiqYjiy0jhyq5cX9ca1s/ia+LdXGptS7Tc3RqwAGrzha
 f/8F4PvEIfclzY4wbpk4R4g0Ccyw0gBgA1w4kIvH1dga+GWat5LNzjmCF5MzEw46jVtA1YuRF
 VCIIEOHFz76/N2ZHe3Jmyf+QSVpZa/W0pFDSnRsm5mc0yb5t5JRoP5lp8mMCKlZo70Vu3Yxg3
 ddjpm4dMYgSRUoCTCXDuzZVDKggZ/0uRf4kpJyW5fU1t93b0+dECFSbDwgFpvWwj7ojpaBsng
 8tt2BWSty0VIdO1WdwCPkjD55Rn9dEb6zTKzZ+AvSq7O8d2aVBj+EIwt+4JPyKIvlTaiTAOR2
 DgKdzFTMDVcdr8Vxxgz8ya2wsF1vmSx1agXRuVTi7L1Bg4xj0L+MEx+7htZNpxREB6hGuJrnk
 vu+owvx8NriGDBvUr1CNK02TnCAhYqZiX2AMALU2pouwp39gjA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.10.2017 um 20:59 schrieb Stefan Beller:
> This will turn out to be useful in a later patch
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>   xdiff-interface.c | 11 +++++++++++
>   xdiff-interface.h |  5 +++++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/xdiff-interface.c b/xdiff-interface.c
> index 018e033089..fd002ebbc2 100644
> --- a/xdiff-interface.c
> +++ b/xdiff-interface.c
> @@ -5,6 +5,7 @@
>   #include "xdiff/xdiffi.h"
>   #include "xdiff/xemit.h"
>   #include "xdiff/xmacros.h"
> +#include "xdiff/xutils.h"
>   
>   struct xdiff_emit_state {
>   	xdiff_emit_consume_fn consume;
> @@ -296,6 +297,16 @@ void xdiff_clear_find_func(xdemitconf_t *xecfg)
>   	}
>   }
>   
> +unsigned long xdiff_hash_string(const char *s, size_t len, long flags)
> +{
> +	return xdl_hash_record(&s, s + len, flags);
> +}
> +
> +int xdiff_compare_lines(const char *l1, long s1, const char *l2, long s2, long flags)
> +{
> +	return xdl_recmatch(l1, s1, l2, s2, flags);
> +}

xdl_recmatch() is already exported; why not use it without this
wrapper?

> +
>   int git_xmerge_style = -1;
>   
>   int git_xmerge_config(const char *var, const char *value, void *cb)
> diff --git a/xdiff-interface.h b/xdiff-interface.h
> index 6f6ba9095d..d3cb9285c5 100644
> --- a/xdiff-interface.h
> +++ b/xdiff-interface.h
> @@ -29,4 +29,9 @@ extern void xdiff_clear_find_func(xdemitconf_t *xecfg);
>   extern int git_xmerge_config(const char *var, const char *value, void *cb);
>   extern int git_xmerge_style;
>   
> +extern int xdiff_compare_lines(const char *l1, long s1,
> +			       const char *l2, long s2, long flags);
> +
> +extern unsigned long xdiff_hash_string(const char *s, size_t len, long flags);

Documenting the meaning of their parameters would be nice.  s and len
are easy enough to guess, but which flags can be used?  At least a
pointer to their definition in xdiff/xdiff.h would be helpful.  And
renaming l1, s1, l2, s2 to a, alen, b, blen or line1, len1, line2, len2
or similar would leave me less confused, but perhaps that's just me.

> +
>   #endif
> 

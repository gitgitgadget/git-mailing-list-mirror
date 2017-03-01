Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67E082023D
	for <e@80x24.org>; Thu,  2 Mar 2017 00:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753677AbdCBAID (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 19:08:03 -0500
Received: from mout.web.de ([212.227.15.4]:59591 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753375AbdCBAHz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 19:07:55 -0500
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LdrkJ-1c0ebx1AQt-00j0L9; Wed, 01
 Mar 2017 16:41:38 +0100
Subject: Re: [PATCH 2/2] pretty: use fmt_output_email_subject()
To:     Jeff King <peff@peff.net>, Adrian Dudau <Adrian.Dudau@enea.com>
References: <1488297556.2955.11.camel@enea.com>
 <20170228181719.t67abnnnsdcx2xfd@sigill.intra.peff.net>
 <58e05599-5dc4-9881-d8c0-89ad1f2e3838@web.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <373c7cca-3fd8-bf25-f45b-16249f160ee5@web.de>
Date:   Wed, 1 Mar 2017 16:41:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <58e05599-5dc4-9881-d8c0-89ad1f2e3838@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:4+LheJCzd0mxd4wcJz+jSP9j2pKGLVwLuG3Ci+Gw4b9lxo9Oj0v
 3qlwNEJLoa3Ti8yY1RAmd2bBDf/Khz/VXW0KxnTCQ38+Mjn4lC1idT8vTOtGYhTxNGC68n8
 NkCsQ9ASJxraUu29MM8GFGKHplC1Bc/XGkeN2lHA99cP/UKSG8bust1eJDrlyBAUa0S5HuE
 by/K3NXk74JCvi/4tVHxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kLvdsIw4ui0=:RMLnGs/07ZbgjbQLGmya5f
 Qn+ya92HbWunu1p5m1B9pQ8vhYQbW9e7eZkMlplx7cMgnhU6U3eIHB5Rh2hPROxZiooaOY+nv
 4pSVonbXM7JBcoGwz+R41IAadZJXRClqMBNX54DWxehyw/3tWTrp1gB3SX5SDvD4U0s6ZWADM
 QuOXOOoxF6JQjtLETJIzadj8BW8AAytaBlxkYtZzXvYh8EwCmrI6U49krPKCBALAJujncGWgt
 Kj0DKck2byY+NPRMpX9JydrNSFiGr7idw+m4hbJdz1GgSUejw/c8tnGhN5wsKoPhkRS5BPTAf
 wkzG9aJxLR+ITNOTugwnE/RzWwFpHGsAhQ29hn//hq6QkfU82dq99m2+LCQnTfXK31i2BANx+
 J6RdsRs1A9jgOXoAohs2msoxb4ncX7WFhGzKMANclLnb4S114GHAGfXDixLHAh53DnrRRNyJL
 56xX5gmYgLPgLJBRTXEd3Isfug/Aq08y09uQHHTnv82a3YYnH48nFNFgB3jYG44rP7gENWNxn
 4eS13YF8JEIB75q3OasXgI0D9KQTLDWwa4JSmevS9hlvEG4p/9yDTueRw+jn3Q5xw2Wm3Wid/
 ryeHmbnY+ri73QOpeNOZwp+Umd7kw+7bTZ5O30mXaOlWmaXehetUNZYW7OW7rUjX0ztZO/lr7
 VA1leaxqoAGj65Kiozptajz3VCr+d6ggIIOdvH1T/ndgmqvHBNLGoC0p8prpjfMvoNomKNWzO
 MVH2pLKE2f5fVj9cu1UG3dWwin6c4q0/VGSFe/HpdJUO7PHmqOr+B86NeOpyMtSEB97WPQcLt
 gXdtd3Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.03.2017 um 12:37 schrieb René Scharfe:
> Add the email-style subject prefix (e.g. "Subject: [PATCH] ") directly
> when it's needed instead of letting log_write_email_headers() prepare
> it in a static buffer in advance.  This simplifies storage ownership and
> code flow.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> This slows down the last three tests in p4000 by ca. 3% for some reason,
> so we may want to only do the first part for now, which is performance
> neutral on my machine.

Update below.

> diff --git a/commit.h b/commit.h
> index 9c12abb911..459daef94a 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -142,21 +142,24 @@ static inline int cmit_fmt_is_mail(enum cmit_fmt fmt)
>  	return (fmt == CMIT_FMT_EMAIL || fmt == CMIT_FMT_MBOXRD);
>  }
>
> +struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
> +
>  struct pretty_print_context {
>  	/*
>  	 * Callers should tweak these to change the behavior of pp_* functions.
>  	 */
>  	enum cmit_fmt fmt;
>  	int abbrev;
> -	const char *subject;
>  	const char *after_subject;
>  	int preserve_subject;
>  	struct date_mode date_mode;
>  	unsigned date_mode_explicit:1;
> +	unsigned print_email_subject:1;

Turning this into an int restores performance according to p4000. 
Didn't know that bitfields can be *that* expensive.

René

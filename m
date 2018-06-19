Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C34801F403
	for <e@80x24.org>; Tue, 19 Jun 2018 20:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967276AbeFSU1J (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 16:27:09 -0400
Received: from mout.web.de ([217.72.192.78]:36949 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967179AbeFSU1H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 16:27:07 -0400
Received: from [192.168.178.36] ([79.237.242.156]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LZedc-1fumPe3q84-00lVwg; Tue, 19
 Jun 2018 22:26:50 +0200
Subject: Re: [PATCH 0/7] grep.c: teach --column to 'git-grep(1)'
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org, avarab@gmail.com,
        gitster@pobox.com
References: <cover.1529365072.git.me@ttaylorr.com>
 <20180619163506.GB22034@sigill.intra.peff.net>
 <5282e3bb-bf7a-ab3a-98dc-d29ff1c37468@web.de>
 <20180619174452.GA47272@syl.attlocal.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <80b9a0b1-3849-7097-fe1a-dd80835d62ae@web.de>
Date:   Tue, 19 Jun 2018 22:26:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619174452.GA47272@syl.attlocal.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:5KwkS6ISsfyQhTPwhWBDZoHnOHU66hUSGfjE77kawelfeyyu1HN
 DxtRzFpbPQ237jfDJEXsPSrZrR2/LKfpGW3/R989BoPVh5X0TsY615qQabxyi1psjBqjBBm
 GMcBODeGQDntTJHathcDC/dYxW9RlF4KeTbvaJyZ4Xo4oLRqrpSU2jrr9yz9AcPp2+86Zv9
 Nvj0e7IUIIr28c753Fd7w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7BLqWYSLLQk=:BIKdiZ3dRCFzmu1JzdNRqV
 leUp2tFxvUh0542KYWQgL3YpgeFP1skhqD0x9ESodJYOP72uzIhZ0MA7kF5M1elT3mMlVd0HL
 /vgzWs+6qTNotpBD7WDLRn54/lgOFe8xcZ+mVR9p5/M8QR+8qRJiv4UdgbWyrI6kwAxQJBEXC
 uy3vDPWb8pf8y0zJa6MI7Zc8qnn8U4+QVAY3TVm8NXv0brPXEDsZsakxIlUyKS+s6miD3J2sf
 nUNDSe1ln2q80MapU08Dw3onXGS5s+6vABU5xHxVa1XaGxHgxv4GlA6lQKiJ+j5wyjnNi2ogG
 SacPLN1ICTt17lw2iTJcDMBJV0kpY0hm4vVCNjy/6qIyzcjJyzGgsfLsV/l48hps+GKS3IjMr
 aXqWNFrQU2xo+67hs78En2yN3LowkrUb2Pz7O2DYn3CCuH1/KDZ+q5RSiWlsbS+2Hx6Teix+/
 3MMuWIegmgxUC5+6iIFMSfpZikOiXTxoBeIQDvvbte7HGrfcNrOM2T8Km19S9I5MQotzAtT8M
 vYcm5Nb+mcNgtYyWLpmVwm1OA/BiLqkG7XATo+Zu4uMQTLD9VWwtrfxtdiIZp4Io05L/HTWj7
 iQwYht3GlY/SdR1UTFlhfzrLZe60QdzhEIDxus769C2kTSqhq+UxF9MZBA1jUPtN7EzevXRzH
 wiKqA2PntLTF/NZBUltv6IAxfX3XWswPWkDGfUJyRF5o6Pag5IY50bXy2TOjkYE4NVQxY1cIQ
 FamAZRPlo4/E4WQSE6b87G8gJOrj7WgZBsesN1/mWFpWSQi9Uidl0fgvGu5Nu49AVvKFl+z6/
 bQQqXEr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.06.2018 um 19:44 schrieb Taylor Blau:
> diff --git a/grep.c b/grep.c
> index f3329d82ed..a09935d8c5 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -1257,8 +1257,8 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
>   	return hit;
>   }
> 
> -static int match_expr_eval(struct grep_expr *x, char *bol, char *eol,
> -			   enum grep_context ctx, ssize_t *col,
> +static int match_expr_eval(struct grep_opt *opt, struct grep_expr *x, char *bol,
> +			   char *eol, enum grep_context ctx, ssize_t *col,
>   			   ssize_t *icol, int collect_hits)

Passing opt in is one way.  Piggy-backing on collect_hits and making it
a flags parameter for two bits might be easier.  At least it wouldn't
increase the number of function arguments any further.  Not sure.

Anyway, something like this would be needed as well; or we could
force opt->columnnum to switch opt->extended on:

diff --git a/grep.c b/grep.c
index 8ffa94c791..a724ca3010 100644
--- a/grep.c
+++ b/grep.c
@@ -1325,6 +1321,7 @@ static int match_line(struct grep_opt *opt, char *bol, char *eol,
 		      enum grep_context ctx, int collect_hits)
 {
 	struct grep_pat *p;
+	int hit = 0;
 
 	if (opt->extended)
 		return match_expr(opt, bol, eol, ctx, col, icol,
@@ -1334,11 +1331,14 @@ static int match_line(struct grep_opt *opt, char *bol, char *eol,
 	for (p = opt->pattern_list; p; p = p->next) {
 		regmatch_t tmp;
 		if (match_one_pattern(p, bol, eol, ctx, &tmp, 0)) {
-			*col = tmp.rm_so;
-			return 1;
+			hit |= 1;
+			if (!opt->columnnum)
+				break;
+			if (*col < 0 || tmp.rm_so < *col)
+				*col = tmp.rm_so;
 		}
 	}
-	return 0;
+	return hit;
 }
 
 static int match_next_pattern(struct grep_pat *p, char *bol, char *eol,

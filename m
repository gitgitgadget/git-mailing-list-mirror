Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ABA71F954
	for <e@80x24.org>; Thu, 23 Aug 2018 14:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732091AbeHWR4O (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 13:56:14 -0400
Received: from mout.gmx.net ([212.227.15.15]:35365 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731373AbeHWR4O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 13:56:14 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5Lmp-1g2I4f47OJ-00zYPQ; Thu, 23
 Aug 2018 16:26:15 +0200
Date:   Thu, 23 Aug 2018 16:26:14 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] diff.c: pass sign_index to emit_line_ws_markup
In-Reply-To: <20180822222548.236699-1-sbeller@google.com>
Message-ID: <nycvar.QRO.7.76.6.1808231625510.73@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1808211813020.73@tvgsbejvaqbjf.bet> <20180822222548.236699-1-sbeller@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WLQ6jQezCFFjx8smKsm8q4nsCqVp63uMoGUJrjlyhFBoHi8E5Cb
 Ix0J+r0DMaRVoo5zF6ei8gZb6I7AbZ9NlZBLb2g6KeWerxWWsh0lG51VFc+EHkGimrdzhXS
 5i6dvPd4DGgdxYBh7BFPumApJdSF6icHdf4FH+9j4qFISaegaLxFWBjL3LTUZphXY672JN/
 ppVHya1KNpdJ0nHAfm9fw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J7UFFTVbugI=:9dfpJe0cdlQz2Nish3mh9o
 M68jv5usa5vPxy68m/zR6TrO+e3wcI2dyPXexsVsPlf/GdAyv+jvPjA7As6WzsWm6hnRncX8G
 bBMOhQqVSVLGlaxOFDWKVlreFu+YNScVov7zz1v/fZAVn+vxWTCNbkZlK7nUuIpM0yWlzFcex
 BWjdyvXNvO++3c4IKf/J+dVTy6FUZCeMvIiZfNP+0EaQQRqQjSufQACfBtdbTyUKT6XJWSSLd
 aDBZ4i6mIKXNqXfcS33yIlky/zho5Uqm1DdWvPoIXb5sJ3+FiLboyIvhsiDjvIbtbIgb0ykg8
 UbTSiOL8Nm1jU9Ncixx3H52iDENhZlo1hIsfEbL3+GJFmaoALZgfNJorIseh4nIM6PwIBqo+b
 uwZww0E3X0QeWT2EOSa2QmbXoSaElnYjFmgv1scbV4K1WyANCB7PjEPZXel3Yh1/pFsfjrXf8
 dRf7L+wKP0MIToBeghM/KhZjd9rpJxy66oqeoN60VYir9xrvKDwnITsacl6HFhNnT7QbGgjvA
 x8090iNSfQ7qQesqsKAPnPu/wWyE3uv587UPut99dJzbdXzohWJaC32+EUvCkFH5SRaf97oeq
 /ddj9Ya0NCzwkOzKpFWEQ70Mkzwj2SrQE/P2aOx0+5G9BMYo6rSxmDtkxDUA3hPTZlJJXnEUg
 hG46TA5YBYBFDuDpYnaIkoQO28c8wYpbIRPVbJJxhkeEAM7HHJv51g0FrwGOrZnlSiQi5lr37
 mlL3qz7s3ue4alYD+SpZfXYAsf4rwd2Xf4tPj7dbdw0E6X9qVyVMuTQTZr61b+piJ+Y+5g9l5
 t9d4CsT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Wed, 22 Aug 2018, Stefan Beller wrote:

> Instead of passing the sign directly to emit_line_ws_markup, pass only the
> index to lookup the sign in diff_options->output_indicators.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>

Looks good to me!

> ---
>  diff.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>  
> So something like this on top of sb/range-diff-colors ?  If a resend is
> needed I'll squash this in (or carry it as a cleanup patch early in the
> series), otherwise we could put this on top.

I'd leave this as a separate commit.

Ciao,
Dscho

> 
> Thanks,
> Stefan
>  
> 
> diff --git a/diff.c b/diff.c
> index 03486c35b75..17e33d506a1 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1199,10 +1199,11 @@ static void dim_moved_lines(struct diff_options *o)
>  static void emit_line_ws_markup(struct diff_options *o,
>  				const char *set_sign, const char *set,
>  				const char *reset,
> -				char sign, const char *line, int len,
> +				int sign_index, const char *line, int len,
>  				unsigned ws_rule, int blank_at_eof)
>  {
>  	const char *ws = NULL;
> +	int sign = o->output_indicators[sign_index];
>  
>  	if (o->ws_error_highlight & ws_rule) {
>  		ws = diff_get_color_opt(o, DIFF_WHITESPACE);
> @@ -1282,8 +1283,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>  				set = diff_get_color_opt(o, DIFF_FILE_OLD);
>  		}
>  		emit_line_ws_markup(o, set_sign, set, reset,
> -				    o->output_indicators[OUTPUT_INDICATOR_CONTEXT],
> -				    line, len,
> +				    OUTPUT_INDICATOR_CONTEXT, line, len,
>  				    flags & (DIFF_SYMBOL_CONTENT_WS_MASK), 0);
>  		break;
>  	case DIFF_SYMBOL_PLUS:
> @@ -1327,8 +1327,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>  			flags &= ~DIFF_SYMBOL_CONTENT_WS_MASK;
>  		}
>  		emit_line_ws_markup(o, set_sign, set, reset,
> -				    o->output_indicators[OUTPUT_INDICATOR_NEW],
> -				    line, len,
> +				    OUTPUT_INDICATOR_NEW, line, len,
>  				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
>  				    flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
>  		break;
> @@ -1372,8 +1371,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>  				set = diff_get_color_opt(o, DIFF_CONTEXT_DIM);
>  		}
>  		emit_line_ws_markup(o, set_sign, set, reset,
> -				    o->output_indicators[OUTPUT_INDICATOR_OLD],
> -				    line, len,
> +				    OUTPUT_INDICATOR_OLD, line, len,
>  				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
>  		break;
>  	case DIFF_SYMBOL_WORDS_PORCELAIN:
> -- 
> 2.18.0.265.g16de1b435c9.dirty
> 
> 

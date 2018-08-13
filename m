Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A86CF1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 11:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbeHMO27 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:28:59 -0400
Received: from mout.gmx.net ([212.227.17.22]:50045 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729110AbeHMO27 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:28:59 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfEsY-1fVs2T0idu-00OlaU; Mon, 13
 Aug 2018 13:46:59 +0200
Date:   Mon, 13 Aug 2018 13:47:05 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 2/4] diff.c: add --output-indicator-{new, old, context}
In-Reply-To: <20180810224923.143625-3-sbeller@google.com>
Message-ID: <nycvar.QRO.7.76.6.1808131343310.71@tvgsbejvaqbjf.bet>
References: <20180810224923.143625-1-sbeller@google.com> <20180810224923.143625-3-sbeller@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gLciR76VPvPvsK09H+fDcPjH5b3CKsi3yOHneDBjMgA1o2xMaBp
 tOK/Z4XWN2HkY0aDOj7xdGsW6QiMAyV7oV/CaklvBHFhVSyV2eCOhuC6J5tzR0B17TEWuID
 rJgLzfjej7xqSQhrRxQokPBoLv2Ta4Fk+LMCHYQ7qQv4jRgHDnJehGdUAnZpopyBGCET21y
 6L5xYJuBvreymNLnngbqQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pMFhgH318Jo=:W+C4TKKiluYUglAhORa+7U
 6RRcQqmaJHkZAuy7mteS3kitUbvxs6HPoI+cxAGjNaDGKhl718+wMXm7htHuyEojWttd3CIfL
 H98QXhF5Gp9xxBA5ECtxscKAzuctNVOLrisk8wNIqjHKU39WusmWp3BzyV1dVFEuEgoy/9ffR
 L4TEvYqGh5gLbYxTanVOeDZJwwd465JUEdXMrDAtJhoTmfmfgg0un7eV0RmAkvBGBnR/5Bgxa
 OVdMHkKnNLWVgwIIND2/Nl61gnEqrrTKa2AghpM8G4OqOYh7eNNwgE3FWEVxHa2h6Lq7K/dpK
 R/ITp6AVOuHQI8nT7vQCYTAsYm8a71ZesjpB+15+HYSJ1S9sqqiBtCK8wRvTTLtDvKgaijHpt
 9EPfiYmaZE+yQffQ4fw4Qj3bzXu7wcoeKO1/vuG4gfFAwF/zsNG14kTkvuCOR/Es0lBK7g8BD
 d8UQ6mvLa2mZ8St6MxcFM+Nxm/DJFqCYQ5HDkI7nZPKaf4odBG3CZi+V4OSD/TMokn+2IouAh
 rF+ohyh7v6QDNiO/4bWaQ0FyN8c6J3kM6ERjBR7Y+8q8K7CrH+WIsd6V1QFauQc7oRRJSUHzy
 fmWWjeaMPk3ZMu2gGbvh25EC57FP+vPU287bmWiGTzcndv3xw3n8UkFRUsTqPIZzpIHfPyBJX
 v0xkQw+sBgjD/zOCFaPKSQKVl6g8eCxpCLNiPkN6BbFvNniiH1xjPUxx3nwfCIpNrZ9doimTd
 xLkTm/Yfedv8ADOXnBNyEHbdah9b+5/PpY8PmeDFNiEC8JmgYHFRNXT0Kkd7OzFnshzMo15Kk
 gqRvTwQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Steafn,

On Fri, 10 Aug 2018, Stefan Beller wrote:

> This will prove useful in range-diff in a later patch as we will be able to
> differentiate between adding a new file (that line is starting with +++
> and then the file name) and regular new lines.

Very good!

> It could also be useful for experimentation in new patch formats, i.e.
> we could teach git to emit moved lines with lines other than +/-.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  diff.c | 21 +++++++++++++++++----
>  diff.h |  5 +++++
>  2 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index b3cb73eb69a..b75eb085cb3 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1237,7 +1237,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>  					 struct emitted_diff_symbol *eds)
>  {
>  	static const char *nneof = " No newline at end of file\n";
> -	const char *context, *reset, *set, *set_sign, *meta, *fraginfo;
> +	const char *context, *reset, *set, *set_sign, *meta, *fraginfo, *first;
>  	struct strbuf sb = STRBUF_INIT;
>  
>  	enum diff_symbol s = eds->s;
> @@ -1288,7 +1288,9 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>  			else if (c == '-')
>  				set = diff_get_color_opt(o, DIFF_FILE_OLD);
>  		}
> -		emit_line_ws_markup(o, set_sign, set, reset, " ", line, len,
> +		first = o->output_indicators[OI_CONTEXT] ?
> +			o->output_indicators[OI_CONTEXT] : " ";
> +		emit_line_ws_markup(o, set_sign, set, reset, first, line, len,

Instead of doing this over and over again, how about

1) setting o->output_indicators to " " in diff_setup()?

2) passing OI_CONTEXT to emit_line_ws_markup() instead of `first`? I.e.
   change it to the index in the output_indicators, with -1 indicating
   "none"?

>  				    flags & (DIFF_SYMBOL_CONTENT_WS_MASK), 0);
>  		break;
>  	case DIFF_SYMBOL_PLUS:
> @@ -1331,7 +1333,10 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>  				set = diff_get_color_opt(o, DIFF_CONTEXT_BOLD);
>  			flags &= ~DIFF_SYMBOL_CONTENT_WS_MASK;
>  		}
> -		emit_line_ws_markup(o, set_sign, set, reset, "+", line, len,
> +
> +		first = o->output_indicators[OI_NEW] ?
> +			o->output_indicators[OI_NEW] : "+";
> +		emit_line_ws_markup(o, set_sign, set, reset, first, line, len,
>  				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
>  				    flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
>  		break;
> @@ -1374,7 +1379,9 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>  			else
>  				set = diff_get_color_opt(o, DIFF_CONTEXT_DIM);
>  		}
> -		emit_line_ws_markup(o, set_sign, set, reset, "-", line, len,
> +		first = o->output_indicators[OI_OLD] ?
> +			o->output_indicators[OI_OLD] : "-";
> +		emit_line_ws_markup(o, set_sign, set, reset, first, line, len,
>  				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
>  		break;
>  	case DIFF_SYMBOL_WORDS_PORCELAIN:
> @@ -4876,6 +4883,12 @@ int diff_opt_parse(struct diff_options *options,
>  		 options->output_format |= DIFF_FORMAT_DIFFSTAT;
>  	} else if (!strcmp(arg, "--no-compact-summary"))
>  		 options->flags.stat_with_summary = 0;
> +	else if (skip_prefix(arg, "--output-indicator-new=", &arg))
> +		options->output_indicators[OI_NEW] = arg;
> +	else if (skip_prefix(arg, "--output-indicator-old=", &arg))
> +		options->output_indicators[OI_OLD] = arg;
> +	else if (skip_prefix(arg, "--output-indicator-context=", &arg))
> +		options->output_indicators[OI_CONTEXT] = arg;
>  
>  	/* renames options */
>  	else if (starts_with(arg, "-B") ||
> diff --git a/diff.h b/diff.h
> index e1e54256c18..2d4097df1c7 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -194,6 +194,11 @@ struct diff_options {
>  	FILE *file;
>  	int close_file;
>  
> +#define OI_NEW 0
> +#define OI_OLD 1
> +#define OI_CONTEXT 2

I could imagine that OI_* is too generic a prefix, and that we would want
to have a prefix that is less prone to collide with other global
constants, such as OUTPUT_INDICATOR_*.

Ciao,
Dscho

> +	const char *output_indicators[3];
> +
>  	struct pathspec pathspec;
>  	pathchange_fn_t pathchange;
>  	change_fn_t change;
> -- 
> 2.18.0.865.gffc8e1a3cd6-goog
> 
> 

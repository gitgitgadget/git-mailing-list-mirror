Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB9651F404
	for <e@80x24.org>; Mon, 13 Aug 2018 12:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbeHMO6A (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:58:00 -0400
Received: from mout.gmx.net ([212.227.17.22]:58959 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729084AbeHMO6A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:58:00 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZxch-1fb6Bh2NbD-00LkVG; Mon, 13
 Aug 2018 14:15:54 +0200
Date:   Mon, 13 Aug 2018 14:16:01 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 5/8] diff.c: add set_sign to emit_line_0
In-Reply-To: <20180810223441.30428-6-sbeller@google.com>
Message-ID: <nycvar.QRO.7.76.6.1808131412100.71@tvgsbejvaqbjf.bet>
References: <20180810223441.30428-1-sbeller@google.com> <20180810223441.30428-6-sbeller@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:b5SXq4kqHKqk0UgkpbhUaKS1emt3eKInHt+tkJpfMH7MnvhNR70
 X4s/m1w4m69D5rabMQ64+XxCMsKTZ5YtyTQbaWIekUlPdtMBQY8IDucD1uU8yso0ByB0ujA
 4rbL1URPCji3lLfye1NwIpbGgstLI3pgSYPOc+ABBwj9mEALGYEde0Y2cwHV4YokoJswTzP
 AliLih6Lk5hTyqJfoEJ/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X71IIGXcgTU=:TGZhfusIyaYyZXhXAS8feM
 7siV7YrxQ+J1mE6zlVD7UuuQB1Z0B4FQzHyPc9TvfSpv3OsSeNd4DSaBIN0iICODdG0F4RVRq
 6F1HyLFV7sr84GQiKWpygD2g/962/KqKoSDvXr0aI4rHivB/4FkN7arp38Xs8FqyhY29jD2BV
 JFz6a+W8POK6oFkMWsoUv2eJDNcPnkwfc9P8pAHI4StiOIilngYa4+sHfru96CcjDR+H6HZ4h
 MxROSrM3pN996EqUjQJfoUoNCLw5G2K/DCv/K4yqm1lAlxh1+ctwNKeJTsffqtjkb0hb6ZTg8
 +FI3KiSvftUhh6XED+bD7/oog8jT3SJpeFeWULiD8Lq6/8WyjIKWfbf9gfcmtppIANwS56bAK
 qQFmZk+Btbmg0gxSNCHxCvN+mON+ouIVIiplv3/u6mbqZr7/JPpsl5QZmgws1QHzTZf8fWvvB
 gdEjJyD5GHzGrYCkOq8e84LIAYDvs4tlMvukn6J2SDlOwHBKBrRWQxz6AiyyYuHcN20B8MPbI
 jNonwoTRyAweABLYINRqcHknYNNsvk8uMyzeqoRxbxTzj6pd+rZ4/UvwNuy6VtYHZFhT8qPsD
 YqaHo4LcbqnmX5+bJLdwLref7bg1m6UpFdZyzLNL8hpO5MpuvtDh8xrLLJxgYo9j5aTg49Lew
 vGj4E9HWeTESNMwqSFeagX00OeZ48FvGDpQpq3fuxL/MPuFJvxB7KB1PzrjCcgbaMQoIkwGxE
 agiu0nhO9aOYQDg8OU+Xf2IpadiKKFCKai9HmpA4qArC5JN1QHPRnd+aJla/7ThQ+87cy+s0g
 lnNG8uS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 10 Aug 2018, Stefan Beller wrote:

> For now just change the signature, we'll reason about the actual
> change in a follow up patch.
> 
> Pass 'set_sign' (which is output before the sign) and 'set' which
> controls the color after the first character. Hence, promote any
> 'set's to 'set_sign' as we want to have color before the sign
> for now.

I'll freely admit that I had to study the diff in order to understand this
paragraph.

My I suggest something along those lines instead?

	Split the meaning of the `set` parameter that is passed to
	`emit_line_0()` to separate between the color of the "sign" (i.e.
	the diff marker '+', '-' or ' ' that is passed in as the `first`
	parameter) and the color of the rest of the line.

	This changes the meaning of the `set` parameter to no longer refer
	to the color of the diff marker, but instead to refer to the color
	of the rest of the line. A value of `NULL` indicates that the rest
	of the line wants to be colored the same as the diff marker.

Ciao,
Dscho

> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  diff.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index ab6e6a88a56..5eea5edca50 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -622,7 +622,7 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
>  }
>  
>  static void emit_line_0(struct diff_options *o,
> -			const char *set, unsigned reverse, const char *reset,
> +			const char *set_sign, const char *set, unsigned reverse, const char *reset,
>  			int first, const char *line, int len)
>  {
>  	int has_trailing_newline, has_trailing_carriage_return;
> @@ -652,9 +652,12 @@ static void emit_line_0(struct diff_options *o,
>  	if (len || !nofirst) {
>  		if (reverse && want_color(o->use_color))
>  			fputs(GIT_COLOR_REVERSE, file);
> -		fputs(set, file);
> +		if (set_sign && set_sign[0])
> +			fputs(set_sign, file);
>  		if (first && !nofirst)
>  			fputc(first, file);
> +		if (set)
> +			fputs(set, file);
>  		fwrite(line, len, 1, file);
>  		fputs(reset, file);
>  	}
> @@ -667,7 +670,7 @@ static void emit_line_0(struct diff_options *o,
>  static void emit_line(struct diff_options *o, const char *set, const char *reset,
>  		      const char *line, int len)
>  {
> -	emit_line_0(o, set, 0, reset, line[0], line+1, len-1);
> +	emit_line_0(o, set, NULL, 0, reset, line[0], line+1, len-1);
>  }
>  
>  enum diff_symbol {
> @@ -1199,17 +1202,17 @@ static void emit_line_ws_markup(struct diff_options *o,
>  	}
>  
>  	if (!ws && !set_sign)
> -		emit_line_0(o, set, 0, reset, sign, line, len);
> +		emit_line_0(o, set, NULL, 0, reset, sign, line, len);
>  	else if (!ws) {
>  		/* Emit just the prefix, then the rest. */
> -		emit_line_0(o, set_sign, !!set_sign, reset, sign, "", 0);
> -		emit_line_0(o, set, 0, reset, 0, line, len);
> +		emit_line_0(o, set_sign, NULL, !!set_sign, reset, sign, "", 0);
> +		emit_line_0(o, set, NULL, 0, reset, 0, line, len);
>  	} else if (blank_at_eof)
>  		/* Blank line at EOF - paint '+' as well */
> -		emit_line_0(o, ws, 0, reset, sign, line, len);
> +		emit_line_0(o, ws, NULL, 0, reset, sign, line, len);
>  	else {
>  		/* Emit just the prefix, then the rest. */
> -		emit_line_0(o, set_sign ? set_sign : set, !!set_sign, reset,
> +		emit_line_0(o, set_sign ? set_sign : set, NULL, !!set_sign, reset,
>  			    sign, "", 0);
>  		ws_check_emit(line, len, ws_rule,
>  			      o->file, set, reset, ws);
> @@ -1233,7 +1236,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>  		context = diff_get_color_opt(o, DIFF_CONTEXT);
>  		reset = diff_get_color_opt(o, DIFF_RESET);
>  		putc('\n', o->file);
> -		emit_line_0(o, context, 0, reset, '\\',
> +		emit_line_0(o, context, NULL, 0, reset, '\\',
>  			    nneof, strlen(nneof));
>  		break;
>  	case DIFF_SYMBOL_SUBMODULE_HEADER:
> -- 
> 2.18.0.865.gffc8e1a3cd6-goog
> 
> 

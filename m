Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CBF21F404
	for <e@80x24.org>; Tue, 14 Aug 2018 15:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732711AbeHNRx1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 13:53:27 -0400
Received: from mout.gmx.net ([212.227.17.20]:46053 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728880AbeHNRx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 13:53:27 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lb5Tp-1gIHkB14RN-00kiQw; Tue, 14
 Aug 2018 17:05:46 +0200
Date:   Tue, 14 Aug 2018 17:05:53 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCHv2 0/8] Resending sb/range-diff-colors
In-Reply-To: <20180814014122.30662-1-sbeller@google.com>
Message-ID: <nycvar.QRO.7.76.6.1808141702570.71@tvgsbejvaqbjf.bet>
References: <20180810223441.30428-1-sbeller@google.com> <20180814014122.30662-1-sbeller@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Lfps3XrbWN5uxmK3jUVHY1Nj+W0/kppPUg+QZEGDWH/0lO9DMiI
 N38z1f/HN7ht6/Q1r0GY016V4+JinCSny98y2NT2ee6GfPxLcopw65VEuMRTz0v192WWsgp
 HjrwfmAaCCcQMtf3MiksP8g4Rs0S7uFL6YU0Y3AmqgyaWezgEVowIACgLxSEhBR60BT/UtG
 0bD4fzGFGazaZaykJQAxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7iUvPdo2q4I=:+AH7oHjKZNjOd17ehgCDEa
 o+zvHMb0K2Us5OFr8xJ79OxZPFQmxrBvTfelv7IlFPqyhjpNQOi7a7/NGg57WGN9EfYxi1Wmd
 ln3nIxHJ8Ha4q30ReiVY1xIhYW5bkBfF7cNaU8SyK+yi0blu66KPwMm/ZeT2CzCCIQ0E/sehE
 A+GDFwu3jgGWC7yQ4JPg5SpgSzi7+m3+vmzoPoVw3MLHLKCkoOst72+E/9st2KKA5h7uw4hEI
 66eOhbZlngDOr6sqLTBXwgA8qT9EnFYNBJ0X+EF8gk0UzmjjIxiz5/sQVe7QTDXAnSdpFbnPb
 Kws8GXVagM4vwnGgTg2Bc+JiNvSqoDUtXiQFTbxZGm9G0+mkpGyEj2DvBWyMHRvSkW9wM01SF
 XELe1g2rItmzZrz8eHzzLHiaUq+qoG0mV5pZpZo5NCn+nIQUR5FkKtFXmIocHfiEK4tfVkeEr
 Wvg+rD3y+tvPDz1bnbkubgrB02mdfNQ8EI5NZHLqm4z/jhnMgcjBpyZytVYS4jNBXb8cXwTr2
 bZvWsJTibWfBlopjrC6cu1xjPE4KBsoJnPvlZI/5kJ2K1dSTK2ZcoKe/26RdvcNC4t8NAPYYa
 LpP+006u42OYZiesGgTiJJ8q2qLR9UZscf9UVTiiUTcMRKnuGQR8ms3Su4ajwGAsCv3nmrqBN
 KPVWsqmrcZzhDrLX57dl6sfDS2KlBMum1o5r/raBoJX8anYWTsEcsk3giixDnoWvJol0EZRFf
 TQ35zwd21l1njdivWns5hYy1yr8S6ASAgvm9T3ZL7PoBZZTulXydH6tZdQGhQGYEt6qxw2Q87
 yOQqWlH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Mon, 13 Aug 2018, Stefan Beller wrote:

> This applies on top of js/range-diff (a7be92acd9600), this version 
> * resolves a semantic conflict in the test
>   (Did range-diff change its output slightly?)

If by semantic conflict you mean...

> 23:  6a1c7698c68 ! 23:  5701745379b t3206: add color test for range-diff --dual-color
>     @@ -23,7 +23,7 @@
>      +	:         s/4/A/<RESET>
>      +	:     <RESET>
>      +	:    <REVERSE><GREEN>+<RESET><BOLD>    Also a silly comment here!<RESET>
>     -+	:    <REVERSE><GREEN>+<RESET>
>     ++	:    <REVERSE><GREEN>+<RESET><BOLD><RESET>

... this, then I do not understand. This looks like a straight-up change
in your commit. v1 of this patch did not append <BOLD><RESET> to the end,
while v2 apparently does.

And it looks a bit funny, indeed.

In any case, from what I see you indeed addressed all my comments (the
need_reset was done differently than I suggested, but still okay).

Ciao,
Dscho

>      +	:     diff --git a/file b/file<RESET>
>      +	:    <RED> --- a/file<RESET>
>      +	:    <GREEN> +++ b/file<RESET>
> 24:  7e12ece1d34 = 24:  4e56f63a5f5 diff.c: simplify caller of emit_line_0
> 25:  74dabd6d36f ! 25:  cf126556940 diff.c: reorder arguments for emit_line_ws_markup
>     @@ -3,7 +3,8 @@
>          diff.c: reorder arguments for emit_line_ws_markup
>      
>          The order shall be all colors first, then the content, flags at the end.
>     -    The colors are in order.
>     +    The colors are in the order of occurrence, i.e. first the color for the
>     +    sign and then the color for the rest of the line.
>      
>          Signed-off-by: Stefan Beller <sbeller@google.com>
>          Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 26:  e304e15aa6b ! 26:  69008364cb8 diff.c: add set_sign to emit_line_0
>     @@ -2,14 +2,17 @@
>      
>          diff.c: add set_sign to emit_line_0
>      
>     -    For now just change the signature, we'll reason about the actual
>     -    change in a follow up patch.
>     +    Split the meaning of the `set` parameter that is passed to
>     +    emit_line_0()` to separate between the color of the "sign" (i.e.
>     +    the diff marker '+', '-' or ' ' that is passed in as the `first`
>     +    parameter) and the color of the rest of the line.
>      
>     -    Pass 'set_sign' (which is output before the sign) and 'set' which
>     -    controls the color after the first character. Hence, promote any
>     -    'set's to 'set_sign' as we want to have color before the sign
>     -    for now.
>     +    This changes the meaning of the `set` parameter to no longer refer
>     +    to the color of the diff marker, but instead to refer to the color
>     +    of the rest of the line. A value of `NULL` indicates that the rest
>     +    of the line wants to be colored the same as the diff marker.
>      
>     +    Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>          Signed-off-by: Stefan Beller <sbeller@google.com>
>          Signed-off-by: Junio C Hamano <gitster@pobox.com>
>      
>     @@ -30,12 +33,15 @@
>       		if (reverse && want_color(o->use_color))
>       			fputs(GIT_COLOR_REVERSE, file);
>      -		fputs(set, file);
>     -+		if (set_sign && set_sign[0])
>     ++		if (set_sign)
>      +			fputs(set_sign, file);
>       		if (first && !nofirst)
>       			fputc(first, file);
>     -+		if (set)
>     ++		if (set && set != set_sign) {
>     ++			if (set_sign)
>     ++				fputs(reset, file);
>      +			fputs(set, file);
>     ++		}
>       		fwrite(line, len, 1, file);
>       		fputs(reset, file);
>       	}
> 27:  8d935d5212c <  -:  ----------- diff: use emit_line_0 once per line
> 28:  2344aac787a <  -:  ----------- diff.c: compute reverse locally in emit_line_0
>  -:  ----------- > 27:  5d2629281a1 diff: use emit_line_0 once per line
>  -:  ----------- > 28:  5240e94a69a diff.c: omit check for line prefix in emit_line_0
> 29:  4dc97b54a35 ! 29:  058e03a1601 diff.c: rewrite emit_line_0 more understandably
>     @@ -2,21 +2,15 @@
>      
>          diff.c: rewrite emit_line_0 more understandably
>      
>     -    emit_line_0 has no nested conditions, but puts out all its arguments
>     -    (if set) in order. There is still a slight confusion with set
>     -    and set_sign, but let's defer that to a later patch.
>     +    Rewrite emit_line_0 to have fewer (nested) conditions.
>      
>     -    'first' used be output always no matter if it was 0, but that got lost
>     -    at "diff: add an internal option to dual-color diffs of diffs",
>     -    2018-07-21), as there we broadened the meaning of 'first' to also
>     -    signal an early return.
>     -
>     -    The change in 'emit_line' makes sure that 'first' is never content, but
>     -    always under our control, a sign or special character in the beginning
>     -    of the line (or 0, in which case we ignore it).
>     +    The change in 'emit_line' makes sure that 'first' is never user data,
>     +    but always under our control, a sign or special character in the
>     +    beginning of the line (or 0, in which case we ignore it).
>     +    So from now on, let's pass only a diff marker or 0 as the 'first'
>     +    character of the line.
>      
>          Signed-off-by: Stefan Beller <sbeller@google.com>
>     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
>      
>      diff --git a/diff.c b/diff.c
>      --- a/diff.c
>     @@ -26,9 +20,7 @@
>       {
>       	int has_trailing_newline, has_trailing_carriage_return;
>      -	int nofirst;
>     - 	int reverse = !!set && !!set_sign;
>     -+	int needs_reset = 0;
>     -+
>     ++	int needs_reset = 0; /* at the end of the line */
>       	FILE *file = o->file;
>       
>       	fputs(diff_line_prefix(o), file);
>     @@ -51,15 +43,16 @@
>      -	if (len || !nofirst) {
>      -		if (reverse && want_color(o->use_color))
>      -			fputs(GIT_COLOR_REVERSE, file);
>     --		if (set_sign || set)
>     --			fputs(set_sign ? set_sign : set, file);
>     +-		if (set_sign)
>     +-			fputs(set_sign, file);
>      -		if (first && !nofirst)
>      -			fputc(first, file);
>      -		if (len) {
>     --			if (set_sign && set && set != set_sign)
>     --				fputs(reset, file);
>     --			if (set)
>     +-			if (set && set != set_sign) {
>     +-				if (set_sign)
>     +-					fputs(reset, file);
>      -				fputs(set, file);
>     +-			}
>      -			fwrite(line, len, 1, file);
>      -		}
>      -		fputs(reset, file);
>     @@ -79,8 +72,8 @@
>      +		needs_reset = 1;
>      +	}
>      +
>     -+	if (set_sign || set) {
>     -+		fputs(set_sign ? set_sign : set, file);
>     ++	if (set_sign) {
>     ++		fputs(set_sign, file);
>      +		needs_reset = 1;
>       	}
>      +
>     @@ -97,7 +90,7 @@
>      +		needs_reset = 1;
>      +	}
>      +	fwrite(line, len, 1, file);
>     -+	needs_reset |= len > 0;
>     ++	needs_reset = 1; /* 'line' may contain color codes. */
>      +
>      +end_of_line:
>      +	if (needs_reset)
>     @@ -109,8 +102,8 @@
>       static void emit_line(struct diff_options *o, const char *set, const char *reset,
>       		      const char *line, int len)
>       {
>     --	emit_line_0(o, set, NULL, reset, line[0], line+1, len-1);
>     -+	emit_line_0(o, set, NULL, reset, 0, line, len);
>     +-	emit_line_0(o, set, NULL, 0, reset, line[0], line+1, len-1);
>     ++	emit_line_0(o, set, NULL, 0, reset, 0, line, len);
>       }
>       
>       enum diff_symbol {
> 

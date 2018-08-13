Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AABA1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 12:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbeHMOvc (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:51:32 -0400
Received: from mout.gmx.net ([212.227.17.21]:58365 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729084AbeHMOvc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:51:32 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ln8gj-1gN8Qn0AUn-00hP3d; Mon, 13
 Aug 2018 14:09:28 +0200
Date:   Mon, 13 Aug 2018 14:09:34 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 4/8] diff.c: reorder arguments for emit_line_ws_markup
In-Reply-To: <20180810223441.30428-5-sbeller@google.com>
Message-ID: <nycvar.QRO.7.76.6.1808131407580.71@tvgsbejvaqbjf.bet>
References: <20180810223441.30428-1-sbeller@google.com> <20180810223441.30428-5-sbeller@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5rgLGt07k6zfvNBoyOcaRf0wqhNvexdPaZ2sWT8oOBkwukrmHbI
 6UIjWZkjInOJjG5bUF2gfAVakn8HcXDG7sI8NHTUfLVXqmrIS3Jy/X+vvad2xoIt7VrJ/cG
 Y4MY7DQCgzHGZLD1NON0rI1HCLDuYU4L4/1VaiJfzYRjcTSMhT6Li5i/y/VRkqPraF8vprL
 t9aheHctq+oo5WNsWdhvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Z/RcJE56bDw=:bJozKvhOgoQwR+goqBXEyW
 l5Qxk9+SnuJ87m2BoFOq7nzxf745CQNWpvOHwbq4LCfzvhZFfdbdhxspG3bpvv/YQT21vpOww
 14HvFNl25KOwmRztkeSGxWTj9z03gjSqh4tkjmkCVZjswk6dldcHvc2E/jf53c5QXPlaBlBmj
 i9Mb8QUqq9/2lK9pCni/clcrK4Y2qxLi6eh9vllOrq6Ji189EmzogtwQV3wtvj5yWee5y7oJ2
 XGezAwi4Rm9l5pcCaoE4derAkQ6LrWR3FJkxsY4YFtx6IeVXHTg/KlL9szlHBUmutwljHhFK5
 xmoM2pWvnEy7Gcb5XplPnpB5vLYDRxgwfjB8gfjksiiiY4iktNEY8IGeRvAn/nJJXGys8hd58
 MPsaPhABXhDofxKm/seVMW1G5h+InJrBay9u/utIhtblRBDlfv+GhzokrmhwuaU1hcRLCbwEM
 St8AjODRm5cfKl1hUZUFe/HsN8WMEDksLRNRBC58XiOqp3+LcSdOUuyoSJDSNtK4YhP76AkN3
 wvA053mmCF64PYTSgMEzEt/gYqEgI92fNb5ZoXdx4xfnpMtlyfM+Uy9MQEjvZ1nOl2BW3vjLU
 qUsigFCXl3ldhWa4sgzlvxa9WFDvH2oQKtzbaQPXAt5z6UlcOM8Wcbj2NEyv6LBHeXGUZtgHR
 BJmZy+FiUiQDSVepfBjQ2H7r9IJUmYPw3zYq+AfvD7+U2tmI3cnUAJJjOVoIgueoJ6CM/9ZFe
 TRTdxEQaqE72krSBGe0TKrCRgpXNREmcr/S7D9Ec+65frDDYAp96dXOQOmIAOx0Acxy1/d9UA
 7Dk5KiJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 10 Aug 2018, Stefan Beller wrote:

> The order shall be all colors first, then the content, flags at the end.

Okay.

> The colors are in order.

In order of what? Of the wavelength?

(I agree that the order now makes more sense, and that the diff is
correct.)

Ciao,
Dscho

> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  diff.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index f6df18af913..ab6e6a88a56 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1185,9 +1185,9 @@ static void dim_moved_lines(struct diff_options *o)
>  }
>  
>  static void emit_line_ws_markup(struct diff_options *o,
> -				const char *set, const char *reset,
> -				const char *line, int len,
> -				const char *set_sign, char sign,
> +				const char *set_sign, const char *set,
> +				const char *reset,
> +				char sign, const char *line, int len,
>  				unsigned ws_rule, int blank_at_eof)
>  {
>  	const char *ws = NULL;
> @@ -1271,7 +1271,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>  			else if (c == '-')
>  				set = diff_get_color_opt(o, DIFF_FILE_OLD);
>  		}
> -		emit_line_ws_markup(o, set, reset, line, len, set_sign, ' ',
> +		emit_line_ws_markup(o, set_sign, set, reset, ' ', line, len,
>  				    flags & (DIFF_SYMBOL_CONTENT_WS_MASK), 0);
>  		break;
>  	case DIFF_SYMBOL_PLUS:
> @@ -1314,7 +1314,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>  				set = diff_get_color_opt(o, DIFF_CONTEXT_BOLD);
>  			flags &= ~DIFF_SYMBOL_CONTENT_WS_MASK;
>  		}
> -		emit_line_ws_markup(o, set, reset, line, len, set_sign, '+',
> +		emit_line_ws_markup(o, set_sign, set, reset, '+', line, len,
>  				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
>  				    flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
>  		break;
> @@ -1357,7 +1357,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>  			else
>  				set = diff_get_color_opt(o, DIFF_CONTEXT_DIM);
>  		}
> -		emit_line_ws_markup(o, set, reset, line, len, set_sign, '-',
> +		emit_line_ws_markup(o, set_sign, set, reset, '-', line, len,
>  				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
>  		break;
>  	case DIFF_SYMBOL_WORDS_PORCELAIN:
> -- 
> 2.18.0.865.gffc8e1a3cd6-goog
> 
> 

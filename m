Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E411A1F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 09:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeJLRIr (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 13:08:47 -0400
Received: from mout.gmx.net ([212.227.17.21]:60299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbeJLRIr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 13:08:47 -0400
Received: from DESKTOP-QUA364F ([89.204.153.145]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0La2Xx-1foAvK2o85-00ljAp; Fri, 12
 Oct 2018 11:37:11 +0200
Received: from DESKTOP-QUA364F ([89.204.153.145]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0La2Xx-1foAvK2o85-00ljAp; Fri, 12
 Oct 2018 11:37:11 +0200
Date:   Fri, 12 Oct 2018 11:37:11 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff.c: pass sign_index to emit_line_ws_markup
In-Reply-To: <20181010232459.251289-1-sbeller@google.com>
Message-ID: <nycvar.QRO.7.76.6.1810121136490.45@tvgsbejvaqbjf.bet>
References: <20181010232459.251289-1-sbeller@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:IbdsHo9l20VQI1Ve46rt3lNV1Vbv3PqELDFmyEyEqa0CQcNOp4d
 GSqf1Rj3WjUx+QQcf0TnuyWHl8XnqHMpJe8FsSOvdxRo77etRqeMUJammPN7uJMSeFymL6I
 dCXBZpRD8ij33a0Os1Jh+nKY4O9PKGWgO3zIF8XhLikRef7YAt8jHYV8O0U85/D5fK4LQph
 Avzk8Ztugc6RklqEuiOEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CgbK6SzANSs=:yXK8nRnupt+R1231GFM617
 5QpVQUCWWT75+ZONrzW8dEw+dXP9dmu+0k5eLWtPyjYRFSFd6Yq6u7+xuW51C5lJakRwIU83D
 3pRL+6frsvvLXmbbgQYv5H5M71xhctTkDKIBz9yJNL/AqWh8G/5UlgNPUlVFuiHXnb1xZXubB
 sFA6J7U/NU6qys/q+xKqC+uLg5vyWdw7JWyN0WXCI/ZtAkvJCv80fkWF028n6SSveCwShY4jW
 aKjoN34GglvUazZLwA1DEuSmtudruzjQWotFY6qJ5Kt+nVbHU3ohtT0gX1Qs5VC1bFkm5jq+1
 inWn7VOVnoBQ6Vbg1U55HfbLnZESAoy6uPAPBmSqZLD/tfYc5hnJ3rrUrZQVEx/BmSWa1oQNh
 sfjrMynOXk/Z6KoLOi1aPsuc3Til2Pq0MeYH983Y7mh6pgl15xvKJ+m3T8eSsXIdtz+9p1zaE
 r8Roupumlv05GOKQSVdaiciepuS9Y23Gwfc/g1eqqW8buk3btQnJ1GwrT94Aq6wCc4mE4dCYt
 +avHWWNxTwWhZem9FkxGSQcC8iNnWDJmhvY6v3vH5ZfOMJq4Lga7W8EruqMBmRTlzUR+CU6HR
 UID9VGSRl1lwmOuO65DIJdd2TGLf9NPYSZWjU/T9nIgHvaHkK78x9dd2p9RkXhXNLNcegW4Hv
 7mSnQL43hxQIenjZANoZ167rE8vF7yWutzYCcbOiY58/I30IacJ1ARU+3H7gky1m4o0hVYSK7
 WYcAFlCnXWC47TLE4T9L0aZGVlCZWw65a87wvxpknHl1LcXrTNuyT0S2pC9Fh9DlKOE7Ro/kV
 ZWBjcXCENlu00Zcb53OQpME8eUvX0Xy/BoA95vwCOM4dnf6TrU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Wed, 10 Oct 2018, Stefan Beller wrote:

> Instead of passing the sign directly to emit_line_ws_markup, pass only the
> index to lookup the sign in diff_options->output_indicators.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
> I still have this patch laying around, it simplifies the diff code
> a tiny bit.

And I still like it (obviously, was my idea :-))

Thanks,
Dscho

> 
> Stefan
> 
>  diff.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index f0c7557b40..9e895f2191 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1202,10 +1202,11 @@ static void dim_moved_lines(struct diff_options *o)
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
> @@ -1285,8 +1286,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>  				set = diff_get_color_opt(o, DIFF_FILE_OLD);
>  		}
>  		emit_line_ws_markup(o, set_sign, set, reset,
> -				    o->output_indicators[OUTPUT_INDICATOR_CONTEXT],
> -				    line, len,
> +				    OUTPUT_INDICATOR_CONTEXT, line, len,
>  				    flags & (DIFF_SYMBOL_CONTENT_WS_MASK), 0);
>  		break;
>  	case DIFF_SYMBOL_PLUS:
> @@ -1330,8 +1330,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>  			flags &= ~DIFF_SYMBOL_CONTENT_WS_MASK;
>  		}
>  		emit_line_ws_markup(o, set_sign, set, reset,
> -				    o->output_indicators[OUTPUT_INDICATOR_NEW],
> -				    line, len,
> +				    OUTPUT_INDICATOR_NEW, line, len,
>  				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
>  				    flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
>  		break;
> @@ -1375,8 +1374,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
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
> 2.19.0
> 
> 

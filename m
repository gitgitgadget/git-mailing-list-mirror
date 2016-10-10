Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4508620989
	for <e@80x24.org>; Mon, 10 Oct 2016 17:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752891AbcJJRJo (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:09:44 -0400
Received: from mout.web.de ([217.72.192.78]:52055 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752245AbcJJRJn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:09:43 -0400
Received: from [192.168.178.36] ([79.197.211.11]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0LmcnP-1bJTyp2zEx-00aEk8; Mon, 10 Oct 2016 19:09:24
 +0200
Subject: Re: [PATCH] pretty: respect color settings for %C placeholders
To:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
References: <cb81631e-9623-9020-f955-ec215b493a50@hale.ee>
 <f35965e9-2901-b9b5-92e5-9bc7fe673637@web.de>
 <65d8def3-df62-6c45-7d8f-79b6a8769bf5@hale.ee>
 <25c17e16-2456-7da3-ae22-2dc812a3aa0d@web.de>
 <20161009234617.y6xfjyv6xjkf2afi@sigill.intra.peff.net>
 <CACsJy8CroyynVMctbPhuVr2VVQB7YyfcxDaMT25BikQ4R4We0Q@mail.gmail.com>
 <20161010142818.lglwrxpks6l6aqrm@sigill.intra.peff.net>
 <20161010151517.6wszhuyp57yfncaj@sigill.intra.peff.net>
Cc:     Tom Hale <tom@hale.ee>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <42b3be14-fadb-4801-f377-59fb42b7ccdf@web.de>
Date:   Mon, 10 Oct 2016 19:09:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161010151517.6wszhuyp57yfncaj@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:fQm9lRc4I/GVijZwXlvygQWbZNO5XzN7uB8qtncbROFh3Z5UwNe
 8FCMcj2RhCmGea5Nxe9HW+9wGgrA9ftaSyFpjlGl9Idqwx+EawwWXTpm5w0zwnljKLSDgUK
 HCMQEbN7dOcfOtfW8h4mvo4vqeWea9WhMBp9Y8wz/TQTwyls66EFold36ILeGzPK+Ye3cVt
 t2FeU/4Kz2ImARt1EDTWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JiNrSfvnZtw=:YN6cfyBKOupCVT1kQafXQ5
 q41zvMTnYs8iGqjDfTIipRFk19hI1AoBO2eXDfVKYVO7iJaBCBQH5C6RGP+Vmrj6fBfV24AlD
 1ANfonTof6scMJqPgDX2OXt4wwSlVv5mxtDspYqzrJ1Lzd/BkbYWPjgeWbTOxjbG7ZzmCCS32
 X58z0TA0IEOx1zhjSzMh97JBG5b+X5kC1eUBcVKd3HjqdTSdJ+q0owqhLKrJogDVweZYW1mnM
 dLtfqC5Hhrzxzf5uiTIrWR6Bvgp/yiFBlWab8RiGZYiCQNKMrM1OnJniSYmiY0KGDIZScjgF7
 o9xRQrHuDmRn17k/P5d5LVgcjHe8+C7+tFql9BiYm3Gg8NqTIfudHsuMCkif9/FFq7TKpZTJg
 rF4FuKY0zkyfyjeur+Mzri4CdxWnLWexRjF16OgX6MHKdurPblrT+Z0pHMIiUSsVzGKWGOm1k
 Cwb3uY2WTpPndMPE9R6IgukHHL6N5sJaOn05VzmT9rZ9KaW3JjHP+AVnL4Lc2UOWeXOYfkE97
 O4/fw7+gUt2rCzJOEN1XhDWunOU2Y/uOhrjXov7UjJdpeefTd18KxjSJVnIRQZ76VPBnjXy0W
 UwlGgSH2OvqF3OxGJvjVst1Amq+TT2gBuYtr22mhBCrclm4ZSqD/M4rEvnABYLZP9jurhMZgj
 k4+tc5xm9N2uwdVch6/gyRIzQLoimBHopO4fGsaJHFh1B8UbthTLc8b2gIzfyQ6+i/GPgs2py
 fSyAtSkzusE1sUAswvRj/ljxbn7fsQwwpKC424UmTLbvaYS+XrPh05gNxLgRI3uS84m30WYSF
 6Bg4XKc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.10.2016 um 17:15 schrieb Jeff King:
> On Mon, Oct 10, 2016 at 10:28:18AM -0400, Jeff King wrote:
>
>>> We could add some new tag to change the behavior of all following %C
>>> tags. Something like %C(tty) maybe (probably a bad name), then
>>> discourage the use if "%C(auto" for terminal detection?
>>
>> Yeah, adding a "%C(enable-auto-color)" or something would be backwards
>> compatible and less painful than using "%C(auto)" everywhere. I do
>> wonder if anybody actually _wants_ the "always show color, even if
>> --no-color" behavior. I'm having trouble thinking of a good use for it.
>>
>> IOW, I'm wondering if anyone would disagree that the current behavior is
>> simply buggy. Reading the thread at:
>>
>>   http://public-inbox.org/git/7v4njkmq07.fsf@alter.siamese.dyndns.org/
>>
>> I don't really see any compelling reason against it (there was some
>> question of which config to use, but we already answered that with
>> "%C(auto)", and use the value from the pretty_ctx).
>
> So here's what a patch to do that would look like. I admit that "I can't
> think of a good use" does not mean there _isn't_ one, but perhaps by
> posting this, it might provoke other people to think on it, too. And if
> nobody can come up with, maybe it's a good idea.

Color tags that respect the config and the --color option make the most 
sense to me as well.

Nevertheless a possible counterpoint: Coloring is used in commands that 
are intended for human consumption.  Most of the time there is no need 
to to conserve the output in a file.  But even then, and of course with 
pipes, once you look at it using less -R or grep you still get nice 
colored lines and not a monochrome wall of text.

> -- >8 --
> Subject: pretty: respect color settings for %C placeholders
>
> The color placeholders have traditionally been
> unconditional, showing colors even when git is not otherwise
> configured to do so. This was not so bad for their original
> use, which was on the command-line (and the user could
> decide at that moment whether to add colors or not). But
> these days we have configured formats via pretty.*, and
> those should operate in multiple contexts.
>
> In 3082517 (log --format: teach %C(auto,black) to respect
> color config, 2012-12-17), we gave an extended placeholder
> that could be used to accomplish this. But it's rather
> clunky to use, because you have to specify it individually
> for each color (and their matching resets) in the format.
> We shied away from just switching the default to auto,
> because it is technically breaking backwards compatibility.
>
> However, there's not really a use case for unconditional
> colors. The most plausible reason you would want them
> unconditional is to redirect "git log" output to a file. But
> there, the right answer is --color=always, as it does the
> right thing both with custom user-format colors and
> git-generated colors.
>
> So let's switch to the more useful default. In the
> off-chance that somebody really does find a use for
> unconditional colors without wanting to enable the rest of
> git's colors, we can provide %C(always,...) to enable the
> old behavior.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> The tests unsurprisingly needed updating, as we're breaking the old
> behavior. The diff is easier to read read with "-w".
>
>  Documentation/pretty-formats.txt | 13 +++---
>  pretty.c                         | 19 +++++---
>  t/t6006-rev-list-format.sh       | 94 ++++++++++++++++++++--------------------
>  3 files changed, 70 insertions(+), 56 deletions(-)
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index a942d57..7aa1a8b 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -167,11 +167,14 @@ endif::git-rev-list[]
>  - '%Cblue': switch color to blue
>  - '%Creset': reset color
>  - '%C(...)': color specification, as described in color.branch.* config option;
> -  adding `auto,` at the beginning will emit color only when colors are
> -  enabled for log output (by `color.diff`, `color.ui`, or `--color`, and
> -  respecting the `auto` settings of the former if we are going to a
> -  terminal). `auto` alone (i.e. `%C(auto)`) will turn on auto coloring
> -  on the next placeholders until the color is switched again.
> +  By default, colors are shown only when enabled for log output (by
> +  `color.diff`, `color.ui`, or `--color`, and respecting the `auto`
> +  settings of the former if we are going to a terminal). `%C(auto,...)`
> +  is accepted as a historical synonym for the default. Specifying
> +  `%C(always,...) will show the colors always, even when colors are not
> +  otherwise enabled (to enable this behavior for the whole format, use
> +  `--color=always`). `auto` alone (i.e. `%C(auto)`) will turn on auto
> +  coloring on the next placeholders until the color is switched again.
>  - '%m': left (`<`), right (`>`) or boundary (`-`) mark
>  - '%n': newline
>  - '%%': a raw '%'
> diff --git a/pretty.c b/pretty.c
> index 25efbca..73e58b5 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -965,22 +965,31 @@ static size_t parse_color(struct strbuf *sb, /* in UTF-8 */
>
>  		if (!end)
>  			return 0;
> -		if (skip_prefix(begin, "auto,", &begin)) {
> +
> +		if (!skip_prefix(begin, "always,", &begin)) {
>  			if (!want_color(c->pretty_ctx->color))
>  				return end - placeholder + 1;
>  		}

Shouldn't we have an "else" here?

> +
> +		/* this is a historical noop */
> +		skip_prefix(begin, "auto,", &begin);
> +
>  		if (color_parse_mem(begin, end - begin, color) < 0)
>  			die(_("unable to parse --pretty format"));
>  		strbuf_addstr(sb, color);
>  		return end - placeholder + 1;
>  	}
> -	if (skip_prefix(placeholder + 1, "red", &rest))
> +	if (skip_prefix(placeholder + 1, "red", &rest) &&
> +	    want_color(c->pretty_ctx->color))
>  		strbuf_addstr(sb, GIT_COLOR_RED);
> -	else if (skip_prefix(placeholder + 1, "green", &rest))
> +	else if (skip_prefix(placeholder + 1, "green", &rest) &&
> +		 want_color(c->pretty_ctx->color))
>  		strbuf_addstr(sb, GIT_COLOR_GREEN);
> -	else if (skip_prefix(placeholder + 1, "blue", &rest))
> +	else if (skip_prefix(placeholder + 1, "blue", &rest) &&
> +		 want_color(c->pretty_ctx->color))
>  		strbuf_addstr(sb, GIT_COLOR_BLUE);
> -	else if (skip_prefix(placeholder + 1, "reset", &rest))
> +	else if (skip_prefix(placeholder + 1, "reset", &rest) &&
> +		 want_color(c->pretty_ctx->color))
>  		strbuf_addstr(sb, GIT_COLOR_RESET);
>  	return rest - placeholder;
>  }

Perhaps it's a funtion like add_color(sb, ctx, color) or similar would 
be nice?

René

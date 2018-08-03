Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F9971F597
	for <e@80x24.org>; Fri,  3 Aug 2018 03:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbeHCFrE (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 01:47:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36392 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbeHCFrD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 01:47:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id h12-v6so2197764pgs.3
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 20:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fjJ/tpOhOjWpTlNCZz+7siNAoHGtRRzPX+LjHeCM3Xw=;
        b=icRSuJSCUBzCm7wnNI0dZLB7KeRM6vzKrLCKLaVwHXV0Z88wVThweBTEr0NEZPvy5g
         mgEY/u9BesuxAk6HbTD1UOswY43WjW8P8onqGwWo4xFxPE7TQruSH6kE3BNRryFBt2SL
         d7/+p5uZs91vGMAw+/2RuyYvfmi9v9YB/gBKCz5uZcivJk+vDPRBBzVlUK0/VqssjaaK
         wITBUf3FynR259kd2OMKFbKH6B+EzyNcBC9wZb4XY542rZRu1Y6cno2qaKMGNgBvQsC0
         CaSD0OhG4W0apaLviouw7GEIkgpXuLAMD08qFaD7gcjPNWqvcZBf67jrxf4icbE/nEe4
         guSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fjJ/tpOhOjWpTlNCZz+7siNAoHGtRRzPX+LjHeCM3Xw=;
        b=ewoTcvXdEd6I2nyERYUJK0yjY4z2KYsdds8l3GLCWW4nj4cXTFfzP2i8Iz22FAY2Uk
         F0/DVtJtgO9rTAmcUNAisuAmyuE1hFuV5OObvjNJ9SbMPjZkPuFIhUI+9p2dEdQudBPn
         thSaDdQdL0S/s09VY+5ioCva3OPBTtRc2oKJUcAkzJ8sjMARfK/R9xrScdmTyW/Rq8sr
         VIsV42mPj6+GpYyM+ygjK+Byu+sjZz5mDgRggkxhcGleNpny8+rqVJG5ATwJehBfoGQp
         baXLgUN/oV6Y9T1zmQb57NQYxfMufRrJ5YzmT7XE9ZS/xblSGd74/q2iEBFOUYi+d6hG
         bUCA==
X-Gm-Message-State: AOUpUlF84eG5uDMFA4x36nJ4x7PJj5mIaLOvh0nAexSfJkTm1W5h8F1Q
        AFH8Ne6V+Cy0Xe/s5ex+RS8=
X-Google-Smtp-Source: AAOMgpeY3X8JE2fRdw2vGGJVuBM3Cd+6j5H1eqI8l09m3c8TkaWncFS+Sc9RHLHlq8TwPzZgUO96hw==
X-Received: by 2002:a63:555:: with SMTP id 82-v6mr2057258pgf.25.1533268365765;
        Thu, 02 Aug 2018 20:52:45 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id x65-v6sm5456013pfk.140.2018.08.02.20.52.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 20:52:45 -0700 (PDT)
Date:   Thu, 2 Aug 2018 20:52:43 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     gitster@pobox.com, sunshine@sunshineco.com, git@vger.kernel.org
Subject: Re: [PATCH 2/2] sideband: highlight keywords in remote sideband
 output
Message-ID: <20180803035243.GH197924@aiede.svl.corp.google.com>
References: <20180802121308.17371-1-hanwen@google.com>
 <20180802121308.17371-3-hanwen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802121308.17371-3-hanwen@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Han-Wen Nienhuys wrote:

> The colorization is controlled with the config setting "color.remote".
>
> Supported keywords are "error", "warning", "hint" and "success". They
> are highlighted if they appear at the start of the line, which is
> common in error messages, eg.
>
>    ERROR: commit is missing Change-Id

A few questions:

- should this be documented somewhere in Documentation/technical/*protocol*?
  That way, server implementors can know to take advantage of it.

- how does this interact with (future) internationalization of server
  messages?  If my server knows that the client speaks French, should
  they send "ERROR:" anyway and rely on the client to translate it?
  Or are we deferring that question to a later day?

[...]
> The Git push process itself prints lots of non-actionable messages
> (eg. bandwidth statistics, object counters for different phases of the
> process), and my hypothesis is that these obscure the actionable error
> messages that our server sends back. Highlighting keywords in the
> draws more attention to actionable messages.

I'd be interested in ways to minimize Git's contribution to this as
well.  E.g. can we make more use of \r to make client-produced progress
messages take less screen real estate?  Should some of the servers
involved (e.g., Gerrit) do so as well?

> The highlighting is done on the client rather than server side, so
> servers don't have to grow capabilities to understand terminal escape
> codes and terminal state. It also consistent with the current state
> where Git is control of the local display (eg. prefixing messages with
> "remote: ").

As a strawman idea, what would you think of a way to allow the server
to do some coloration by using color tags like

 <red>Erreur</red>: ...

?

As an advantage, this would give the server more control.  As a
disadvantage, it is not so useful as "semantic markup", meaning it is
harder to figure out how to present to accessibility tools in a
meaningful way.  Plus, there's the issue of usefulness with existing
servers you mentioned:

> Finally, this solution is backwards compatible: many servers already
> prefix their messages with "error", and they will benefit from this
> change without requiring a server update.

Yes, this seems like a compelling reason to follow this approach.

[...]
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1229,6 +1229,15 @@ color.push::
>  color.push.error::
>  	Use customized color for push errors.
>  
> +color.remote::
> +	A boolean to enable/disable colored remote output. If unset,
> +	then the value of `color.ui` is used (`auto` by default).
> +
> +color.remote.<slot>::
> +	Use customized color for each remote keywords. `<slot>` may be
> +	`hint`, `warning`, `success` or `error` which match the
> +	corresponding keyword.

What positions in a remote message are matched?  If a server prints a
message about something being discouraged because it is error-prone,
would the "error" in error-prone turn red?

[...]
> --- a/sideband.c
> +++ b/sideband.c
> @@ -1,6 +1,103 @@
>  #include "cache.h"
> +#include "color.h"
> +#include "config.h"
>  #include "pkt-line.h"
>  #include "sideband.h"
> +#include "help.h"
> +
> +struct kwtable {

nit: perhaps kwtable_entry?

> +	/*
> +	 * We use keyword as config key so it can't contain funny chars like
> +	 * spaces. When we do that, we need a separate field for slot name in
> +	 * load_sideband_colors().
> +	 */
> +	const char *keyword;
> +	char color[COLOR_MAXLEN];
> +};
> +
> +static struct kwtable keywords[] = {
> +	{ "hint",	GIT_COLOR_YELLOW },
[...]
> +// Returns a color setting (GIT_COLOR_NEVER, etc).

nit: Git uses C89-style /* */ comments.

> +static int use_sideband_colors(void)

Makes sense.

[...]
> +void list_config_color_sideband_slots(struct string_list *list, const char *prefix)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(keywords); i++)
> +		list_config_item(list, prefix, keywords[i].keyword);
> +}

Not about this patch: I wonder if we can eliminate this boilerplate some
time in the future.

[...]
> +/*
> + * Optionally highlight some keywords in remote output if they appear at the
> + * start of the line. This should be called for a single line only.
> + */
> +void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)

Can this be static?

What does 'n' represent?  Can the comment say?  (Or if it's the length
of src, can it be renamed to srclen?)

Super-pedantic nit: even if there are multiple special words at the
start, this will only highlight one. :)  So it could say something
like "Optionally check if the first word on the line is a keyword and
highlight it if so."

> +{
> +	int i;
> + 	if (!want_color_stderr(use_sideband_colors())) {

nit: whitespace damage (you can check for this with "git show --check").
There's a bit more elsewhere.

> +		strbuf_add(dest, src, n);
> +		return;
> +	}
> +
> +	while (isspace(*src)) {
> +		strbuf_addch(dest, *src);
> +		src++;
> +		n--;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(keywords); i++) {
> +		struct kwtable* p = keywords + i;

nit: * should attach to the variable, C-style.

You can use "make style" to do some automatic formatting (though this
is a bit experimental, so do double-check the results).

> +		int len = strlen(p->keyword);
> +                /*
> +                 * Match case insensitively, so we colorize output from existing
> +                 * servers regardless of the case that they use for their
> +                 * messages. We only highlight the word precisely, so
> +                 * "successful" stays uncolored.
> +                 */
> +		if (!strncasecmp(p->keyword, src, len) && !isalnum(src[len])) {
> +			strbuf_addstr(dest, p->color);
> +			strbuf_add(dest, src, len);
> +			strbuf_addstr(dest, GIT_COLOR_RESET);
> +			n -= len;
> +			src += len;
> +			break;
> +		}

Sensible.

[...]
> @@ -48,8 +145,10 @@ int recv_sideband(const char *me, int in_stream, int out)
>  		len--;
>  		switch (band) {
>  		case 3:
> -			strbuf_addf(&outbuf, "%s%s%s", outbuf.len ? "\n" : "",
> -				    DISPLAY_PREFIX, buf + 1);
> +			strbuf_addf(&outbuf, "%s%s", outbuf.len ? "\n" : "",
> +				    DISPLAY_PREFIX);
> +			maybe_colorize_sideband(&outbuf, buf + 1, len);
> +
>  			retval = SIDEBAND_REMOTE_ERROR;
>  			break;
>  		case 2:
> @@ -69,20 +168,22 @@ int recv_sideband(const char *me, int in_stream, int out)
>  				if (!outbuf.len)
>  					strbuf_addstr(&outbuf, DISPLAY_PREFIX);
>  				if (linelen > 0) {
> -					strbuf_addf(&outbuf, "%.*s%s%c",
> -						    linelen, b, suffix, *brk);
> -				} else {
> -					strbuf_addch(&outbuf, *brk);
> +					maybe_colorize_sideband(&outbuf, b, linelen);
> +					strbuf_addstr(&outbuf, suffix);
>  				}
> +
> +				strbuf_addch(&outbuf, *brk);
>  				xwrite(2, outbuf.buf, outbuf.len);

Nice.  This looks cleaner than what was there before, which is always
a good sign.

[...]
> --- /dev/null
> +++ b/t/t5409-colorize-remote-messages.sh

Thanks for these.  It may make sense to have a test with some leading
whitespace as well.

[...]
> +test_expect_success 'setup' '
> +	mkdir .git/hooks &&
> +	cat << EOF > .git/hooks/update &&
> +#!/bin/sh
> +echo error: error
> +echo hint: hint
> +echo success: success
> +echo warning: warning
> +echo prefixerror: error
> +exit 0
> +EOF
> +	chmod +x .git/hooks/update &&

Please use write_script for this, since on esoteric platforms it picks
an appropriate shell.

If you use <<-\EOF instead of <<EOF, that has two advantages:
- it lets you indent the script
- it saves the reviewer from having to look for $ escapes inside the
  script body

> +	echo 1 >file &&
> +	git add file &&
> +	git commit -m 1 &&

This can use test_commit.  See t/README for details.

[...]
> +test_expect_success 'push' '
> +	git -c color.remote=always push -f origin HEAD:refs/heads/newbranch 2>output &&
> +	test_decode_color <output >decoded &&
> +	grep "<BOLD;RED>error<RESET>:" decoded &&
> +	grep "<YELLOW>hint<RESET>:" decoded &&
> +	grep "<BOLD;GREEN>success<RESET>:" decoded &&
> +	grep "<BOLD;YELLOW>warning<RESET>:" decoded &&
> +	grep "prefixerror: error" decoded
> +'
> +
> +test_expect_success 'push with customized color' '
> +	git -c color.remote=always -c color.remote.error=white push -f origin HEAD:refs/heads/newbranch2 2>output &&
> +	test_decode_color <output >decoded &&
> +	grep "<WHITE>error<RESET>:" decoded &&
> +	grep "<YELLOW>hint<RESET>:" decoded &&
> +	grep "<BOLD;GREEN>success<RESET>:" decoded &&
> +	grep "<BOLD;YELLOW>warning<RESET>:" decoded
> +'

Nice.

Thanks and hope that helps,
Jonathan

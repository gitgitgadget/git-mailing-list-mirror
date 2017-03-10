Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CBC51FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 18:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933315AbdCJSNs (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 13:13:48 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34846 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932783AbdCJSNq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 13:13:46 -0500
Received: by mail-pg0-f65.google.com with SMTP id g2so6577381pge.2
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 10:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9BxprO+o15S0uEWbBBgDTRBKU53f+B+JxjsUJFLrKoo=;
        b=lSqlO5wSHLQMct/y39Q/9u0Qs8Qrk8qYHiqW6dEh+S6lnzLpNWpvcGRET5Lxpzirbq
         iY3BDPo119cQ9rgQDgcLJZ+EmIZSo1mbK9LX4SI6wfczmM8CjR/zfSuIjoLkYJPC/u6m
         iPDE9g7mogFF1cnlC9NImslnoujg0xzvrlGe3vCnXxPoHw5VSrP/o/ZeFWfcdiJMNPvL
         9UQdadPieYpY2Js6gX0mnepRmxWi3uW64Y1nbQuS91wwWY06F4Wi0tJD80fF6LSs2M7f
         xz7Ep90BFpTaE5peLlM2Cu4skFMDUopyFydKtpcB++sRjK/nclD2c8cbC1+gadhnc4lp
         vkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9BxprO+o15S0uEWbBBgDTRBKU53f+B+JxjsUJFLrKoo=;
        b=pjGXb0+GNMxJwLaSc3oHN8bfVroPLkZUM634VWYrgraGlRK5nEX+gc2C7odFB6BPXS
         rLpy3gsqejx1zmoQ9ST+z5pef8UDX+fr6dZZRZF0Nac/yyORY9eqeMJ1iklX1MOexroS
         yOsxBkMnGzJJ5n3d7ryAk49/j6qsmmtfdZWzm3zO88xoN9jG6JvlbkEfNnqk+Exz7uR2
         e/wSwn4UAZJHmoS0kIichfUSEcdzldQCiT9xNUFhkIS8uvicE9sRgNUrk8VrSdfJIzSj
         0ijq4x7ufb4lM7izdecA/2yYha0kMf46e8WQbN4Qcsniie0POvI7J7BwfjTBMDuT31wq
         bB/Q==
X-Gm-Message-State: AMke39mVFwMxZ1NVUlrI9naaaGf4+FmymnDyjQVkunQG3+vpzm2NSE6vqRirZcPyXzFVfQ==
X-Received: by 10.98.193.69 with SMTP id i66mr22507659pfg.35.1489169625083;
        Fri, 10 Mar 2017 10:13:45 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:9cce:1925:a4e:f6c5])
        by smtp.gmail.com with ESMTPSA id w123sm19929681pfb.44.2017.03.10.10.13.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Mar 2017 10:13:44 -0800 (PST)
Date:   Fri, 10 Mar 2017 10:13:42 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] help: add optional instructions for reporting bugs
Message-ID: <20170310181342.GE26789@aiede.mtv.corp.google.com>
References: <20170309193050.19988-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170309193050.19988-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> When reporting bugs, users will usually look at the output of
> 'git --version' at one point to write a quality bug report.
> So that is a good spot to provide additional information to the user
> about e.g. additional the organizational quirks how to report a bug.
>
> As the output of 'git --version' is parsed by scripts as well,
> we only want to present this information to users, which is why
> we only give the output to TTYs.

Interesting thought.  This might also be a good place to point users
to "git version --build-options" to get more detailed build
information.

The existence of that option also suggests you're on the right track
about 'git version' being the command for this.

> Git is distributed in various ways by various organizations. The Git
> community prefers to have bugs reported on the mailing list, whereas
> other organizations may rather want to have filed a bug in a bug tracker
> or such.  The point of contact is different by organization as well.

It's tempting to put the custom information in --build-options --- e.g.

 $ git version
 git version 2.12.0.190.g6e60aba09d.dirty
 hint: use "git version --build-options" for more detail
 hint: and bug reporting instructions
 $
 $ git version --build-options
 git version 2.12.0.190.g6e60aba09d.dirty
 sizeof-long: 8
 reporting-bugs: see REPORTING BUGS section in "git help git"

Using 'hint:' would put this in the advice category. Usually those are
possible to disable using advice.* configuration (e.g.
advice.versionBuildOptions) for less noisy output.

[...]
> --- a/help.c
> +++ b/help.c
> @@ -9,6 +9,12 @@
>  #include "version.h"
>  #include "refs.h"
>  
> +#ifdef GIT_BUG_REPORT_HELP

If doing this for real, there would be a knob in the Makefile for
setting the bug report string.

[...]
> @@ -435,6 +441,8 @@ int cmd_version(int argc, const char **argv, const char *prefix)
>  			/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
>  		}
>  	}
> +	if (isatty(1))
> +		puts(git_bug_reporting_string);

Should this go to stderr?  E.g. advise() writes to stderr.

Some scripts may run "git version" in output that is written to stdout
and meant to be copy/pasted.  Is there a way for such scripts to
suppress this output?  Should they use -c
advice.versionBuildOptions=0, does 'git version' need an option to
suppress the human-oriented output, should they use 2>/dev/null, or is
this just something that people have to live with?

I'm still on the fence about whether this is a good idea. At least
having custom bug instructions in --build-options sounds like a very
nice thing, but it's not obvious to me how people would learn about
that option.

Thanks and hope that helps,
Jonathan

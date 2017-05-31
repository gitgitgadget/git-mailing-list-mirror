Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97C5D1FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751050AbdEaVXE (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:23:04 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:36042 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbdEaVXD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:23:03 -0400
Received: by mail-io0-f181.google.com with SMTP id o12so23909074iod.3
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2vnT7ohytW8cVc27tBTdDl+c29y8mdNVEF9ZUW1uAO0=;
        b=sns80Tb56U0wpEgYLnSWToEtVDeHQezdq3y9+JioSPrtttP6H9oN28rEgvudRNZWsw
         loma7hVJhhyG9wsSMEHLDyZ4AOANGxdkA0j1nkCjTpVKSx+LU7FZ8a4um0UICutdxk0r
         5ZWAiijtPHD3qUrry49+eBGlkw6zcMD1BdczuD71kqK1aWNk/QuVHFZ0VulaRuou6Dwn
         SL3lCH/rlI3ozer6UylnKcLbrlvUCdseoGH1ok0ZTeQlvcu5/P+EaQkcOdittMy4pHrG
         NciB2qzeZ7EH2X61xHnXw1G7y/HESh1jsc+MSTf7Xv8eciitDiVlH7xe4ehWfAjgVKk+
         ZqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2vnT7ohytW8cVc27tBTdDl+c29y8mdNVEF9ZUW1uAO0=;
        b=Wtxe5ksPAtMbeUyzKDlbh7hc6vVxb6RRqqxPwrBh1uvO1MfN3yFfgTNY0Wph1qdJWQ
         tkCrq6QRLMVTe+YSElLCPCjT90NEu2MS9ZM6zJsOKG+2//jIwWrCpG3mJ2EJgljuyGWS
         SZR+g//jwjL9V/7DhktoWI/Re/YAu3JctIfHNEBitb13zG8H+WRfeEYVSRN+647iI8Wi
         SGapsMWGPPyLKHM0I8WfTzVNRvKxHyzbyGqVCx1xgfeiVI/ef5XH8BVdif0NnzWGY2r4
         OejYV18CULxXc7ByAfpWBIvsiH9k6V6tHS3eI6sk7RnappX486WcRhvqNX1s2BdSzmNI
         tw+Q==
X-Gm-Message-State: AODbwcB5mZ/7wCI939t+33aEmltYav5DnJUb3yBlTqk4NGAyirn22FJC
        aF7HSFD4UhcXcm6sndySw/sjfLWJlA==
X-Received: by 10.107.195.5 with SMTP id t5mr23444721iof.17.1496265782210;
 Wed, 31 May 2017 14:23:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Wed, 31 May 2017 14:22:21 -0700 (PDT)
In-Reply-To: <CAD1ypiUDOtnKwctNQCHmxviPzkDPeP8FT_W2XEXrpHsfgC5Bhg@mail.gmail.com>
References: <CAD1ypiWOcKaLJJzZC=gw75EDFnw_1ZqC94B5p9i722T-sijN1Q@mail.gmail.com>
 <20170531210448.6kolid5umzyasxnc@sigill.intra.peff.net> <CAD1ypiUDOtnKwctNQCHmxviPzkDPeP8FT_W2XEXrpHsfgC5Bhg@mail.gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Wed, 31 May 2017 17:22:21 -0400
Message-ID: <CAJZjrdX=GAbfq8rJPcKb+dwgS6AoH56Q861j=XoAwZ=GXdhQVQ@mail.gmail.com>
Subject: Re: Coloring
To:     Irving Rabin <irving@edmodo.com>
Cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2017 at 5:10 PM, Irving Rabin <irving@edmodo.com> wrote:
>
> Thanks Jeff, my problem has been resolved by Samuel Lijin.
> My terminal settings didn't set bold which remained white. I fixed it
> and my problem was gone!

Specifically, Irving's terminal rendered bold text as white. No bug here :)

> This issue is closed. Is there any way to retire it?

That's pretty much it.

> Irving Rabin
> Software Developer @Edmodo
> 408-242-1299
>
>
>
>
>
> On Wed, May 31, 2017 at 2:04 PM, Jeff King <peff@peff.net> wrote:
> > On Wed, May 31, 2017 at 11:33:31AM -0700, Irving Rabin wrote:
> >
> >> Specifically, if the field is supposed to be white, it doesn't mean it
> >> should be literally 0xFFFFFF. It should be the color that I have
> >> configured as White color for my console emulator.
> >>
> >> I like light-screen terminals, and I configure my ANSI colors in the
> >> way that they are clearly visible on the background and clearly
> >> distinct between themselves. In my terminal settings background is
> >> light-yellow, Black is black, Yellow is brown, Red is dark red,
> >> Magenta is purple and White is dark gray. I set it once and I can use
> >> it everywhere - all Unix commands work correctly, I can edit
> >> highlighted source code in Vim, and all my color settings are
> >> respected.
> >
> > Git outputs ANSI color codes, which are interpreted by your terminal.
> > You _can_ configure Git to send 24-bit color codes if your terminal
> > supports it, but by default it uses the traditional set of limited color
> > and attribute codes.
> >
> > What does running the following snippet in your shell look like?
> >
> > -- >8 --
> >
> > while read name code; do
> >         printf '\033[%sm%s\033[m\n' "$code" "$name"
> > done <<-\EOF
> > normal
> > bold 1
> > red 31
> > green 32
> > yellow 33
> > blue 34
> > magenta 35
> > cyan 36
> > bold-red 1;31
> > bold-green 1;32
> > bold-yellow 1;33
> > bold-blue 1;34
> > bold-magenta 1;35
> > bold-cyan 1;36
> > EOF
> >
> > -- 8< --
> >
> > If any of the colors are not what you expect, is there a pattern? E.g.,
> > I wouldn't be surprised if "bold" shows up as bright white. In many
> > modern terminal emulators, the bold variants need to be configured
> > separately from the non-bold ones, and default to lighter variants of
> > their non-bold counterparts. The solution there would be to check your
> > terminal emulator config.
> >
> > If it does all look as you'd expect, try adding "| less -R" to the end of
> > the "done <<-\EOF" line. Most of Git's output goes through that pager
> > (though I _think_ it's mostly just passing through the ANSI codes, so it
> > wouldn't have any effect).
> >
> > -Peff

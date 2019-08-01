Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49A251F731
	for <e@80x24.org>; Thu,  1 Aug 2019 16:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732799AbfHAQMP (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 12:12:15 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40819 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732797AbfHAQMO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 12:12:14 -0400
Received: by mail-io1-f66.google.com with SMTP id h6so20368322iom.7
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 09:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AhdygbfuoADznz5cY8SBeKp6WIe7mTgAxzlCYW+jDWU=;
        b=mOb/QzSKSHD0adCgpfKXnw/tWPpWzIzyBMexs/2eY3ZXmz7ZAew8167oeDVWUZjp6s
         v3brxR7YF0VNMEg/V4oiP0GWi/9b3EPyUVBEdX+Yyod966Wrq1zvX69x/5bZGmN5Y/TK
         ZoN/m5IAiWktj9jhvr0U1Y1gsLdWlxTUPn1VkDi8jH6X9dldY3UMArRIZDSqEUDiOyJe
         rL0svH06CBFOn93zJ7JxiKoHdiBP/UdH1iyDw8PsNJhxQ3Ik+ZUIWK7l7z42aMpMt+mO
         ZtAE3j/cn2fwfGJMbhLu1hQufBAzu1itwNVbvZI3N8LQJwFR0sC0hNwlTq2gZ1HdFiM/
         2kLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AhdygbfuoADznz5cY8SBeKp6WIe7mTgAxzlCYW+jDWU=;
        b=NWvRxtmC+ymeaCpDxzdiME+QMCKrU3qsYxjToQ0qPSh5ts4tPFNaVTErgHYpNTr/xx
         9XRpoFxlh/tBmBoITzX4vke6tEFzio1jYZXM64MHV9IWWhlWRg3rEOJ/YtFBcDvhkmB/
         W3YdiHbMf9YbA2ynoOxhcsrS9uUDrym6T5jGxsm6D13HNnDL14iXqWumGa/siQN1td5z
         8j1/9Mfx6r4Th5uCSVvb4il4JDPJYvOLJGMEFOs3QTNEbX/eP992wFUK2Q2s2B12+LZH
         OI36elUByg9L/dgzYWo6UW6Rn/o1SkKZH6ermoE3azH/FvzEn7deCfqIyMplCE31pqeh
         Uu6g==
X-Gm-Message-State: APjAAAVIr5SVBMVN72egskn2DkBbK9X2MvmtlCpIHr0Y84neIktDzC66
        odEgQGf2WGJn0n9DjwbUfAb6qFXNan7xyGH5t0Q=
X-Google-Smtp-Source: APXvYqxMyAaBcE3T3pllZGF8XVGU2ns5aIsanmHbIHGxLwlTMFdh9zGrrK4bTj0Q/BXOtOURZSQNOJwfBtw56+2OC84=
X-Received: by 2002:a5d:964d:: with SMTP id d13mr25256472ios.224.1564675933522;
 Thu, 01 Aug 2019 09:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh874tssp.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1907311440130.21907@tvgsbejvaqbjf.bet>
 <20190731231848.GC1933@sigill.intra.peff.net> <20190801002125.GA176307@google.com>
 <xmqqlfwcopn1.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlfwcopn1.fsf@gitster-ct.c.googlers.com>
From:   Ariadne Conill <ariadne@dereferenced.org>
Date:   Thu, 1 Aug 2019 11:12:02 -0500
Message-ID: <CAAOiGNzYUmC+Ns_CiVm-BL06=Sd5ZYuxEgnQK-04BUAwJAqWCQ@mail.gmail.com>
Subject: Re: Git for Windows v2.23.0-rc0, was Re: [ANNOUNCE] Git v2.23.0-rc0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git-for-windows@googlegroups.com,
        Git Mailing List <git@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Thu, Aug 1, 2019 at 10:46 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
> > Although as Dscho mentions, it's particularly irritating because it is
> > not part of the paginated output.
> > ...
> > Let's bite the bullet and jump straight to --use-mailmap in case (4).
> >
> > While at it, add a new log.mailmap setting "auto" that can be used to
> > explicitly request the new automatic behavior (so that e.g. if
> > log.mailmap is set to "true" system-side, I can set it to "auto" in my
> > per-user configuration).
>
> While I think "revert to hardcoded default" may be a good idea, I do
> not think the hardcoded default you implemented that changes the
> behaviour based on the output destination makes much sense.  If I
> want to eradicate junkio@cox.net from my paged/interactive output, I
> want to eradicate it also in the output piped to the script I use
> for authorship stats.
>
> I suspect that you may have misread the "is interactive" bit in the
> original; that was used only to decide if we are going to warn.
>
> Anyway, how about this much simplified version?

It looks good to me.

Acked-by: Ariadne Conill <ariadne@dereferenced.org>

>
> -- >8 --
> From: Junio C Hamano <gitster@pobox.com>
> Date: Thu, 1 Aug 2019 08:32:44 -0700
> Subject: [PATCH] log: flip the --mailmap default unconditionally
>
> It turns out that being cautious to warn against upcoming default
> change was an unpopular behaviour, and such a care can easily be
> defeated by distro packagers to render it ineffective anyway.
>
> Just flip the default, with only a mention in the release notes.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/RelNotes/2.23.0.txt |  8 +++-----
>  builtin/log.c                     | 16 +---------------
>  t/t7006-pager.sh                  |  2 --
>  3 files changed, 4 insertions(+), 22 deletions(-)
>
> diff --git a/Documentation/RelNotes/2.23.0.txt b/Documentation/RelNotes/2.23.0.txt
> index 19e894a44e..6ef8f21b56 100644
> --- a/Documentation/RelNotes/2.23.0.txt
> +++ b/Documentation/RelNotes/2.23.0.txt
> @@ -10,6 +10,9 @@ Backward compatibility note
>     prerequisite patches in an unstable way, which has been updated to
>     compute in a way that is compatible with "git patch-id --stable".
>
> + * The "git log" command by default behaves as if the --mailmap option
> +   was given.
> +
>
>  UI, Workflows & Features
>
> @@ -91,11 +94,6 @@ UI, Workflows & Features
>     commit-graph files now, which allows the commit-graph files to be
>     updated incrementally.
>
> - * The "git log" command learns to issue a warning when log.mailmap
> -   configuration is not set and --[no-]mailmap option is not used, to
> -   prepare users for future versions of Git that uses the mailmap by
> -   default.
> -
>   * "git range-diff" output has been tweaked for easier identification
>     of which part of what file the patch shown is about.
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 1cf9e37736..40b4cbf57d 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -156,16 +156,6 @@ static void cmd_log_init_defaults(struct rev_info *rev)
>                 parse_date_format(default_date_mode, &rev->date_mode);
>  }
>
> -static char warn_unspecified_mailmap_msg[] =
> -N_("log.mailmap is not set; its implicit value will change in an\n"
> -   "upcoming release. To squelch this message and preserve current\n"
> -   "behaviour, set the log.mailmap configuration value to false.\n"
> -   "\n"
> -   "To squelch this message and adopt the new behaviour now, set the\n"
> -   "log.mailmap configuration value to true.\n"
> -   "\n"
> -   "See 'git help config' and search for 'log.mailmap' for further information.");
> -
>  static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>                          struct rev_info *rev, struct setup_revision_opt *opt)
>  {
> @@ -214,12 +204,8 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>         memset(&w, 0, sizeof(w));
>         userformat_find_requirements(NULL, &w);
>
> -       if (mailmap < 0) {
> -               if (session_is_interactive() && !rev->pretty_given)
> -                       warning("%s\n", _(warn_unspecified_mailmap_msg));
> -
> +       if (mailmap < 0)
>                 mailmap = 0;
> -       }
>
>         if (!rev->show_notes_given && (!rev->pretty_given || w.notes))
>                 rev->show_notes = 1;
> diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
> index 7976fa7bcc..00e09a375c 100755
> --- a/t/t7006-pager.sh
> +++ b/t/t7006-pager.sh
> @@ -7,8 +7,6 @@ test_description='Test automatic use of a pager.'
>  . "$TEST_DIRECTORY"/lib-terminal.sh
>
>  test_expect_success 'setup' '
> -       : squelch advice messages during the transition &&
> -       git config --global log.mailmap false &&
>         sane_unset GIT_PAGER GIT_PAGER_IN_USE &&
>         test_unconfig core.pager &&
>
> --
> 2.23.0-rc0-144-gce799e40b3
>
>
>

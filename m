Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED6971FC43
	for <e@80x24.org>; Thu,  5 Oct 2017 21:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751408AbdJEVvl (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 17:51:41 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:51542 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbdJEVvk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 17:51:40 -0400
Received: by mail-qk0-f174.google.com with SMTP id 17so16162708qkq.8
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 14:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GmRYvFRiD+UVsVB78ZQufiQJa6P+KAXc5Fzcjq/z0pg=;
        b=WFNuMex+1XEvHkEhY6uptxcgA3c1V53LvQqqsGB1q7GdlQDruNEJWy54hUs2XQ55dX
         QXb1zWeQTEp+UlX1JiFkSIRADY6DjBc5oU6h7AzAw290Ez886GclFeM35koWzlXogiTr
         h1xDYLGcMZclx7oeeIy/WspNN8UE8bbWM0n57ynny3HNyyVxeGIsmnfedbWhdmsNOKJ1
         5EuF+gEjttS3ExOn37kDHVcyTVG4qVEiCp0Flrl1GbWDaPsHA0l0hckpjy2dQf6PsJ4a
         SR6TtGywGyZIjzC7CqUfw1dCOVskfFC7WGZS/vWQk8Ud/mwXGbJJX9Xa74ywGEvyZZEc
         11tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GmRYvFRiD+UVsVB78ZQufiQJa6P+KAXc5Fzcjq/z0pg=;
        b=W2LCp80za5cyR/4Xtflntx42vBNFH4Bj47ycQDmgci1I2N1tLD9ga7lMEFlSxKt8Lb
         jNCxV7i5ayS8+8PyZxfFsiVNwN+Mg8Sgo4wANAungQAi395S1PnpblCi/Og+7A7c/Oh1
         6gJVD5o0tYnOqF21jjtuzDIp7aeP3JuzGntFWPZ8USt1UzI6xzw1EQrAEw0QZZm8frYX
         AlMKQqdrN1mzntC4laoXCvAWrM6SnQbaWmLB2hF7gjK60Mr7yroocnuwgIktOZKdc0zd
         z0rV1prpsAC4jBBAQjMEy/e5PCjtsYyu16OYHMYXl4DRG1QfxO8RF8eBSFkuNDleJ5OT
         l4Rw==
X-Gm-Message-State: AMCzsaU8SmW/sfOIixmzkZf0e9gWBGlVioBM6T/PnPrm6e1V6pUoLfan
        FPTvUS5jZencR/BNe/baFH2WJCiLrMRooUeNJfiWpCXvsc8=
X-Google-Smtp-Source: AOwi7QDnu3PDiOvfyAJ+TVqx/9/++bL/3e4OQ3OK7roBUWhIbUB37k9q1DoxmqwxqosCqCCYyZq+rNxfJRBfx0fh1m4=
X-Received: by 10.55.33.203 with SMTP id f72mr33202708qki.176.1507240299623;
 Thu, 05 Oct 2017 14:51:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Thu, 5 Oct 2017 14:51:38 -0700 (PDT)
In-Reply-To: <20171005205443.206900-3-jameson.miller81@gmail.com>
References: <20171005205443.206900-1-jameson.miller81@gmail.com> <20171005205443.206900-3-jameson.miller81@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 5 Oct 2017 14:51:38 -0700
Message-ID: <CAGZ79kauDYqkDcVOx3A4PcRttRUVpowAD51cV8pk4qOaU=a=3g@mail.gmail.com>
Subject: Re: [PATCH 2/6] Update documentation for new directory and status logic
To:     Jameson Miller <jameson.miller81@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Jameson Miller <jamill@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 5, 2017 at 1:54 PM,  <jameson.miller81@gmail.com> wrote:
> From: Jameson Miller <jamill@microsoft.com>
>
> Signed-off-by: Jameson Miller <jamill@microsoft.com>
> ---
>  Documentation/git-status.txt                      | 22 +++++++++++++++++-
>  Documentation/technical/api-directory-listing.txt | 28 +++++++++++++++++++----
>  2 files changed, 45 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
> index 9f3a78a36c..7d1410ff3f 100644
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -97,8 +97,28 @@ configuration variable documented in linkgit:git-config[1].
>         (and suppresses the output of submodule summaries when the config option
>         `status.submoduleSummary` is set).
>
> ---ignored::
> +--ignored[=<mode>]::
>         Show ignored files as well.
> ++
> +The mode parameter is used to specify the handling of ignored files.
> +It is optional: it defaults to 'default', and if specified, it must be
> +stuck to the option (e.g. '--ignored=default`, but not `--ignored default`).

Is there a rationale for not accepting `--ignored default`?
(It's just the way OPTION_STRING inputs seem to work,
but in other cases [c.f. man git gc, search "--prune=" ] this is
just implied). Or rather: no need to spell this out explicitly IMHO,
as that draws the users attention to it, which might be confusing.

> ++
> +The possible options are:
> ++
> +       - 'traditional' - Shows ignored files and directories, unless
> +                         --untracked-files=all is specifed, in which case
> +                         individual files in ignored directories are
> +                         displayed.
> +       - 'no'          - Show no ignored files.
> +       - 'matching'    - Shows ignored files and directories matching an
> +                         ignore pattern.
> ++
> +When 'matching' mode is specified, paths that explicity match an
> +ignored pattern are shown. If a directory matches an ignore pattern,
> +then it is shown, but not paths contained in the ignored directory. If
> +a directory does not match an ignore pattern, but all contents are
> +ignored, then the directory is not shown, but all contents are shown.
>
>  -z::
>         Terminate entries with NUL, instead of LF.  This implies
> diff --git a/Documentation/technical/api-directory-listing.txt b/Documentation/technical/api-directory-listing.txt
> index 6c77b4920c..86c981c29c 100644
> --- a/Documentation/technical/api-directory-listing.txt
> +++ b/Documentation/technical/api-directory-listing.txt
> @@ -22,16 +22,20 @@ The notable options are:
>
>  `flags`::
>
> -       A bit-field of options (the `*IGNORED*` flags are mutually exclusive):
> +       A bit-field of options:
>
>  `DIR_SHOW_IGNORED`:::
>
> -       Return just ignored files in `entries[]`, not untracked files.
> +       Return just ignored files in `entries[]`, not untracked
> +       files. This is flag is mutually exclusive with

"is flag is" ?


> +       `DIR_SHOW_IGNORED_TOO`.
>
>  `DIR_SHOW_IGNORED_TOO`:::
>
> -       Similar to `DIR_SHOW_IGNORED`, but return ignored files in `ignored[]`
> -       in addition to untracked files in `entries[]`.
> +       Similar to `DIR_SHOW_IGNORED`, but return ignored files in
> +       `ignored[]` in addition to untracked files in
> +       `entries[]`. This flag is mutually exclusive with
> +       `DIR_SHOW_IGNORED`.
>
>  `DIR_KEEP_UNTRACKED_CONTENTS`:::
>
> @@ -39,6 +43,22 @@ The notable options are:
>         untracked contents of untracked directories are also returned in
>         `entries[]`.
>
> +`DIR_SHOW_IGNORED_TOO_MODE_MATCHING`:::
> +
> +       Only has meaning if `DIR_SHOW_IGNORED_TOO` is also set; if
> +       this is set, returns ignored files and directories that match
> +       an exclude pattern. If a directory matches an exclude pattern,
> +       then the directory is returned and the contained paths are
> +       not. A directory that does not match an exclude pattern will
> +       not be returned even if all of its contents are ignored. In
> +       this case, the contents are returned as individual entries.
> +

I think to make the asciidoc happy, you'd put a '+ LF' as paragraph
delimiter and the subsequent paragraphs are not indented.
C.f. Documentation/git-gc.txt "--auto".
Oh, screw that. It turns out, this place is the only place in our docs
where we use triple colons. So I don't know what I am talking about.

> +If this is set, files and directories
> +       that explicity match an ignore pattern are reported. Implicity
> +       ignored directories (directories that do not match an ignore
> +       pattern, but whose contents are all ignored) are not reported,
> +       instead all of the contents are reported.
> +
>  `DIR_COLLECT_IGNORED`:::
>
>         Special mode for git-add. Return ignored files in `ignored[]` and
> --
> 2.13.6
>

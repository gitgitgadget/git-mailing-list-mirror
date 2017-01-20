Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEECF20A17
	for <e@80x24.org>; Fri, 20 Jan 2017 00:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753645AbdATAiE (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 19:38:04 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:37007 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753340AbdATAiD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 19:38:03 -0500
Received: by mail-it0-f44.google.com with SMTP id r185so9469600ita.0
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 16:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YVs0YcA+OplSfbTMiuzbXv+a0GtgKI5sfRtZM6NTT6I=;
        b=qSL3yACk19oE61YNYXaZhXi/dzsNIvCWntY0TzO3eMTzUfSBb8x/riIko0xSIIeY1F
         k4bFjRQXrM2De5omWdq0e66JHxq7S0H9yzP6vFbnLvEZrsO/Z6BAJgkHiIaGVgomh6i7
         Ci8JCWS05JQ0ohy6/OjqV+wHa8cBWI/x0jigd6fr5ZscslTSNgNnxf2kqOVgW7ujzPQH
         9A+Mf3BQodyMDI9FUuwqd7+AS0URwDeR4Xy/LzBsyftfqZdAP4tqnBbKbBfFDhVRjxGR
         UKzCX3Pr0ZvcIne+EBBnOrOxnInRcC/0ACrmCwk5sM6OaJXdsEwspqbrV4us6iLtpC29
         Nttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YVs0YcA+OplSfbTMiuzbXv+a0GtgKI5sfRtZM6NTT6I=;
        b=C+z3MWGMMTZ0N/O8VwoP2p09ai5Yo/VltKqpy067zVpSmynfpvYP9q65vDERQ5HKI6
         +fw/2p3NIdR6S/8p6brXhj/00UVIVUbNtNfHh2v5s+WW3t+DgXPCtGylHj3CrkoHEX1g
         WMVJ8CaTk26P0UlLBIAM+j6DdipfF9JmRtQgGC9Er1Bw9hqGHxX1UYi/9a6hKmNw8xae
         Jes+npAhP6CBvDeZBpMmbaU5b9CaaCF+ryyBOLm0yVrptdEFLy9ctRDrVmVC8CdLvNt6
         xqgecpIzZN9s78M1gdceroe5x8SLhkGYT4rx+DH2a7ytJOfuxZF/+nKLpkM49GQWqRs7
         gbAw==
X-Gm-Message-State: AIkVDXKcjT3TCrkny3DSDAmtpLVxwF8WzYJrXUt2B0i8TcPc9pfA3hNjtrUhAiKU1Kdoddm9FL7oB8L/wVOniu8G
X-Received: by 10.36.4.2 with SMTP id 2mr1223089itb.116.1484872087961; Thu, 19
 Jan 2017 16:28:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Thu, 19 Jan 2017 16:28:07 -0800 (PST)
In-Reply-To: <1484870858-6336-1-git-send-email-email@benjaminfuchs.de>
References: <1484870858-6336-1-git-send-email-email@benjaminfuchs.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 19 Jan 2017 16:28:07 -0800
Message-ID: <CAGZ79kZNq=O=z-OSr-vDL4SUNViAUZ7AWz01TkGrmG88ZNqxgg@mail.gmail.com>
Subject: Re: [PATCH] git-prompt.sh: add submodule indicator
To:     Benjamin Fuchs <email@benjaminfuchs.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>, szeder.dev@gmail.com,
        felipe.contreras@gmail.com, ville.skytta@iki.fi
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2017 at 4:07 PM, Benjamin Fuchs <email@benjaminfuchs.de> wrote:
> I expirienced that working with submodules can be confusing. This indicator
> will make you notice very easy when you switch into a submodule.
> The new prompt will look like this: (sub:master)
> Adding a new optional env variable for the new feature.
>
> Signed-off-by: Benjamin Fuchs <email@benjaminfuchs.de>

Thanks for making submodules better :)
Relevant tangent, just posted today:
https://public-inbox.org/git/20170119193023.26837-1-sbeller@google.com/T/#u

> ---
>  contrib/completion/git-prompt.sh | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 97eacd7..4c82e7f 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -93,6 +93,10 @@
>  # directory is set up to be ignored by git, then set
>  # GIT_PS1_HIDE_IF_PWD_IGNORED to a nonempty value. Override this on the
>  # repository level by setting bash.hideIfPwdIgnored to "false".
> +#
> +# If you would like __git_ps1 to indicate that you are in a submodule,
> +# set GIT_PS1_SHOWSUBMODULE. In this case a "sub:" will be added before
> +# the branch name.
>
>  # check whether printf supports -v
>  __git_printf_supports_v=
> @@ -284,6 +288,32 @@ __git_eread ()
>         test -r "$f" && read "$@" <"$f"
>  }
>
> +# __git_is_submodule
> +# Based on:
> +# http://stackoverflow.com/questions/7359204/git-command-line-know-if-in-submodule
> +__git_is_submodule ()
> +{
> +       local git_dir parent_git module_name path
> +       # Find the root of this git repo, then check if its parent dir is also a repo
> +       git_dir="$(git rev-parse --show-toplevel)"
> +       module_name="$(basename "$git_dir")"
> +       parent_git="$(cd "$git_dir/.." && git rev-parse --show-toplevel 2> /dev/null)"

I wonder if we want to have better plumbing commands for submodules
here as well:
Here we only check if we have an embedded git repository, which may not be a
submodule. It could be a standalone repo that just happens to be inside another.
It could be a fake submodule [1], though I think the last time I
brought these up,
the upstream Git community considered these fake submodules are bug not worth
fixing.

And this doesn't cover the case that I addressed in the RFC-ish patch above:
  $ git submodule deinit --all
  $ cd <submodule> && git status
  # in an ideal world this tells you:
  #  "You are in an un-populated submodule. To change the submodule state..."

So I guess this is a good first approximation that actually gets most
of the cases right,
thereby helping a lot of people. But I wonder about these cornercases as well?

[1] debuggable.com/posts/git-fake-submodules:4b563ee4-f3cc-4061-967e-0e48cbdd56cb

Thanks,
Stefan

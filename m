Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE8551F609
	for <e@80x24.org>; Wed, 28 Nov 2018 08:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeK1T3m (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 14:29:42 -0500
Received: from mout.gmx.net ([212.227.15.19]:60379 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbeK1T3m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 14:29:42 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M9aX9-1gFazo0NJv-00Cyw1; Wed, 28
 Nov 2018 09:28:47 +0100
Date:   Wed, 28 Nov 2018 09:28:47 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, predatoramigo@gmail.com,
        phillip.wood@talktalk.net
Subject: Re: [PATCH v3 1/7] rebase: fix incompatible options error message
In-Reply-To: <20181122044841.20993-2-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811280000020.41@tvgsbejvaqbjf.bet>
References: <20181108060158.27145-1-newren@gmail.com> <20181122044841.20993-1-newren@gmail.com> <20181122044841.20993-2-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Jjke6PF4OOg5wII7AJEZGBzwD0nkU+nQaE9Bl5O1fbhNDboQLfm
 pOuxbjjvQFKApsX9TPnGX9qZ6KxD8bOxX2wG6AHBOJO0KM4NnzuRcIOc8rWYWUNCFWfw/3v
 1RF1oXoaS3E9A0jRiR3PoF5oAWSp9exiC27Yh8mPxBVclFJ/Ps1q0tZhSgca+WpQkjXtPtp
 701GOXG4gw4YvdJnZku1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ngZNo4ug5Dk=:fSiDC3qTRasl9k1Ju9Ac/m
 kQLN9ZB75ll0aeaa7vcPLbeL+RMlLqsPuMUqyBRYcX4fGXoCAfvgpUUVoG0jFtb24RswgBsKx
 3O9/FXfdsNXCe8GmgeKw4+pnV0hIvwyTDcOrndcTHKC+RnnzPn5pZ123kObjJokn36YpIuIna
 jG2fElOu6Y0HkJnqQkd6N58FHmHm7YXbVF3uIcWaW6WkIHVmcZcarCBLQcYpdFo9OwlGpIcvt
 35iUMisdgy0PqFfpFahOcumhOaZSXHTt6s4inSD+KPWqkUZbsfizPsvgBWAnpFHogbvqU6llw
 xukJocLhBU4KZ7CpUMwHdh8CQ4+Su31zJ2SaCSx8wm24tjIWzsFVujOppUdeLEmHRKeiVnKuG
 CpA8sznJKo+okMXFEQclTM6faQErVe8m21CWWr+yJvv2pnEZ0rXkqE44pSNVqgTRdokTxLYwR
 gy2mfAfb9LGwsN+2ciduQixLGgzNk5v4Eq5JsNvgbDQqY6J+r6IXrKZPlTV/G1KGfvIvXK+1c
 s+WiOysiuIPY88oo2KtJC+Mi0Lk5YCsu4Tiu4SI0prGSZcNg09qiFeY+Z6cfokjXwTpLDsQt6
 6O0J18y8zsFWnoRDH1n0U3hbHq6Ng5c/OfHaurWFk0Jvjk27+1CVG+AXQCKKzPY0CDVBaSxRr
 LP4KS0O57gtg+npfqaiyXZpTbIvofP6jjf9UQfhhkITu7+Yr+JwyXWH3NcdObVO+hyZPMEzcM
 WwRCBIX2aAHbXY0gNTvG+YvSbfzP4pzIC7cZv532TcORIgOqRwfxYsd0Atm/1W42Qto13WJQ6
 /z5TZ/LANs1cZuAtXemcnUAwd/+MOfRl8v20ZrcP+So0ipG42AD/WrD+xtEEkRAwlmg4EiYZ+
 7aQP8Eo7huAe4a/REWVTxHXq415JWUwVmYjO93Vz2jzIzYUtI6KSDgEOccXjE+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 21 Nov 2018, Elijah Newren wrote:

> In commit f57696802c30 ("rebase: really just passthru the `git am`
> options", 2018-11-14), the handling of `git am` options was simplified
> dramatically (and an option parsing bug was fixed), but it introduced
> a small regression in the error message shown when options only
> understood by separate backends were used:
> 
> $ git rebase --keep --ignore-whitespace
> fatal: error: cannot combine interactive options (--interactive, --exec,
> --rebase-merges, --preserve-merges, --keep-empty, --root + --onto) with
> am options (.git/rebase-apply/applying)
> 
> $ git rebase --merge --ignore-whitespace
> fatal: error: cannot combine merge options (--merge, --strategy,
> --strategy-option) with am options (.git/rebase-apply/applying)
> 
> Note that in both cases, the list of "am options" is
> ".git/rebase-apply/applying", which makes no sense.  Since the lists of
> backend-specific options is documented pretty thoroughly in the rebase
> man page (in the "Incompatible Options" section, with multiple links
> throughout the document), and since I expect this list to change over
> time, just simplify the error message.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---

This patch is obviously good.

Given that you embedded it in the patch series that makes the sequencer
the work horse also for the `merge` backend of `git rebase` in addition to
the `interactive` one, may I assume that you intend this patch for post
v2.20.0?

Ciao,
Dscho

>  builtin/rebase.c     | 11 ++++-------
>  git-legacy-rebase.sh |  4 ++--
>  2 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 5b3e5baec8..5ece134ae6 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1202,14 +1202,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  				break;
>  
>  		if (is_interactive(&options) && i >= 0)
> -			die(_("error: cannot combine interactive options "
> -			      "(--interactive, --exec, --rebase-merges, "
> -			      "--preserve-merges, --keep-empty, --root + "
> -			      "--onto) with am options (%s)"), buf.buf);
> +			die(_("error: cannot combine am options "
> +			      "with interactive options"));
>  		if (options.type == REBASE_MERGE && i >= 0)
> -			die(_("error: cannot combine merge options (--merge, "
> -			      "--strategy, --strategy-option) with am options "
> -			      "(%s)"), buf.buf);
> +			die(_("error: cannot combine am options "
> +			      "with merge options "));
>  	}
>  
>  	if (options.signoff) {
> diff --git a/git-legacy-rebase.sh b/git-legacy-rebase.sh
> index b97ffdc9dd..0a747eb76c 100755
> --- a/git-legacy-rebase.sh
> +++ b/git-legacy-rebase.sh
> @@ -508,13 +508,13 @@ if test -n "$git_am_opt"; then
>  	then
>  		if test -n "$incompatible_opts"
>  		then
> -			die "$(gettext "error: cannot combine interactive options (--interactive, --exec, --rebase-merges, --preserve-merges, --keep-empty, --root + --onto) with am options ($incompatible_opts)")"
> +			die "$(gettext "error: cannot combine am options with interactive options")"
>  		fi
>  	fi
>  	if test -n "$do_merge"; then
>  		if test -n "$incompatible_opts"
>  		then
> -			die "$(gettext "error: cannot combine merge options (--merge, --strategy, --strategy-option) with am options ($incompatible_opts)")"
> +			die "$(gettext "error: cannot combine am options with merge options")"
>  		fi
>  	fi
>  fi
> -- 
> 2.20.0.rc1.7.g58371d377a
> 
> 

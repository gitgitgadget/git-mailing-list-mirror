Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 235C51FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 21:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753762AbeARVhC (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 16:37:02 -0500
Received: from mout.gmx.net ([212.227.15.18]:57285 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753525AbeARVhB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 16:37:01 -0500
Received: from [10.122.129.233] ([46.142.197.184]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LlV71-1fCzzc2brj-00bHqq; Thu, 18
 Jan 2018 22:36:55 +0100
Date:   Thu, 18 Jan 2018 22:36:51 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Stefan Beller <sbeller@google.com>
cc:     git@vger.kernel.org, gitster@pobox.com, jacob.keller@gmail.com
Subject: Re: [PATCH 9/8] [DO NOT APPLY, but squash?] git-rebase--interactive:
 clarify arguments
In-Reply-To: <20180118183618.39853-2-sbeller@google.com>
Message-ID: <nycvar.QRO.7.76.6.1801182233480.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <20180118183618.39853-1-sbeller@google.com> <20180118183618.39853-2-sbeller@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:a2y3yiFrJ0cFJmST3Ya5d92CsHIHAyiMpat5v0uOXnAaQswwmwi
 YA0Ez1vjZSEt1LkDka5u9C8QmnvyxHUs98+mPBVgTyEE5RPKiuoCDORvTyDtjN6lWJdLKfQ
 /6Pr3DRz/VMmSoO0o6icVsIzD2V5nLTbbZoSEFMNqdrHmcDIT2cdEtTMIADD4GsEuzEUewG
 dwe0B9FNWbUsE2R66/IoQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xJnF3f+rjZQ=:GH+2nOPq4Jg7A4UcQJedHv
 J9VX8/jZ43KQxzHQbt0/p3tOpN+NvRbwRzaVDj+ppWlQewfhnsJUQRX9ZSHSECS2Yqcjh3Las
 FNMgZUu6WVufnVGvbHFAo7sEP8nU8q4efTjukJGK3FWr6Zn8DdC98sctLarChIhXClHh5SUOE
 VpomREG+bQJs2KmJzi1JBH3vI6ZQwWerbS6nzweZHGkF8cJXnAsLusVJ3KQi4UOdQWae1gm4W
 O/Nqch9ijc9z+jvAnp5pgoRsjIPZ4+KlonhFX+RYCuKt5W8MprNa9xdhKnDXlMSWwkM/CojUB
 2WX4NtXH5aZoDV4FioiWLDP1aSve5KVs/OKQlZQZbIYNu3SYso43wkeNC+DifGykBArhM7y3d
 8jQoWFvlKaFRRkI2G1CZaP6xqcMTtR6ASbmI3I3tlZBLGrnsC2sR9DhP2fXYROOGDvHF7mNwF
 F6uzXBAHd7uI8ocPpIond2PcsEcSan/7+VDbG+7rHO+abNdHcRXBqms83skHkALEKBsJFq06L
 Y5JJjYecgp+XOeSBZzjCbhdO0r1C8VO07G137UCfxQRCgzzZBepwgbJsJTPE2zcf+RhM9HCrb
 G9MhEIa9YNyIvnslHJH3uSsysTcWbHuDCAtauqFRIS8AKFNxiXHPN/iC4s0hi8kMqWmIKDerf
 h3ifhzpxkKm97tzFyWMy1Cjctx8UxhyVaLNng83Ws2Nk5y+V1BIzSjrepcR5EutWWJ9ENEry9
 lfhQFqSlUmULtKHZ8JONzG9IPm4Fot4DKTM3HlZ5/4Gi+JzKp4IMuVrHsBb3XLWnv2ehxd8gJ
 mtf5PphLjJg8RLzpmkTc7hPBx+LdBa9KrVKBBMU7YUPsyZD8uw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Thu, 18 Jan 2018, Stefan Beller wrote:

> Up to now each command took a commit as its first argument and ignored
> the rest of the line (usually the subject of the commit)
> 
> Now that we have commands that take different arguments, clarify each
> command by giving the argument list.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  git-rebase--interactive.sh | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 23184c77e8..3cd7446d0b 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -155,17 +155,17 @@ reschedule_last_action () {
>  append_todo_help () {
>  	gettext "
>  Commands:
> -p, pick = use commit
> -r, reword = use commit, but edit the commit message
> -e, edit = use commit, but stop for amending
> -s, squash = use commit, but meld into previous commit
> -f, fixup = like \"squash\", but discard this commit's log message
> -x, exec = run command (the rest of the line) using shell
> -d, drop = remove commit
> -l, label = label current HEAD with a name
> -t, reset = reset HEAD to a label
> -b, bud = reset HEAD to the revision labeled 'onto'
> -m, merge = create a merge commit using a given commit's message
> +p, pick <commit> = use commit
> +r, reword <commit> = use commit, but edit the commit message
> +e, edit <commit> = use commit, but stop for amending
> +s, squash <commit> = use commit, but meld into previous commit
> +f, fixup <commit> = like \"squash\", but discard this commit's log message
> +x, exec <commit> = run command (the rest of the line) using shell
> +d, drop <commit> = remove commit
> +l, label <label>= label current HEAD with a name
> +t, reset <label> = reset HEAD to a label
> +b, bud = reset HEAD to the revision labeled 'onto', no arguments
> +m, merge [<label-or-commit>]* = create a merge commit using a given commit's message

Good idea! I would rather do it as an introductory patch (that only
converts the existing list).

As to `merge`: it is a bit more complicated ;-)

	m, merge <original-merge-commit> ( <label> | "<label>..." ) [<oneline>]
		create a merge commit using the original merge commit's
		message (or the oneline, if "-" is given). Use a quoted
		list of commits to be merged for octopus merges.

Thanks,
Dscho

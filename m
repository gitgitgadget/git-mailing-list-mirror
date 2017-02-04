Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AD801FAF4
	for <e@80x24.org>; Sat,  4 Feb 2017 11:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753932AbdBDLZr (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 06:25:47 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:35808 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753811AbdBDLZq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 06:25:46 -0500
Received: by mail-io0-f195.google.com with SMTP id m98so4668554iod.2
        for <git@vger.kernel.org>; Sat, 04 Feb 2017 03:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kM/G8zwcbXy/h6hgsANn3lPNxFX/GippCXaHWErApsA=;
        b=lLcZtdtyANiptRj/fQ1zZE9jhrcgIRo6TvMtC30esesIDldeDhbeRgGGAhpNR5saQm
         UqjNn5zq2tI39NE9gc9R1XUoQE4lMvjMisA6BYJ+qwsqdt/3KUIMM0ZUkmjR4WFVpbBj
         6XVe4/wUVBTj2pEXJbQ1yrkGkpc/QqZHCviCfz7kW6J2BNPueBV8xmXLQ7CGyHWesNbK
         n+37RH6Oq5TSH5dfRTk5g0/KObDFzQlqvq0sEQV8/SXp/NdbacYgB6wPmmxQTZoQCjDt
         DR/dLnjqDIwbVHpx5WllkDtwZAljCGT2RutCHcvFicXd04JiqS2tEzvov0jxIa6oz1Jd
         a9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kM/G8zwcbXy/h6hgsANn3lPNxFX/GippCXaHWErApsA=;
        b=IwvYrwwP3aTrQF3FwGAAQS44BLMlJ6zSn93DkevG+1/Bg5wfu+TNbzKmonBZlY7VJn
         x4v6eGQFCZeFz/GoXNWuKRlF4+S9rSYrzvXpdKch/4nWEDrBVyNJbhPe5P/MSptxh5WR
         UFH3lzwsSBJGYlDt9wFrFu0ruP8heDFdXrt1iMscAkrXj4ZuvZsUkFoMqkeP4wALPZ/g
         x2VqDBD6S9peeMvuCbwGtW9g3j07SooFqYZqV6nyixKrnACTHQl96X8OnBgs8Jv2XNdv
         Bn36QALBY09tnpwYi3DhKnJUOO6Bra0MohX6yc1edegLS8qp4vwa1nAIG+6jMa3VRCfr
         +bHQ==
X-Gm-Message-State: AMke39mAl/V2UK/VyDN/fFPfpKlZzwRiDxwdBg/Qqw12Ni5Adr8GyNTcliiXTNzirtrhtfm/gup1JFqJ6UfDTQ==
X-Received: by 10.107.161.83 with SMTP id k80mr917509ioe.47.1486207545944;
 Sat, 04 Feb 2017 03:25:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.147 with HTTP; Sat, 4 Feb 2017 03:25:45 -0800 (PST)
In-Reply-To: <1486195204-26901-1-git-send-email-kannan.siddharth12@gmail.com>
References: <1486195204-26901-1-git-send-email-kannan.siddharth12@gmail.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Sat, 4 Feb 2017 16:55:45 +0530
Message-ID: <CAFZEwPPyJBD0a+Jkr7EBCurFzvHLvZY9r_SFWS2wyW7QmmP4pg@mail.gmail.com>
Subject: Re: [PATCH v2] parse-remote: Remove reference to unused op_prep
To:     Siddharth Kannan <kannan.siddharth12@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey SIddharth,

> Subject: parse-remote: Remove reference to unused op_prep
                                         ^

Minor nit: after the colon, we generally don't use the word starting
with an uppercase letter which I think can be figured out when you run
`git log -p git-parse-remote.sh`

On Sat, Feb 4, 2017 at 1:30 PM, Siddharth Kannan
<kannan.siddharth12@gmail.com> wrote:
> The error_on_missing_default_upstream helper function learned to
> take op_prep argument with 15a147e618 ("rebase: use @{upstream}
> if no upstream specified", 2011-02-09), but as of 045fac5845
> ("i18n: git-parse-remote.sh: mark strings for translation",
>  2016-04-19), the argument is no longer used.  Remove it.
>
> Signed-off-by: Siddharth Kannan <kannan.siddharth12@gmail.com>
> ---
> Thanks a lot, Pranit and Junio for your reviews on the first version of this
> patch. I have changed the messages accordingly.
>
>  contrib/examples/git-pull.sh | 2 +-
>  git-parse-remote.sh          | 3 +--
>  git-rebase.sh                | 2 +-
>  3 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/examples/git-pull.sh b/contrib/examples/git-pull.sh
> index 6b3a03f..1d51dc3 100755
> --- a/contrib/examples/git-pull.sh
> +++ b/contrib/examples/git-pull.sh
> @@ -267,7 +267,7 @@ error_on_no_merge_candidates () {
>                 echo "for your current branch, you must specify a branch on the command line."
>         elif [ -z "$curr_branch" -o -z "$upstream" ]; then
>                 . git-parse-remote
> -               error_on_missing_default_upstream "pull" $op_type $op_prep \
> +               error_on_missing_default_upstream "pull" $op_type \
>                         "git pull <remote> <branch>"
>         else
>                 echo "Your configuration specifies to $op_type $op_prep the ref '${upstream#refs/heads/}'"

I guess I suggested you to not change the file in contrib/ in my
earlier email[1] and to which Junio agreed too[2]. Is there any
confusion?

> diff --git a/git-parse-remote.sh b/git-parse-remote.sh
> index d3c3998..9698a05 100644
> --- a/git-parse-remote.sh
> +++ b/git-parse-remote.sh
> @@ -56,8 +56,7 @@ get_remote_merge_branch () {
>  error_on_missing_default_upstream () {
>         cmd="$1"
>         op_type="$2"
> -       op_prep="$3" # FIXME: op_prep is no longer used
> -       example="$4"
> +       example="$3"
>         branch_name=$(git symbolic-ref -q HEAD)
>         display_branch_name="${branch_name#refs/heads/}"
>         # If there's only one remote, use that in the suggestion
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 04f6e44..b89f960 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -448,7 +448,7 @@ then
>                 then
>                         . git-parse-remote
>                         error_on_missing_default_upstream "rebase" "rebase" \
> -                               "against" "git rebase $(gettext '<branch>')"
> +                               "git rebase $(gettext '<branch>')"
>                 fi
>
>                 test "$fork_point" = auto && fork_point=t
> --
> 2.1.4
>

[1]: http://public-inbox.org/git/CAFZEwPMGTzVuLMSzm8wiNxvia4AV0T79C1ZTfcuO4=Bydz_zQA@mail.gmail.com/
[2]: http://public-inbox.org/git/xmqqd1ey8rul.fsf@gitster.mtv.corp.google.com/

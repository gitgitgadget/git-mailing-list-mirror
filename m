Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94F892095D
	for <e@80x24.org>; Wed, 22 Mar 2017 05:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752184AbdCVFDd (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 01:03:33 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34558 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbdCVFDc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 01:03:32 -0400
Received: by mail-vk0-f65.google.com with SMTP id y16so9149881vky.1
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 22:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T3EYdd9W9BAYRTjkl/o76mjMAR1rIdtHeITJLe9Kd5o=;
        b=AmakULIlLdxCs2T9PhE3FVurin/PVS64QlMC3CQXDNEUmSUXEWlUydRjNZWTZ3KoE7
         C0JY2u1wKbiebG6Zhpvv8XlJac3AIArmpIJBtb60nQoc2/oGGBN41m4BGJgaZg/pqmB0
         3WDX6vZ7CLdTRxC2QLEeAnV1So2QRQxggQs5rObYH41rF3czVxNI4v65FIeFglKr2S6B
         9qNXY34xHqfSKlEo7EVue+6qwUR7QsSpbLO5lyb5+CYXdFLJ9XAOIc0R1pmveuyfgvI7
         EmdTHhoIbYR7o2B/51sEqfm3OtVK/DFoB9VAS4ga9qSOQ+1YVEHMw37lkH4l6HfCpoXB
         VPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T3EYdd9W9BAYRTjkl/o76mjMAR1rIdtHeITJLe9Kd5o=;
        b=aglBCyl6gN+4rGGsTfEaIyoyUXjhYiQ9KmqVAZvVV9eJ1cQejeQB8mXpxZ+LbnW+Jg
         IVNPvKtEJqcGPK4A/2y4b102lsAFCROW4gfyf56ncqvOkGpgZllSCBB7uwy8bhSUrzjm
         RV/j9uYW91sy0mM7ZZkfwPibkE8WgjeSafsaswGoS8ikqWJOz6KtGBr2AU3FQbIHDIIa
         jcqpHLH5qCISieM0XiDBXtn1mo0EXyINAAt86EzIcCNEK4DjTUUrtz5UBNPf4lTbgEuA
         O58FPMxFQrsB/6o/KwJwU3ShbwyFpIgBwb0jNLxTqy1+0WYo5TsroXxp4vcxVo9XENrT
         ovlg==
X-Gm-Message-State: AFeK/H0RIFOWGw+c5LX2vnkIG8zwOQ24QIKbt0lj4KUC1vykoAIF2P6tINCWRPtXuNAO0ee2eYf6qLzjkHcUOw==
X-Received: by 10.176.0.240 with SMTP id 103mr15870790uaj.114.1490158993931;
 Tue, 21 Mar 2017 22:03:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.8.84 with HTTP; Tue, 21 Mar 2017 22:03:13 -0700 (PDT)
In-Reply-To: <20170313065148.10707-1-pc44800@gmail.com>
References: <58c63e10.5585620a.a224d.11cd@mx.google.com> <20170313065148.10707-1-pc44800@gmail.com>
From:   Prathamesh <pc44800@gmail.com>
Date:   Wed, 22 Mar 2017 10:33:13 +0530
Message-ID: <CAME+mvU-4XE1442zMhRpxKjbGcqPEq8t4rc2qQJvyL4vurrkfg@mail.gmail.com>
Subject: Re: [PATCH v3] t2027: avoid using pipes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Jon Loeliger <jdl@jdl.com>,
        Prathamesh <pc44800@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Are there any other changes which I can do to improve my patch?

Thanks,
Prathamesh

On Mon, Mar 13, 2017 at 12:21 PM, Prathamesh <pc44800@gmail.com> wrote:
> Whenever a git command is present in the upstream of a pipe, its failure
> gets masked by piping and hence it should be avoided for testing the
> upstream git command. By writing out the output of the git command to
> a file, we can test the exit codes of both the commands as a failure exit
> code in any command is able to stop the && chain.
>
> Signed-off-by: Prathamesh <pc44800@gmail.com>
> ---
> Changed sendemail.name configuration of the .gitconfig file with a single
> name, and also included the leftover files of each test to be removed by
> test_when_finished if the test is passed successfully.
>
>  t/t2027-worktree-list.sh | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
>
> diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
> index 848da5f36..720063bf0 100755
> --- a/t/t2027-worktree-list.sh
> +++ b/t/t2027-worktree-list.sh
> @@ -20,7 +20,7 @@ test_expect_success 'rev-parse --git-common-dir on main worktree' '
>
>  test_expect_success 'rev-parse --git-path objects linked worktree' '
>         echo "$(git rev-parse --show-toplevel)/.git/objects" >expect &&
> -       test_when_finished "rm -rf linked-tree && git worktree prune" &&
> +       test_when_finished "rm -rf linked-tree actual expect && git worktree prune" &&
>         git worktree add --detach linked-tree master &&
>         git -C linked-tree rev-parse --git-path objects >actual &&
>         test_cmp expect actual
> @@ -28,19 +28,21 @@ test_expect_success 'rev-parse --git-path objects linked worktree' '
>
>  test_expect_success '"list" all worktrees from main' '
>         echo "$(git rev-parse --show-toplevel) $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
> -       test_when_finished "rm -rf here && git worktree prune" &&
> +       test_when_finished "rm -rf here out actual expect && git worktree prune" &&
>         git worktree add --detach here master &&
>         echo "$(git -C here rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
> -       git worktree list | sed "s/  */ /g" >actual &&
> +       git worktree list >out &&
> +       sed "s/  */ /g" <out >actual &&
>         test_cmp expect actual
>  '
>
>  test_expect_success '"list" all worktrees from linked' '
>         echo "$(git rev-parse --show-toplevel) $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
> -       test_when_finished "rm -rf here && git worktree prune" &&
> +       test_when_finished "rm -rf here out actual expect && git worktree prune" &&
>         git worktree add --detach here master &&
>         echo "$(git -C here rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
> -       git -C here worktree list | sed "s/  */ /g" >actual &&
> +       git -C here worktree list >out &&
> +       sed "s/  */ /g" <out >actual &&
>         test_cmp expect actual
>  '
>
> @@ -49,7 +51,7 @@ test_expect_success '"list" all worktrees --porcelain' '
>         echo "HEAD $(git rev-parse HEAD)" >>expect &&
>         echo "branch $(git symbolic-ref HEAD)" >>expect &&
>         echo >>expect &&
> -       test_when_finished "rm -rf here && git worktree prune" &&
> +       test_when_finished "rm -rf here actual expect && git worktree prune" &&
>         git worktree add --detach here master &&
>         echo "worktree $(git -C here rev-parse --show-toplevel)" >>expect &&
>         echo "HEAD $(git rev-parse HEAD)" >>expect &&
> @@ -69,16 +71,17 @@ test_expect_success 'bare repo setup' '
>  '
>
>  test_expect_success '"list" all worktrees from bare main' '
> -       test_when_finished "rm -rf there && git -C bare1 worktree prune" &&
> +       test_when_finished "rm -rf there out actual expect && git -C bare1 worktree prune" &&
>         git -C bare1 worktree add --detach ../there master &&
>         echo "$(pwd)/bare1 (bare)" >expect &&
>         echo "$(git -C there rev-parse --show-toplevel) $(git -C there rev-parse --short HEAD) (detached HEAD)" >>expect &&
> -       git -C bare1 worktree list | sed "s/  */ /g" >actual &&
> +       git -C bare1 worktree list >out &&
> +       sed "s/  */ /g" <out >actual &&
>         test_cmp expect actual
>  '
>
>  test_expect_success '"list" all worktrees --porcelain from bare main' '
> -       test_when_finished "rm -rf there && git -C bare1 worktree prune" &&
> +       test_when_finished "rm -rf there actual expect && git -C bare1 worktree prune" &&
>         git -C bare1 worktree add --detach ../there master &&
>         echo "worktree $(pwd)/bare1" >expect &&
>         echo "bare" >>expect &&
> @@ -92,11 +95,12 @@ test_expect_success '"list" all worktrees --porcelain from bare main' '
>  '
>
>  test_expect_success '"list" all worktrees from linked with a bare main' '
> -       test_when_finished "rm -rf there && git -C bare1 worktree prune" &&
> +       test_when_finished "rm -rf there out actual expect && git -C bare1 worktree prune" &&
>         git -C bare1 worktree add --detach ../there master &&
>         echo "$(pwd)/bare1 (bare)" >expect &&
>         echo "$(git -C there rev-parse --show-toplevel) $(git -C there rev-parse --short HEAD) (detached HEAD)" >>expect &&
> -       git -C there worktree list | sed "s/  */ /g" >actual &&
> +       git -C there worktree list >out &&
> +       sed "s/  */ /g" <out >actual &&
>         test_cmp expect actual
>  '
>
> @@ -118,9 +122,11 @@ test_expect_success 'broken main worktree still at the top' '
>                 cd linked &&
>                 echo "worktree $(pwd)" >expected &&
>                 echo "ref: .broken" >../.git/HEAD &&
> -               git worktree list --porcelain | head -n 3 >actual &&
> +               git worktree list --porcelain >out &&
> +               head -n 3 out >actual &&
>                 test_cmp ../expected actual &&
> -               git worktree list | head -n 1 >actual.2 &&
> +               git worktree list >out &&
> +               head -n 1 out >actual.2 &&
>                 grep -F "(error)" actual.2
>         )
>  '
> @@ -134,7 +140,8 @@ test_expect_success 'linked worktrees are sorted' '
>                 test_commit new &&
>                 git worktree add ../first &&
>                 git worktree add ../second &&
> -               git worktree list --porcelain | grep ^worktree >actual
> +               git worktree list --porcelain >out &&
> +               grep ^worktree out >actual
>         ) &&
>         cat >expected <<-EOF &&
>         worktree $(pwd)/sorted/main
> --
> 2.11.0
>

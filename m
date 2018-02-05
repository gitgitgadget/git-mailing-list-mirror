Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 348891F404
	for <e@80x24.org>; Mon,  5 Feb 2018 21:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbeBEVuo (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 16:50:44 -0500
Received: from mail-yw0-f182.google.com ([209.85.161.182]:45441 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752029AbeBEVum (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 16:50:42 -0500
Received: by mail-yw0-f182.google.com with SMTP id b16so16674470ywh.12
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 13:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BHXVLjRlrGQ9cjkTklg5afuOY9nYYI1QkAjLJJLU9zU=;
        b=kdRUgHX/GofZ/l0IX5zxBsjGAJ5B0KX70S+XmtFjRQVIVOWhJt/eCA4u7YwDBFvaY7
         RgQFFZvv31GM5rIkGO9O9p+YLRIhE9IDyit1I4/XxDuy6pD8z67U32sedydT25aRxAXJ
         VGn4yuF7Q5s0IztKW9ebe2q3yksqtD0wK1m8qlFFc+vL3Mgj1oxapGDTl8Ztm/EqDSr0
         ZwlphlHRIi8Zg0tVhbm1dUWv9IHxdzQX8wboOVHGl5X69LaOsNDb/My5PSuRz4qFuSgA
         Oha/v/riPjNjvpyxpmfpyXmjbl03xM9UPSvLMxBOOL7i/iiE6v4Ha+1lwwkMyZ79KxRb
         4mPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BHXVLjRlrGQ9cjkTklg5afuOY9nYYI1QkAjLJJLU9zU=;
        b=HsKcwwdRIj6ImYqsY2ITDWG+uR6xR8mxvT9/pCEWYqtv9EdeKdTWYrf+yLYX1EgfQD
         gRHrf3Ajxsckuh8NevgUuwQaxqNVidfet2wb6bateNu4ZRyDNJtBnjZEtLOPR8IQP9/C
         hVuVtdCKaA5m+O7GTMhk80Wy9c/J4ZbtBk0PljlIj+gp1xqvqdntYcUzQDamGyvEKkRH
         BUNc2ZMuWXR1LQnu7DPHjCTyDIRIMrKDlv//AWy7geswGCcqvK9UV0X/QzrPK8RHiSkn
         8dV9JWCscPuS3SBf4jMhqxwiTjBYJk6/KmXHwJpRw6f3OUxrYccsJr/8aGsf+oeAo8Yp
         Hq6A==
X-Gm-Message-State: APf1xPCVv4NBxMIn4Z23ivPK1F+xJ+c0x7gcdzZFMtJZuCQpWUs7CL8E
        NP4sjFmbQA3Pn/BAVfACFkB9OwbzTkbsrvCJ8suTuA==
X-Google-Smtp-Source: AH8x225XXHrpbAG2DHvYJoH1TXbKcgbZ1MsiZsW0Lq73nzBdND+hObRqatnzrqPfMCEhPIbYDmNFYojzw8YBTOBGkZY=
X-Received: by 10.129.108.149 with SMTP id h143mr137424ywc.373.1517867441527;
 Mon, 05 Feb 2018 13:50:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Mon, 5 Feb 2018 13:50:41 -0800 (PST)
In-Reply-To: <20180204020318.4363-1-chenjingpiao@gmail.com>
References: <20180204020318.4363-1-chenjingpiao@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Feb 2018 13:50:41 -0800
Message-ID: <CAGZ79kZgqDp49McgtzWRbArsK6qVz1E9Syi5tJo73F-+T4UOiA@mail.gmail.com>
Subject: Re: [GSoC][PATCH] commit: add a commit.signOff config variable
To:     Chen Jingpiao <chenjingpiao@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 3, 2018 at 6:03 PM, Chen Jingpiao <chenjingpiao@gmail.com> wrote:
> Add the commit.signOff configuration variable to use the -s or --signoff
> option of git commit by default.
>
> Signed-off-by: Chen Jingpiao <chenjingpiao@gmail.com>
> ---

Welcome to the Git community!

>
> Though we can configure signoff using format.signOff variable. Someone like to
> add Signed-off-by line by the committer.

There is more discussion about this at
https://public-inbox.org/git/1482946838-28779-1-git-send-email-ehabkost@redhat.com/
specifically
https://public-inbox.org/git/xmqqtw9m5s5m.fsf@gitster.mtv.corp.google.com/

Not sure if there was any other reasons and discussions brought up
since then, but that discussion seems to not favor patches that
add .signoff options.

Thanks,
Stefan

>
>  Documentation/config.txt     |  4 +++
>  Documentation/git-commit.txt |  2 ++
>  builtin/commit.c             |  4 +++
>  t/t7501-commit.sh            | 69 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 79 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 0e25b2c92..5dec3f0cb 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1303,6 +1303,10 @@ commit.gpgSign::
>         convenient to use an agent to avoid typing your GPG passphrase
>         several times.
>
> +commit.signOff::
> +       A boolean value which lets you enable the `-s/--signoff` option of
> +       `git commit` by default. See linkgit:git-commit[1].
> +
>  commit.status::
>         A boolean to enable/disable inclusion of status information in the
>         commit message template when using an editor to prepare the commit
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index f970a4342..7a28ea765 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -166,6 +166,8 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
>         the rights to submit this work under the same license and
>         agrees to a Developer Certificate of Origin
>         (see http://developercertificate.org/ for more information).
> +       See the `commit.signOff` configuration variable in
> +       linkgit:git-config[1].
>
>  -n::
>  --no-verify::
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 4610e3d8e..324213254 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1548,6 +1548,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
>                 sign_commit = git_config_bool(k, v) ? "" : NULL;
>                 return 0;
>         }
> +       if (!strcmp(k, "commit.signoff")) {
> +               signoff = git_config_bool(k, v);
> +               return 0;
> +       }
>         if (!strcmp(k, "commit.verbose")) {
>                 int is_bool;
>                 config_commit_verbose = git_config_bool_or_int(k, v, &is_bool);
> diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
> index fa61b1a4e..46733ed2a 100755
> --- a/t/t7501-commit.sh
> +++ b/t/t7501-commit.sh
> @@ -505,6 +505,75 @@ Myfooter: x" &&
>         test_cmp expected actual
>  '
>
> +test_expect_success "commit.signoff=true and --signoff omitted" '
> +       echo 7 >positive &&
> +       git add positive &&
> +       git -c commit.signoff=true commit -m "thank you" &&
> +       git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
> +       (
> +               echo thank you
> +               echo
> +               git var GIT_COMMITTER_IDENT |
> +               sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
> +       ) >expected &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success "commit.signoff=true and --signoff" '
> +       echo 8 >positive &&
> +       git add positive &&
> +       git -c commit.signoff=true commit --signoff -m "thank you" &&
> +       git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
> +       (
> +               echo thank you
> +               echo
> +               git var GIT_COMMITTER_IDENT |
> +               sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
> +       ) >expected &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success "commit.signoff=true and --no-signoff" '
> +       echo 9 >positive &&
> +       git add positive &&
> +       git -c commit.signoff=true commit --no-signoff -m "thank you" &&
> +       git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
> +       echo thank you >expected &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success "commit.signoff=false and --signoff omitted" '
> +       echo 10 >positive &&
> +       git add positive &&
> +       git -c commit.signoff=false commit -m "thank you" &&
> +       git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
> +       echo thank you >expected &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success "commit.signoff=false and --signoff" '
> +       echo 11 >positive &&
> +       git add positive &&
> +       git -c commit.signoff=false commit --signoff -m "thank you" &&
> +       git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
> +       (
> +               echo thank you
> +               echo
> +               git var GIT_COMMITTER_IDENT |
> +               sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
> +       ) >expected &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success "commit.signoff=false and --no-signoff" '
> +       echo 12 >positive &&
> +       git add positive &&
> +       git -c commit.signoff=false commit --no-signoff -m "thank you" &&
> +       git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
> +       echo thank you >expected &&
> +       test_cmp expected actual
> +'
> +
>  test_expect_success 'multiple -m' '
>
>         >negative &&
> --
> 2.16.1.70.g5ccd54536
>

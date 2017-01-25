Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 729E21F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 05:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751230AbdAYFG1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 00:06:27 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:36728 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751137AbdAYFG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 00:06:26 -0500
Received: by mail-it0-f53.google.com with SMTP id c7so101226401itd.1
        for <git@vger.kernel.org>; Tue, 24 Jan 2017 21:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mcLpPGnnzbUAs/iLwMR4TG2mhs9BK8I8spn3DRLYZ+A=;
        b=CBdTTHVpXHg5UuqbjxZsTYq6894RzKYNE2xjQvx5jquttm51kNm1wiitiKyDifbWel
         DDhvNuxoe9Qwd7X7dBx4vn1AB0BpYuJdDYFg8Awc9kPLWj8aB3SqUat/Ye4167QgJN2b
         CjGQn0mWDmKJEp1zHpUl5P0oZRvLpKn4nTQN6lMPxmwd13d6B/PnXko5DiFypQ1N9unG
         Rb5lrIkmBpryh3AwuhAgsw8hmCtLp5/yYJgH5Vt4qnMSi4SsZwsyjqCITdGBGqtZdRgD
         p8uC8vRjZ149Fh0o/dxBSLSbc9ekGRuejye/5mQOkhjf4Chnudyreswc/wNiBl30798Z
         2IGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mcLpPGnnzbUAs/iLwMR4TG2mhs9BK8I8spn3DRLYZ+A=;
        b=liqXfAM0O1rEi9ZAX0YSohbEpmmdyfV3uWKrP/HdV8f4OjLjpuwdU9b1aRjLJTmWg9
         2TyivV5185N19vEhcGVLJApt5VD4FKBYl4AgUGFjiyUyRiMm/fHQ63m8L0smpd3vtOHT
         Uv7aSdkd/t56mzfglov+fByFaTxyaUX6CXtdG6E+5CLBvbyN3uwFtYUKMR21MTKEbVh0
         kD+gCUpwM03g9l/ESdAS6spB65FZOi8MxeZShyFf+wjiHfolJa8acKDaTzqmWIq6oTHg
         8jvCcNk3Gj6yD7EtTxwc1YPD3YWF6zOXRYfK9k8xlMavIjRikVTFTkKTx6Baj2byT7MX
         5Hmg==
X-Gm-Message-State: AIkVDXKei1lF2QIRHqqlt0YZXWV3N7aGihMIF9bxj+MyOieXyWxq9YkMVYPe2OTKdhg1F4qkgiFVYNBionJclA==
X-Received: by 10.36.181.3 with SMTP id v3mr24142254ite.45.1485320785135; Tue,
 24 Jan 2017 21:06:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.147 with HTTP; Tue, 24 Jan 2017 21:06:24 -0800 (PST)
In-Reply-To: <20170125001906.13916-1-cornelius.weig@tngtech.com>
References: <20170125001906.13916-1-cornelius.weig@tngtech.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Wed, 25 Jan 2017 10:36:24 +0530
Message-ID: <CAFZEwPM9MWHQAie8KT+4LKdk-tHVJBCLP46HNcLJm5PHM=AWQg@mail.gmail.com>
Subject: Re: [PATCH] tag: add tag.createReflog option
To:     cornelius.weig@tngtech.com
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        novalis@novalis.org, Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Cornelius,

On Wed, Jan 25, 2017 at 5:49 AM,  <cornelius.weig@tngtech.com> wrote:
> From: Cornelius Weig <cornelius.weig@tngtech.com>
>
> Git does not create a history for tags, in contrast to common
> expectation to simply version everything. This can be changed by using
> the `--create-reflog` flag when creating the tag. However, a config
> option to enable this behavior by default is missing.
>
> This commit adds the configuration variable `tag.createReflog` which
> enables reflogs for new tags by default.
>
> Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>

You have also added the option --no-create-reflog so would it be worth
to mention it in the commit message?
> ---
>  Documentation/config.txt  |  5 +++++
>  Documentation/git-tag.txt |  8 +++++---
>  builtin/tag.c             |  6 +++++-
>  t/t7004-tag.sh            | 14 ++++++++++++++
>  4 files changed, 29 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index af2ae4c..9e5f6f6 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2945,6 +2945,11 @@ submodule.alternateErrorStrategy
>         as computed via `submodule.alternateLocation`. Possible values are
>         `ignore`, `info`, `die`. Default is `die`.
>
> +tag.createReflog::
> +       A boolean to specify whether newly created tags should have a reflog.
> +       If `--[no-]create-reflog` is specified on the command line, it takes
> +       precedence. Defaults to `false`.

This follows the convention, good! :)

>  tag.forceSignAnnotated::
>         A boolean to specify whether annotated tags created should be GPG signed.
>         If `--annotate` is specified on the command line, it takes
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 5055a96..f2ed370 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -13,7 +13,7 @@ SYNOPSIS
>         <tagname> [<commit> | <object>]
>  'git tag' -d <tagname>...
>  'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
> -       [--column[=<options>] | --no-column] [--create-reflog] [--sort=<key>]
> +       [--column[=<options>] | --no-column] [--[no-]create-reflog] [--sort=<key>]
>         [--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]
>  'git tag' -v <tagname>...
>
> @@ -149,8 +149,10 @@ This option is only applicable when listing tags without annotation lines.
>         all, 'whitespace' removes just leading/trailing whitespace lines and
>         'strip' removes both whitespace and commentary.
>
> ---create-reflog::
> -       Create a reflog for the tag.
> +--[no-]create-reflog::
> +       Force to create a reflog for the tag, or no reflog if `--no-create-reflog`
> +       is used. Unless the `tag.createReflog` config variable is set to true, no
> +       reflog is created by default. See linkgit:git-config[1].
>
>  <tagname>::
>         The name of the tag to create, delete, or describe.
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 73df728..1f13e4d 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -30,6 +30,7 @@ static const char * const git_tag_usage[] = {
>
>  static unsigned int colopts;
>  static int force_sign_annotate;
> +static int create_reflog;
>
>  static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, const char *format)
>  {
> @@ -165,6 +166,10 @@ static int git_tag_config(const char *var, const char *value, void *cb)
>                 force_sign_annotate = git_config_bool(var, value);
>                 return 0;
>         }
> +       if (!strcmp(var, "tag.createreflog")) {
> +               create_reflog = git_config_bool(var, value);
> +               return 0;
> +       }
>
>         if (starts_with(var, "column."))
>                 return git_column_config(var, value, "tag", &colopts);
> @@ -325,7 +330,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>         const char *object_ref, *tag;
>         struct create_tag_options opt;
>         char *cleanup_arg = NULL;
> -       int create_reflog = 0;
>         int annotate = 0, force = 0;
>         int cmdmode = 0, create_tag_object = 0;
>         const char *msgfile = NULL, *keyid = NULL;
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 1cfa8a2..67b39ec 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -90,6 +90,20 @@ test_expect_success '--create-reflog does not create reflog on failure' '
>         test_must_fail git reflog exists refs/tags/mytag
>  '
>
> +test_expect_success 'option tag.createreflog creates reflog by default' '
> +       test_when_finished "git tag -d tag_with_reflog" &&
> +       git config tag.createReflog true &&
> +       git tag tag_with_reflog &&
> +       git reflog exists refs/tags/tag_with_reflog
> +'
> +
> +test_expect_success 'option tag.createreflog overridden by command line' '
> +       test_when_finished "git tag -d tag_without_reflog" &&
> +       git config tag.createReflog true &&
> +       git tag --no-create-reflog tag_without_reflog &&
> +       test_must_fail git reflog exists refs/tags/tag_without_reflog
> +'
> +
>  test_expect_success 'listing all tags if one exists should succeed' '
>         git tag -l &&
>         git tag
> --
> 2.10.2
>

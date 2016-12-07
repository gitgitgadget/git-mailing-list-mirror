Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD4571FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 20:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932513AbcLGUJm (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 15:09:42 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36840 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932297AbcLGUJl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 15:09:41 -0500
Received: by mail-qk0-f175.google.com with SMTP id n21so426977213qka.3
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 12:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/lytbML5y9txBYqSKdzHncHRH5xJQB6iyK2SG4LedEI=;
        b=BN8x8inMmn0KLqSIkpf+NiwyJaECzzmG7u6J5qUgGIUODBSlhOmkiXg+C++rWIBmy4
         XOMHsJ8WfmU2pAMn7CkWZ/5hU4YClG62ijlSDMqaAYNvI7KG5TfBaNLXEdq77siMOcvs
         XMGYz5rzmKo+gWr9tyygDXg0sH8U3mZ49Ip5c0MfB/gfCpOPI/zh/2os3Tcs7bKh6AxY
         vG5bJpqmpKcEg7lOTg5jlVKAYARE66DxjeqmcTIJ5VJl+Q8nYzJmKUCw8Ocdon1aofF3
         oMO8re3yD3EeqpO/aJzRLiYSYUuI9nhUPuXsONUHJWT65WPJZ3P39wAKI+x+VrN/meV4
         xggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/lytbML5y9txBYqSKdzHncHRH5xJQB6iyK2SG4LedEI=;
        b=LuYlndSj0QCbcoBjuOd1NVCHOAlduqPUKu27rpi0aRm/MDJS+wK+qzdOZVU/IUwKj7
         1X/bKZxNr3d96Y8TsNk9k2+4ZCbxnraq/s5d34lvnpBADEmQ79P5e+Q+/ICi0FxFMt4g
         6PDj/YTAJ48oDnGNNWBFnG5oeF1WDqdBSHN1AA4My9g+Pgdf35/O7sbBIYK2+9Bb1zZV
         ldh3xZeiS9YJs2F3To4hJSfYV4ZMOljEkI8cd6QDdnNWTbIlwd2o+/LODuy1GkFwx8M7
         VRIAv+Hdbjxggy10RxB8p9AH/SBlAK9DAyz/nrvm76jWH1CRiXF4m6iSzl/gAIbJ00CE
         e1ng==
X-Gm-Message-State: AKaTC03aH4M+ejyde/hrGsJTAtcVH3Hwe6bgzOZ6Q3UO7p9FuXVc0+knk3itFsSc51aFiSkjMRNOIE1XpQZYcJ3W
X-Received: by 10.55.67.81 with SMTP id q78mr60950077qka.53.1481141380207;
 Wed, 07 Dec 2016 12:09:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Wed, 7 Dec 2016 12:09:39 -0800 (PST)
In-Reply-To: <20161207184248.6130-1-vi0oss@gmail.com>
References: <20161207184248.6130-1-vi0oss@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 7 Dec 2016 12:09:39 -0800
Message-ID: <CAGZ79kY3LR2KA69b4iDJb164EhJLb3JuVSRRcN0-4-kp-eryog@mail.gmail.com>
Subject: Re: [PATCH] submodule--helper: set alternateLocation for cloned submodules
To:     vi0oss@gmail.com
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2016 at 10:42 AM,  <vi0oss@gmail.com> wrote:
> From: Vitaly _Vi Shukela <vi0oss@gmail.com>

Thanks for contributing to Git!
(/me looks up if you have sent patches already as you
seem to know how to do that. :) unrelated side note: Maybe you want
to send a patch for the .mailmap file mapping your two email addresses
together, c.f. "git log -- .mailmap")

>
> Git v2.11 introduced "git clone --recursive --referece ...",
> but it didn't put the alternates for _nested_ submodules.

This message is targeted at people familiar with gits code base,
so we can be more specific. e.g.

    In 31224cbdc7 (clone: recursive and reference option triggers
    submodule alternates, 2016-08-17) a mechanism was added to
    have submodules referenced.  It did not address _nested_
    submodules, however.

>
> This patch makes all not just the root repository, but also
> all submodules (recursively) have submodule.alternateLocation
> and submodule.alternateErrorStrategy configured, making Git
> search for possible alternates for nested submodules as well.

Sounds great!

>
> As submodule's alternate target does not end in .git/objects
> (rather .git/modules/qqqqqq/objects), this alternate target
> path restriction for in add_possible_reference_from_superproject
> relates from "*.git/objects" to just */objects".

I wonder if this check is too weak and we actually have to check for
either .git/objects or modules/<name/possibly/having/slashes>/objects.
When writing the referenced commit I assumed we'd need a stronger check
to be safer and not add some random location as a possible alternate.

>
> New tests have been added to t7408-submodule-reference.

Thanks!

>
> Signed-off-by: Vitaly _Vi Shukela <vi0oss@gmail.com>
> ---
>  builtin/submodule--helper.c    | 24 ++++++++++++--
>  t/t7408-submodule-reference.sh | 73 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 95 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 4beeda5..93dae62 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -498,9 +498,9 @@ static int add_possible_reference_from_superproject(
>
>         /*
>          * If the alternate object store is another repository, try the
> -        * standard layout with .git/modules/<name>/objects
> +        * standard layout with .git/(modules/<name>)+/objects
>          */
> -       if (ends_with(alt->path, ".git/objects")) {
> +       if (ends_with(alt->path, "/objects")) {
>                 char *sm_alternate;
>                 struct strbuf sb = STRBUF_INIT;
>                 struct strbuf err = STRBUF_INIT;
> @@ -672,6 +672,26 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>                 die(_("could not get submodule directory for '%s'"), path);
>         git_config_set_in_file(p, "core.worktree",
>                                relative_path(path, sm_gitdir, &rel_path));
> +
> +       /* setup alternateLocation and alternateErrorStrategy in the cloned submodule if needed */
> +       {

Usually we do not use braces to further nest code, please remove this nesting.

> +               char *sm_alternate = NULL, *error_strategy = NULL;
> +
> +               git_config_get_string("submodule.alternateLocation", &sm_alternate);
> +               if (sm_alternate) {
> +                       git_config_set_in_file(p, "submodule.alternateLocation",
> +                                                  sm_alternate);
> +               }
> +               git_config_get_string("submodule.alternateErrorStrategy", &error_strategy);
> +               if (error_strategy) {
> +                       git_config_set_in_file(p, "submodule.alternateErrorStrategy",
> +                                                  error_strategy);
> +               }
> +
> +               free(sm_alternate);
> +               free(error_strategy);
> +       }
> +
>         strbuf_release(&sb);
>         strbuf_release(&rel_path);
>         free(sm_gitdir);
> diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
> index 1c1e289..7b64725 100755
> --- a/t/t7408-submodule-reference.sh
> +++ b/t/t7408-submodule-reference.sh
> @@ -125,4 +125,77 @@ test_expect_success 'ignoring missing submodule alternates passes clone and subm
>         )
>  '
>
> +test_expect_success 'preparing second superproject with a nested submodule' '
> +       test_create_repo supersuper &&
> +       (
> +               cd supersuper &&
> +               echo I am super super. >file &&

Usually we quote strings containing white space, e.g. echo "I am ..." >actual

> +               git add file &&
> +               git commit -m B-super-super-initial
> +               git submodule add "file://$base_dir/super" subwithsub &&
> +               git commit -m B-super-super-added &&
> +               git submodule update --init --recursive &&
> +               git repack -ad
> +       ) &&
> +       echo not cleaning supersuper

This echo is left in for debugging purposes?

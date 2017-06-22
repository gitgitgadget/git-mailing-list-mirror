Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 770621FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 19:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752075AbdFVTHL (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 15:07:11 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33257 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbdFVTHK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 15:07:10 -0400
Received: by mail-pg0-f66.google.com with SMTP id u62so3563070pgb.0
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 12:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EOtHvsJs0BoNTiE9adLQy6NFHmEOPnxpDCEiAJ0nolA=;
        b=p6e0t6Y8/8QUDOujyegsdttCLM4QvG2MljHPXBfFF8Zce0aQX/qOowxJomqSeUno3C
         TImpz1oraUZLeZ9uScnP0dnFL7M4bFzyJVSZZF5te+evGPwCt8w2yimFBEKZvujVBApX
         l22QcU1FXTqnoRqtR7B8dB1Ct5KjqOgzuSZ0aOls0k7YlpyXD2T60gixkIfy6tm1Mhks
         gZZXU6YHt1ZAcFiBlGOcb+QJ8yVpQN43fyibaC31C1hso+VoQJqgANmlkTwYbO/TErmw
         i8LfkRFC/BjFkq4SmVeW4De4y3Zji1Uch4tVKaVrawgvpu8XzHMmkFws5UNLcj0PJROQ
         H5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EOtHvsJs0BoNTiE9adLQy6NFHmEOPnxpDCEiAJ0nolA=;
        b=jjw4FV18TNQORkWjcC7B3cuzQnxoNTJ9wKxqFlTsOxCCTMhwJ/YC5kZX45M1kkDXJH
         EKaBQpeR76jk84YXTSEmyWrHfmqCYx1gejWQ6hF+0vIm4vO+30vqzGuRznVA4BFY+iED
         twbA/L5gIMppoBupPokf8Fp1khCKLC7XqnewaZ07hA384XSWkPjO2S0PFrTS/F1KiDrv
         fzyEbhfyDzbtOFsR4Y6nqAxK74neHEVrHinVwTv+sOxv0jqmrRr5lN8Z+S1kRQs3kU+R
         kc9V31q5GvXRVJRYndAE8QxtqjkmmNgncr0cFXNopXebOskpZ6zOjVJS/YkCA0lcVhqM
         vwqw==
X-Gm-Message-State: AKS2vOyM6W5MeCz31JphUW7fKDE4cJmnKJlqitstuO0ncLkt0/+fmhUw
        4WsMtcIKblpftg==
X-Received: by 10.84.216.28 with SMTP id m28mr4490669pli.275.1498158429614;
        Thu, 22 Jun 2017 12:07:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id 66sm5463794pfm.82.2017.06.22.12.07.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 12:07:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: Re: [PATCH/FINAL] Documentation/git-submodule: cleanup
References: <1498066891.32360.1.camel@gmail.com>
        <0102015ccdb6695c-7a8b1188-5bbe-43d1-8a8f-913c006c2474-000000@eu-west-1.amazonses.com>
Date:   Thu, 22 Jun 2017 12:07:08 -0700
In-Reply-To: <0102015ccdb6695c-7a8b1188-5bbe-43d1-8a8f-913c006c2474-000000@eu-west-1.amazonses.com>
        (Kaartic Sivaraam's message of "Thu, 22 Jun 2017 02:51:42 +0000")
Message-ID: <xmqqr2ybkfj7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> The "add" section for 'git-submodule' is redundant in
> its description and the short synopsis line. Fix it.
>
> Remove the redundant mentioning of the 'repository' argument
> being mandatory.
>
> The text is hard to read because of back-references, so remove
> those.
>
> Replace the word "humanish" by "canonical" as that conveys better
> what we do to guess the path.
>
> While at it, quote all occurrences of '.gitmodules' as that is an
> important file in the submodule context, also link to it on its
> first mention.
>
> Helped-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---

Stefan, do you want to add a Reviewed-by: to this one?  I've scanned
it over and overall it looked OK (iow I didn't find anything worth
complaining about).

Thanks.

>  Documentation/git-submodule.txt | 49 ++++++++++++++++++-----------------------
>  1 file changed, 21 insertions(+), 28 deletions(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 74bc6200d564c..6e07bade39a7c 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -63,14 +63,6 @@ add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--dep
>  	to the changeset to be committed next to the current
>  	project: the current project is termed the "superproject".
>  +
> -This requires at least one argument: <repository>. The optional
> -argument <path> is the relative location for the cloned submodule
> -to exist in the superproject. If <path> is not given, the
> -"humanish" part of the source repository is used ("repo" for
> -"/path/to/repo.git" and "foo" for "host.xz:foo/.git").
> -The <path> is also used as the submodule's logical name in its
> -configuration entries unless `--name` is used to specify a logical name.
> -+
>  <repository> is the URL of the new submodule's origin repository.
>  This may be either an absolute URL, or (if it begins with ./
>  or ../), the location relative to the superproject's default remote
> @@ -87,21 +79,22 @@ If the superproject doesn't have a default remote configured
>  the superproject is its own authoritative upstream and the current
>  working directory is used instead.
>  +
> -<path> is the relative location for the cloned submodule to
> -exist in the superproject. If <path> does not exist, then the
> -submodule is created by cloning from the named URL. If <path> does
> -exist and is already a valid Git repository, then this is added
> -to the changeset without cloning. This second form is provided
> -to ease creating a new submodule from scratch, and presumes
> -the user will later push the submodule to the given URL.
> +The optional argument <path> is the relative location for the cloned
> +submodule to exist in the superproject. If <path> is not given, the
> +canonical part of the source repository is used ("repo" for
> +"/path/to/repo.git" and "foo" for "host.xz:foo/.git"). If <path>
> +exists and is already a valid Git repository, then it is staged
> +for commit without cloning. The <path> is also used as the submodule's
> +logical name in its configuration entries unless `--name` is used
> +to specify a logical name.
>  +
> -In either case, the given URL is recorded into .gitmodules for
> -use by subsequent users cloning the superproject. If the URL is
> -given relative to the superproject's repository, the presumption
> -is the superproject and submodule repositories will be kept
> -together in the same relative location, and only the
> -superproject's URL needs to be provided: git-submodule will correctly
> -locate the submodule using the relative URL in .gitmodules.
> +The given URL is recorded into `.gitmodules` for use by subsequent users
> +cloning the superproject. If the URL is given relative to the
> +superproject's repository, the presumption is the superproject and
> +submodule repositories will be kept together in the same relative
> +location, and only the superproject's URL needs to be provided.
> +git-submodule will correctly locate the submodule using the relative
> +URL in `.gitmodules`.
>  
>  status [--cached] [--recursive] [--] [<path>...]::
>  	Show the status of the submodules. This will print the SHA-1 of the
> @@ -123,7 +116,7 @@ too (and can also report changes to a submodule's work tree).
>  init [--] [<path>...]::
>  	Initialize the submodules recorded in the index (which were
>  	added and committed elsewhere) by setting `submodule.$name.url`
> -	in .git/config. It uses the same setting from .gitmodules as
> +	in .git/config. It uses the same setting from `.gitmodules` as
>  	a template. If the URL is relative, it will be resolved using
>  	the default remote. If there is no default remote, the current
>  	repository will be assumed to be upstream.
> @@ -197,7 +190,7 @@ configuration variable:
>  	none;; the submodule is not updated.
>  
>  If the submodule is not yet initialized, and you just want to use the
> -setting as stored in .gitmodules, you can automatically initialize the
> +setting as stored in `.gitmodules`, you can automatically initialize the
>  submodule with the `--init` option.
>  
>  If `--recursive` is specified, this command will recurse into the
> @@ -220,7 +213,7 @@ foreach [--recursive] <command>::
>  	Evaluates an arbitrary shell command in each checked out submodule.
>  	The command has access to the variables $name, $path, $sha1 and
>  	$toplevel:
> -	$name is the name of the relevant submodule section in .gitmodules,
> +	$name is the name of the relevant submodule section in `.gitmodules`,
>  	$path is the name of the submodule directory relative to the
>  	superproject, $sha1 is the commit as recorded in the superproject,
>  	and $toplevel is the absolute path to the top-level of the superproject.
> @@ -242,7 +235,7 @@ git submodule foreach 'echo $path `git rev-parse HEAD`'
>  
>  sync [--recursive] [--] [<path>...]::
>  	Synchronizes submodules' remote URL configuration setting
> -	to the value specified in .gitmodules. It will only affect those
> +	to the value specified in `.gitmodules`. It will only affect those
>  	submodules which already have a URL entry in .git/config (that is the
>  	case when they are initialized or freshly added). This is useful when
>  	submodule URLs change upstream and you need to update your local
> @@ -413,7 +406,7 @@ for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
>  --[no-]recommend-shallow::
>  	This option is only valid for the update command.
>  	The initial clone of a submodule will use the recommended
> -	`submodule.<name>.shallow` as provided by the .gitmodules file
> +	`submodule.<name>.shallow` as provided by the `.gitmodules` file
>  	by default. To ignore the suggestions use `--no-recommend-shallow`.
>  
>  -j <n>::
> @@ -429,7 +422,7 @@ for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
>  
>  FILES
>  -----
> -When initializing submodules, a .gitmodules file in the top-level directory
> +When initializing submodules, a `.gitmodules` file in the top-level directory
>  of the containing repository is used to find the url of each submodule.
>  This file should be formatted in the same way as `$GIT_DIR/config`. The key
>  to each submodule url is "submodule.$name.url".  See linkgit:gitmodules[5]
>
> --
> https://github.com/git/git/pull/377

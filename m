Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20A6C4332F
	for <git@archiver.kernel.org>; Sat, 31 Dec 2022 02:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbiLaCHb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 21:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiLaCHa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 21:07:30 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B839140DE
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 18:07:29 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id jl4so17270290plb.8
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 18:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JOpqbbvSAJqlQoDNmHk9RvOHt2DD+POAwS3Uapbowyg=;
        b=bdyMMQ4NhHK6fSyBgqZhyLnWepzRlo/D4K4Zqns4iinoSx3yk2q0viWXaeI6kJgNKU
         3hMZIkZMCavbv5PwL13IxK6AWSyMihUtlHHFofpnSZmtuX/LUeknDVjFwf4ciBL/KqQW
         MTJ1Qzja52rE+Cv9ys1UpQCjiA0Y5wLfPaUpWurd8vJWIrSifYQLfW7I3TNRY6NhKn42
         lPPXcmCRCa1dehnzJvbd1karbRSri4I0adTs9c11c0sbxinAbgnoIWCK6jzzyOjd7t/F
         0BlSJc+9CGa7jPuXkWk2e4qu9FvsqJ/ygrvB2iOhoBTncC9JCzIWdRtFU1bfR6c/pzSm
         pscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JOpqbbvSAJqlQoDNmHk9RvOHt2DD+POAwS3Uapbowyg=;
        b=CloS0AhCGOBiXwVTUC6ULnt1q9OTQFegyRi3swfAA11lq76OYVRMbFpxsNUiur3fu6
         y5nuad6RUK7ja0E8ApUV03lIlOhi170YzEMoAINOKIZMc60BspN6GTqijre+OUNI2DS2
         cUCi9/GkTg4TTGetj9crOaeiG/m4Himc60Kwr3xMtuKew/QJss+RBwEZHiyGjJ0hXJrS
         DZocdVNyzKIYDL1cAwlv8/gzCkgNQu1Z4RDFbRmr50585InwffUotd8G3KqfAqfr0Jfd
         3APgc/rYkhVbgx/g1ur3r/ziHxTdy0WscTMEmG+79UMN+ueEgWIDKe4bEAoXEKnklYx2
         JYxA==
X-Gm-Message-State: AFqh2kovZ+5LSG8BDdJcZ2WMA4Mljr2WlVblbZ4uzbXNXP05YNBN9Y52
        nfKP/St4IrtcmqhBrV8rQoJDOm7DgQRtyA==
X-Google-Smtp-Source: AMrXdXtKwm/YmeKITkIBL0FOPw5zLFOPiWZ9j66nCgmDMe2q99mKxkpjN9Ftg5AFMeAtymPqcZz48w==
X-Received: by 2002:a17:902:7c90:b0:18f:6b2b:e88d with SMTP id y16-20020a1709027c9000b0018f6b2be88dmr35091569pll.36.1672452448534;
        Fri, 30 Dec 2022 18:07:28 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902650700b00189c536c72asm15601630plk.148.2022.12.30.18.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 18:07:27 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Samanta Navarro <ferivoz@riseup.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] maintenance: fix typos
References: <20221229125012.cp5tjdlnvxbln44l@localhost>
Date:   Sat, 31 Dec 2022 11:07:27 +0900
In-Reply-To: <20221229125012.cp5tjdlnvxbln44l@localhost> (Samanta Navarro's
        message of "Thu, 29 Dec 2022 12:50:12 +0000")
Message-ID: <xmqqpmc0iaw0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samanta Navarro <ferivoz@riseup.net> writes:

[continuing from <xmqqmt75lh2r.fsf@gitster.g>; this is second part]

Starting from here

> diff --git a/bloom.h b/bloom.h
> index adde6dfe21..83eb989d85 100644
> --- a/bloom.h
> +++ b/bloom.h
> @@ -15,7 +15,7 @@ struct bloom_filter_settings {
> -	 * number of bit positions tht cumulatively
> +	 * number of bit positions that cumulatively

... down to here ...

> diff --git a/contrib/coccinelle/unused.cocci b/contrib/coccinelle/unused.cocci
> index d84046f82e..142a5a1f02 100644
> --- a/contrib/coccinelle/unused.cocci
> +++ b/contrib/coccinelle/unused.cocci
> @@ -1,4 +1,4 @@
> -// This rule finds sequences of "unused" declerations and uses of a
> +// This rule finds sequences of "unused" declarations and uses of a

look all good.

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index dc95c34cc8..f414639f52 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -3330,7 +3330,7 @@ _git_worktree ()
>  		# Here we are not completing an --option, it's either the
>  		# path or a ref.
>  		case "$prev" in
> -		-b|-B)	# Complete refs for branch to be created/reseted.
> +		-b|-B)	# Complete refs for branch to be created/resetted.

Past Participle of verb "reset" is "reset", not "resetted", so

	... to be created or reset.

I think.

Restarting from here ...

> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 10c9c87839..8c4e2c0460 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -921,7 +921,7 @@ cmd_split () {
> -		die "fatal: you must provide exactly one revision, and optionnally a repository.  Got: '$*'"
> +		die "fatal: you must provide exactly one revision, and optionally a repository.  Got: '$*'"

... down to here ..

> diff --git a/fsmonitor.c b/fsmonitor.c
> index 08af00c738..d48e089c9b 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -215,7 +215,7 @@ static void fsmonitor_refresh_callback(struct index_s
> -		 * We need to remove the traling "/" from the path
> +		 * We need to remove the trailing "/" from the path

look all good.

> diff --git a/git-gui/lib/themed.tcl b/git-gui/lib/themed.tcl
> index f43d84e54f..68c999a9be 100644
> --- a/git-gui/lib/themed.tcl
> +++ b/git-gui/lib/themed.tcl
> @@ -4,7 +4,7 @@
> -	# Preffered way to set widget colors is using add_option.
> +	# Preferred way to set widget colors is using add_option.

Good, but patches to this part of the tree should be against

    https://github.com/prati0100/git-gui.git

not my tree (they are rooted differently).

Restarting again from here ...

> diff --git a/git-instaweb.sh b/git-instaweb.sh
> index c68f49454c..652d0b2dd3 100755
> --- a/git-instaweb.sh
> +++ b/git-instaweb.sh
> @@ -612,7 +612,7 @@ python_conf() {
> -	# This asumes that python is in user's $PATH
> +	# This assumes that python is in user's $PATH

... down to here ...

> diff --git a/gpg-interface.c b/gpg-interface.c
> index f877a1ea56..89c2ec08be 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -379,7 +379,7 @@ static void parse_ssh_output(struct signature_check *sigc)
> -	 * string.  By finding the last occurence of " with ", we can
> +	 * string.  By finding the last occurrence of " with ", we can

all look good.  I'd stop here for now.

Thanks.



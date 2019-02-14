Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4A3C1F453
	for <e@80x24.org>; Thu, 14 Feb 2019 20:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389639AbfBNUoS (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 15:44:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50608 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfBNUoS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 15:44:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id x7so7737772wmj.0
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 12:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=v3cxzmsC6mtgR85WsovMOFIpQZS98lqHbHwRV6//C2E=;
        b=j+hQF+9SvXU+iXw3OwNIUiX19FQq6bWuEAbnuPDQXvdu8won6+njfoczMKwkJiy9vG
         JgtpbkhecB23mnZLdZjCR30jFXRQILXlNnqGfYffR3LuZOXxofLk3sKGYl8CMD2WVkB9
         RXlJ75rWb/LLNX40lO7iazWm7S4Ilb2TuXgWqrwZeAwrY1B2psHvNnQ6YRkP9brTO4b2
         GTwQ/F4ZakjgOgEIwEgv65uXwG3sl+fEOO2BBdtBuMNj2gf3OeUH1c7epqLdIGtv5teO
         2S/10CT/1hib20sbGDTlD+pmXomL80yzPMNy2J7VcPWeAV2zWWecFCnUQ7uZ3G8Lxev1
         hVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=v3cxzmsC6mtgR85WsovMOFIpQZS98lqHbHwRV6//C2E=;
        b=no2NH5klNLJARS7Pq1iYBJxexO6JEcQYl+w/lWNhbLyug8LF6MEyvfPEMBtUhQY2Sd
         kQj4qEKXkJrqzVrN94TK4bFfYjOJqt5HU6dINv88BSf15/uqqSBAM8bFae/6UZhxJxgV
         aWQm/AiJv/GwIgKkLrXwYuT6Rh4RYkSLolLsSKLVeXb8DpxNY/s2DJE6ON2BGMcXV/dP
         P2v2yVFtr1Me0NAPxSnqsfMW1iS8KJPtqEy7A8z3PEFDq9vr7OuxrU1ZCJkF3APqw6Bm
         T+il6c1owyjeRNfBiMMvJihWMxNx0bgXBcNz8ZY2rLOsld7dAWDy+wWyRkI1uFm0dRsf
         UvVA==
X-Gm-Message-State: AHQUAuZCIoPWv1zUh+TfWtL9Qk1LBmBD0Q1kaXwHzl7CGS7xBcMe9Gy+
        Zg2zDKoliXsVAlyG3fyex1s=
X-Google-Smtp-Source: AHgI3Ibsxp85g24M/f896j0fqs8Zm5tryOtbWyrWC1F7KcdXGpj+TsvqD6siTGDmFTMa8ULt6RNSVQ==
X-Received: by 2002:a1c:2457:: with SMTP id k84mr3983104wmk.139.1550177055730;
        Thu, 14 Feb 2019 12:44:15 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z1sm3110157wrw.28.2019.02.14.12.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 12:44:13 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
Cc:     <git@vger.kernel.org>, <nathan.berbezier@etu.univ-lyon1.fr>,
        <pablo.chabanne@etu.univ-lyon1.fr>, <matthieu.moy@univ-lyon1.fr>
Subject: Re: [PATCH] doc: format pathnames and URLs as monospace
References: <20190214163043.7103-1-corentin.bompard@etu.univ-lyon1.fr>
Date:   Thu, 14 Feb 2019 12:44:13 -0800
In-Reply-To: <20190214163043.7103-1-corentin.bompard@etu.univ-lyon1.fr>
        (Corentin BOMPARD's message of "Thu, 14 Feb 2019 17:30:43 +0100")
Message-ID: <xmqq4l9685ia.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr> writes:

> diff --git a/Documentation/config/checkout.txt b/Documentation/config/checkout.txt
> index c4118fa19..8ba92f274 100644
> --- a/Documentation/config/checkout.txt
> +++ b/Documentation/config/checkout.txt
> @@ -1,7 +1,7 @@
>  checkout.defaultRemote::
>  	When you run 'git checkout <something>' and only have one
>  	remote, it may implicitly fall back on checking out and
> -	tracking e.g. 'origin/<something>'. This stops working as soon
> +	tracking e.g. `origin/<something>`. This stops working as soon

Are you doing only pathnames and URLs, or are you also doing refnames?

I am not sure if "this is a pathname, or a URL or a refname, so it
must be typeset with monospace" is the direction we'd want to go in
in the first place.  One rule we tried to follow (but with minor
inconsistencies everywhere, apparently we are not doing a very good
job at) is "this is a string the user would literally type or see
when following this description, so it must be typeset with
monospace".

From that point of view, we'd want the `git checkout <something>` we
see in the introductory sentence of this paragraph also typeset in
mono.  In order to match (i.e. to make it clear that the <something>
part came from what the user typed), the change in this hunk your
patch makes does make sense.

> diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
> index f98b7c6ed..6643bc39f 100644
> --- a/Documentation/git-cvsserver.txt
> +++ b/Documentation/git-cvsserver.txt
> @@ -140,7 +140,7 @@ CVS_SERVER directly in CVSROOT like
>  ------
>  cvs -d ":ext;CVS_SERVER=git cvsserver:user@server/path/repo.git" co <HEAD_name>
>  ------
> -This has the advantage that it will be saved in your 'CVS/Root' files and
> +This has the advantage that it will be saved in your `CVS/Root` files and
>  you don't need to worry about always setting the correct environment
>  variable.  SSH users restricted to 'git-shell' don't need to override the default
>  with CVS_SERVER (and shouldn't) as 'git-shell' understands `cvs` to mean

I am using this hunk as just an example, but "this is what the user
literally sees or types" point-of-view, `CVS/Root` and `CVS_SERVER`
in the hunk fall into the same category.  They are both literals in
the sense that you cannot say "I do not like the words Root or
SERVER, so in my CVS repository I am using CVS/Leaf and CVS_HELPER
instead".

> @@ -179,7 +179,7 @@ allowing access over SSH.
>  ------
>  --
>  3. If you didn't specify the CVSROOT/CVS_SERVER directly in the checkout command,
> -   automatically saving it in your 'CVS/Root' files, then you need to set them
> +   automatically saving it in your `CVS/Root` files, then you need to set them
>     explicitly in your environment.  CVSROOT should be set as per normal, but the
>     directory should point at the appropriate Git repo.  As above, for SSH clients
>     _not_ restricted to 'git-shell', CVS_SERVER should be set to 'git-cvsserver'.

Even if you are doing only pathnames and URLs, `git-shell` and
`git-cvsserver` would be candidates to be in monospace, as they are
names in $GIT_EXEC_PATH/.

> diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
> index 7a2375a55..bbc984235 100644
> --- a/Documentation/technical/pack-protocol.txt
> +++ b/Documentation/technical/pack-protocol.txt
> @@ -107,7 +107,7 @@ Initiating the upload-pack or receive-pack processes over SSH is
>  executing the binary on the server via SSH remote execution.
>  It is basically equivalent to running this:
>  
> -   $ ssh git.example.com "git-upload-pack '/project.git'"
> +   $ ssh git.example.com "git-upload-pack `/project.git`"
>  
>  For a server to support Git pushing and pulling for a given user over
>  SSH, that user needs to be able to execute one or both of those

I agree with Eric's comment.  If the user types `/project.git`, it
would give a funny result ;-).

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72F2E20D0A
	for <e@80x24.org>; Tue, 30 May 2017 04:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750946AbdE3EKO (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 00:10:14 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34709 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbdE3EKN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 00:10:13 -0400
Received: by mail-pf0-f195.google.com with SMTP id w69so15002226pfk.1
        for <git@vger.kernel.org>; Mon, 29 May 2017 21:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/25UrcUxIJCoUdlDjQYYIURoFEo/cWg9g1uXx6bOqdU=;
        b=RH0jTqwscULKHlrvALFh0WW9qVTk3PVdIz6R82h8DQLfS81yH69/pIMuk/Bw51tqHX
         SWNu26Wgev4fjx7E4Unke/HwtcCwlYkOIGvTfZY0tGk+yenazA01kSwbIzQL/XSnr5sP
         ixr8uRUgNDTi1L4TiD0qDdNOC1CPNfRXFKJv1hAErwtYrB/D/hTcngevCeXz15s2Nt7b
         b3z3msQwvRiiORnY2QcJ/vXV6pUmBlU0+lDOch3EBhEifdkIi8u4zJOJ5T8UeRKL2kwR
         7pHAHQtuXK2dUsH7UVTRIvo14Nv4oBGqj+HxMrSNaSfBe86U9FkU28VO/UeHEEYaIwRW
         n4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/25UrcUxIJCoUdlDjQYYIURoFEo/cWg9g1uXx6bOqdU=;
        b=Ll7NveuvFwOLq+F7DPLKS2AqRTWhG2Efy0l5ld7Dpn0vec+AZv4DVHdx45FuVjAz9u
         8BU/5Lsqg8NL8e86BQqdEUzcL35mJ9mNIOG5/fRPrtPy6sTfPnEmLGetwPeJd+5kyuGL
         26erRlGFMqIoCfmG3mlkbh2QnF4phbW8ZijeQzQEWIpCXgruauor1S0F15wyVXVK5aPU
         mTyuQVrOKKndn0mchdtBshSjkAyOoLS1beEbPL896Lm47DVXQXET2fY6LXT0HhzmSq35
         aee0mp2sUr2Gmywe93xXgPO9GcYX4ycPxWa/zF5aw/fHzSuWBjMnzAbKyr33OqYuz3GL
         mUcQ==
X-Gm-Message-State: AODbwcC76f2NWoXYLPZOwZCa8dIcV3ujcfsBQ1d4BVku7Yd6F/r9P0cE
        P2EmCmyiFerOyWUUGfg=
X-Received: by 10.99.109.141 with SMTP id i135mr22904730pgc.33.1496117412837;
        Mon, 29 May 2017 21:10:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f830:fc5f:a16b:f475])
        by smtp.gmail.com with ESMTPSA id t66sm18484994pfe.134.2017.05.29.21.10.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 May 2017 21:10:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: Improve description for rev-parse --short
References: <20170528143322.8580-1-asheiduk@gmail.com>
Date:   Tue, 30 May 2017 13:10:11 +0900
In-Reply-To: <20170528143322.8580-1-asheiduk@gmail.com> (Andreas Heiduk's
        message of "Sun, 28 May 2017 16:33:22 +0200")
Message-ID: <xmqq1sr7dly4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Heiduk <asheiduk@gmail.com> writes:

> First: `git rev-parse --short` without a number does use a fixed default but
> `core.abbrev` which in turn uses `find_unique_abbrev` internally.

... hence the value gives mere minumum.  I like your updated text that
clarifies this point.

> Second: `--short` implies `--verify` since the beginning (d50125085a), so
> it cannot be used for bulk-shortening ids unfortunately.

The fact you have to say "Nth:" hints that this is better done as
two patch series.  Then you can avoid saying a vague "Improve" on
the subject, that leaves the "git shortlog" readers wondering what
exactly you improved.

> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
> ---
>  Documentation/config.txt        | 1 +
>  Documentation/git-rev-parse.txt | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index e0b9fd0bc..158cb588b 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -862,6 +862,7 @@ core.abbrev::
>  	computed based on the approximate number of packed objects
>  	in your repository, which hopefully is enough for
>  	abbreviated object names to stay unique for some time.
> +	The minimum length is 4.
>  
>  add.ignoreErrors::
>  add.ignore-errors (deprecated)::
> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
> index c40c47044..7a7421c8e 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -140,7 +140,9 @@ can be used.
>  --short=number::
>  	Instead of outputting the full SHA-1 values of object names try to
>  	abbreviate them to a shorter unique name. When no length is specified
> -	7 is used. The minimum length is 4.
> +	the effective value of the configuration variable `core.abbrev` (see
> +	linkgit:git-config[1]) is used.  The minimum length is 4.  The length
> +	may be exceeded to ensure unique object names.	Implies `--verify`.

"Implies --verify" is less important than the fact that multiple
object names cannot be given from the end-users' (and readers')
point of view, no?  The sentence in the pre-context still hints
(incorrectly) that we might take multiple names---that would want to
be corrected, no?

Let me try.

    --short[=length]::
	Take a single object name, and output a prefix of the object
	name whose length is at least the specified length and
	sufficient to ensure uniqueness of the name.  The minimum
	length is 4.  When no length is given, the effective value
	of the `core.abbrev` configuration variable is used.

Thanks.

>  
>  --symbolic::
>  	Usually the object names are output in SHA-1 form (with

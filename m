Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74BE71F51C
	for <e@80x24.org>; Wed, 23 May 2018 01:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753840AbeEWBsU (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 21:48:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52793 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753618AbeEWBsT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 21:48:19 -0400
Received: by mail-wm0-f68.google.com with SMTP id w194-v6so4523774wmf.2
        for <git@vger.kernel.org>; Tue, 22 May 2018 18:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6UF4oLfTV6eP2Jidinqu+DtvxVoq4nGyfJrY/zwerfg=;
        b=PzIDfjtjyZXpvNLA4wMJuusG/tmYs3EN9JxAliWFf/xh3AiO6Oq1KgRkaEkGhEKCTW
         iFEKZmgU9Dw9PYGGXWtPIxtVu6bhMMsttymCCWd8QcFhC03P2UC3kEGJYXBk0zCMTt7F
         7Myn35B6QTwBqy8f1ajD17ArkK0P9uzW9gBYsPcq/mHHpsj73FyqMhyttQVbDLmqvhR+
         e0J8Y224x1h0k+mXnBWzpge//fIDA00MIG9kxM1VtanzCq1J6sT7iSXttOupmcw3ojAV
         OActgGVk+3V5uQ4fej0Pcuq5NQyMUXduzcJY+Z5bGg2FjXe+Kt01aysO0uBjhFaG1X2z
         N1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6UF4oLfTV6eP2Jidinqu+DtvxVoq4nGyfJrY/zwerfg=;
        b=HVj140vE/Zu5l3dh8Db8A8LqVG7HaGewZsOEZVY8+tgbz8KsMo8jrN97oBo3HA3fDA
         pdGVJ0h5GmQOTfMO0fCL2dYsVC+0wRZgi81RfqqeDjBFXUoh8TIHNM9F/LchSK+zcBXC
         q4ikZ3QEPe7voY0J89y9/luMkdCkwP/E7E2koy0TY2SOJ1gYAEwTMRSkuHBTeJBKg7n0
         rDgzuwK/vL3P4M3DVf278gOhfQmob2OAqoCEQAbpB0Vipq+6urdMILz3+z3lEoM9BRyw
         60AsgoSouuj1On/QWMIa/lml1lEKZV+6sINMLIdhonw4KHCLR8cxyaPa/E9gHd5dn7JN
         rK4g==
X-Gm-Message-State: ALKqPwfWRwWFib71h4q3b2SYKC6fFbX0fOBoWFb48TpsOT0GKZVh4dUC
        pZyU+2vW1sVyU6sP0BHKhjc=
X-Google-Smtp-Source: AB8JxZofhngtJkoJOALQf2dkh89/UcYFzIM3O+nDuiziPstUtAKIsEyiDYxdBTWPeBkEUwCNVM/0FQ==
X-Received: by 2002:a1c:c355:: with SMTP id t82-v6mr2676497wmf.129.1527040098130;
        Tue, 22 May 2018 18:48:18 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 72-v6sm868413wrb.22.2018.05.22.18.48.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 May 2018 18:48:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] Doc: Mention core.excludesFile in "man git-clean"
References: <alpine.LFD.2.21.1805220345150.749@localhost.localdomain>
Date:   Wed, 23 May 2018 10:48:15 +0900
In-Reply-To: <alpine.LFD.2.21.1805220345150.749@localhost.localdomain> (Robert
        P. J. Day's message of "Tue, 22 May 2018 03:48:13 -0400 (EDT)")
Message-ID: <xmqqsh6jw3a8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

> Add a reference to the configuration setting "core.excludesFile" to
> the man page for git-clean.
>
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>
> ---

I understand that you are trying to reduce the source of the
confusion you felt, which comes from mentioning only per-directory
.gitignore and per-repository info/exclude, but I am not sure if the
proposed solution is a good one that learned from our past mistakes.

Wouldn't it make more sense to _avoid_ appearing as if we are giving
a complete list and refer those who want a single authoritative list
to the source?  For example

	In addition to those found in standard places for exclude
	patterns such as `.gitignore` (cf. linkgit:gitignore[5]),
	also consider these patterns...

After all, having an incomplete list and not hinting that it is
incomplete is what made you react to the current description.  It is
unlikely that we stop treating `.gitignore` as one of the standard
places, so phrasing like above will have a lot smaller chance to go
stale, even accounting for the possibility that we will grow Git
over time and the standard parttern sources may be updated in the
future.

>
> diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
> index 03056dad0..449cbc2af 100644
> --- a/Documentation/git-clean.txt
> +++ b/Documentation/git-clean.txt
> @@ -55,13 +55,15 @@ OPTIONS
>
>  -e <pattern>::
>  --exclude=<pattern>::
> -	In addition to those found in .gitignore (per directory) and
> -	$GIT_DIR/info/exclude, also consider these patterns to be in the
> -	set of the ignore rules in effect.
> +	In addition to patterns found in any of .gitignore (per directory),
> +	$GIT_DIR/info/exclude and the exclude file specified by the
> +	configuration variable core.excludesFile, also consider these
> +	patterns to be in the set of the ignore rules in effect.
>
>  -x::
>  	Don't use the standard ignore rules read from .gitignore (per
> -	directory) and $GIT_DIR/info/exclude, but do still use the ignore
> +	directory), $GIT_DIR/info/exclude and the exclude file specified
> +	by core.excludesFile, but do still use the ignore
>  	rules given with `-e` options.  This allows removing all untracked
>  	files, including build products.  This can be used (possibly in
>  	conjunction with 'git reset') to create a pristine

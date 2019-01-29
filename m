Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA7EF1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 17:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfA2Run (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 12:50:43 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37812 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfA2Run (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 12:50:43 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so18767145wmd.2
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 09:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=C+1abDJQ++FUYFs2BAEeeT8rRmPRi9zXs9acSKHJLSU=;
        b=WdfUBWBZmuSul+AAaPLq7lFQC3sHDCU0ytOb+uj+oaTi0WBha466pQ/HraL5FBNbsD
         SCbCLfQnGYeq6OcUomQyvIBwMgclexdkR4FDkrsTSCdQT0ctocQFLKm94BJsvgq/+92Q
         aAiJIICUgDQCrMuAc+5471ibNuIFgT8V2vwAaohLx7IkzkLDDVa34pyg1AYYX/DIzzkX
         2JQBoiOW72gW8YqF0UEgPf3/XMC1Ler41DUQ+VCLoFr+mNjMlQJF2rcmXU4EI85sHfZD
         2UbmJEflvK83Rcd06KRdNfr5/29gS0AyfBXgJ0T2xWUNBBYnhk+HzKn7+3hiLOQgk6rw
         AOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=C+1abDJQ++FUYFs2BAEeeT8rRmPRi9zXs9acSKHJLSU=;
        b=LHCatogIzAQDCux36jOPiMMMrR5hlg8rzYScA6DlaKNxu7URfpSN/NpZff3ZnjTNcg
         959Zr1s5QK2Ywzfbe1yjF3DyiMxUnsJFjyVQxFv40dA9spbp08gHNyQssfhCzdnloZFo
         2VRrn7F4MqWMuU4eT5CsJvqCu0JKsSBPGWHeLkX9LYriwKEgmopGHjGz5qGChdCyKHS7
         bVQ8tlqFdkq5oAoeppX/5bXES/Fsgm9urnS5rSvuLSxALdWX50KkOYS4Va8eUcYU77HY
         LT407XzgXijx3xNfT1OfSLmzKfNc8j6MPTkrJMIoFqJrpC8TK8LvfxAxE45Az8Ryxa65
         y2gw==
X-Gm-Message-State: AJcUukedmOy59mNcvxATb2shlkGQCjDojReIvg+Jd1KVEgE2prC/8Mqn
        PqKkNUZ+s+fom8OmCmD6hMA=
X-Google-Smtp-Source: AHgI3IZyD0NHiGlE7Cbwc7XqoSFETy9HqK/AE9j/SRXBQy9jZ4nkuoIJ9OXyCDMdvfx3pAT+zjcRUw==
X-Received: by 2002:a1c:c282:: with SMTP id s124mr11473926wmf.105.1548784241073;
        Tue, 29 Jan 2019 09:50:41 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y12sm1498368wmi.7.2019.01.29.09.50.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 09:50:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] fixup! Merge branch 'js/vsts-ci' into pu
References: <pull.113.git.gitgitgadget@gmail.com>
        <946d5637f10d25ca7addbe376ead053be569c5e8.1548759361.git.gitgitgadget@gmail.com>
Date:   Tue, 29 Jan 2019 09:50:39 -0800
In-Reply-To: <946d5637f10d25ca7addbe376ead053be569c5e8.1548759361.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 29 Jan 2019
        02:56:02 -0800 (PST)")
Message-ID: <xmqqimy78ia8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The js/vsts-ci and sg/travis-specific-cc branches do not interact so
> well... While Travis has the Homebrew package gcc@8 installed in their
> Xcode 10.1 images, Azure Pipelines' agents do not.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  ci/lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks; will use as a merge-fix/ recipe (assuming that sg/travis
would graduate before vsts-ci).

> diff --git a/ci/lib.sh b/ci/lib.sh
> index 276b99693d..16f4ecbc67 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -123,7 +123,7 @@ then
>  		echo "$SYSTEM_TASKDEFINITIONSURI$SYSTEM_TEAMPROJECT/_build/results?buildId=$1"
>  	}
>  
> -	BREW_INSTALL_PACKAGES=
> +	BREW_INSTALL_PACKAGES=gcc@8
>  	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
>  	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
>  	export MAKEFLAGS="--jobs=10"

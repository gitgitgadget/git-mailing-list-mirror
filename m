Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9EA61F5A2
	for <e@80x24.org>; Mon, 18 Nov 2019 22:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfKRWSO (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 17:18:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37193 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfKRWSO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 17:18:14 -0500
Received: by mail-wm1-f65.google.com with SMTP id b17so1135644wmj.2
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 14:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xXa+1tljvTjmUHG8hHmvpcVcceHnRXudTvTa1lRf4Tw=;
        b=uAQJ2dYBImPNPqbO7gUFTN5dB4fUjYv5AGishRAUbNvA1NPUvYRHZxIY6mrPZQhbaK
         mc4iTIUfaAZBivF+UQKqNWxXKvLac9Fwgcx1Ng0I0UdmplVsva/fPDlu/UpR92xmWPxE
         oUXXSVZTNeyRx5zMeDs8K+UKwefD5A2mI7PwWS4XxTcwk7VWgpsvp7PMEFZ5iyUI6gw1
         dQOzjp/pJ741d0oATsnLUfqKz7Qcv6oVuIA0u0P/bbUXKgx2sWxFHdH7DFHBFrq8CA2J
         R1TQho82SgZ83Pz0cuDA41WaPCLuS5NVR8g9ANdglJ658tVYSs0jCzaCzLLeG3tMlAtp
         i8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xXa+1tljvTjmUHG8hHmvpcVcceHnRXudTvTa1lRf4Tw=;
        b=uSqzXYp/u7gplleXUJexcelDlGAh2CfuFnNuoRfIfZfANhi6LvxtY+oYfZp7jEpzpe
         x8WwvYFWSNu0UTh+ZXpqytzeeYGBRPdJ5QIoW/Vb07SmNBVOubYmjN6snF0rdt8tWgQa
         aM+YqK0sEAtvi4jUuAK5ltVDhH+0+lSIUwZ7YpUpVjnHfxPBNJpRrZYE/YACl7Ieq19B
         gMUHeDP1CWcXLA53a0aNpdGGR7r1nCWWkCcQuND8kbHGowcyJBCACExWNhRPHKo4VR/E
         Bm5g09w1EA7USQ5fzgoO6i/glc2/OhnU2+QGqUEXxSBwB/QXOmnqRu7Flwqzjq+sy7/o
         /l2Q==
X-Gm-Message-State: APjAAAXLsEK8DlR0buqymu4ZNAJthMj0zdK/YxhvlJltm45BMzGaUnxG
        5g9tUdt+bIAvAF6gYLHpBEo=
X-Google-Smtp-Source: APXvYqzp1ohDPYyi3dUX4+3r60MVr9Gm0/xPF/A8g8zuAhKV5KUaDLbQZdqZj2WCFZ+BlKffNCwtRw==
X-Received: by 2002:a05:600c:218e:: with SMTP id e14mr1706056wme.22.1574115490944;
        Mon, 18 Nov 2019 14:18:10 -0800 (PST)
Received: from szeder.dev (x4d0c3ed7.dyn.telefonica.de. [77.12.62.215])
        by smtp.gmail.com with ESMTPSA id g184sm919886wma.8.2019.11.18.14.18.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 14:18:10 -0800 (PST)
Date:   Mon, 18 Nov 2019 23:18:04 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/1] ci(osx): use new location of the `perforce` cask
Message-ID: <20191118221804.GA23183@szeder.dev>
References: <pull.400.v2.git.1571316454.gitgitgadget@gmail.com>
 <pull.400.v3.git.1571789978.gitgitgadget@gmail.com>
 <9d80e845bf923c4543c49f9947aacb10c59ff6ce.1571789978.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9d80e845bf923c4543c49f9947aacb10c59ff6ce.1571789978.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 23, 2019 at 12:19:38AM +0000, Johannes Schindelin via GitGitGadget wrote:
> CI servers are typically fresh virtual machines, but not always. To
> accommodate for that, let's try harder if `brew cask install perforce`
> fails, by specifically pulling the latest `master` of the
> `homebrew-cask` repository.

> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 85a9d6b15c..ce149ed39c 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -40,6 +40,11 @@ osx-clang|osx-gcc)
>  	test -z "$BREW_INSTALL_PACKAGES" ||
>  	brew install $BREW_INSTALL_PACKAGES
>  	brew link --force gettext
> +	brew cask install perforce || {
> +		# Update the definitions and try again
> +		git -C "$(brew --repository)"/Library/Taps/homebrew/homebrew-cask pull &&

In the build of v2.24.0 this 'git pull' printed just short of 600
lines worth of diffstat.  Two weeks went by since then, and in today's
'pu' build that diffstat is already over 1000 lines long.

Perhaps we could use --quiet here, though that would suppress the
transfer progress as well.

> +		brew cask install perforce
> +	} ||
>  	brew install caskroom/cask/perforce
>  	case "$jobname" in
>  	osx-gcc)
> -- 
> gitgitgadget

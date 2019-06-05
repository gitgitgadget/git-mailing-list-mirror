Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 289C11F462
	for <e@80x24.org>; Wed,  5 Jun 2019 12:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfFEMI7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 08:08:59 -0400
Received: from mout.gmx.net ([212.227.15.18]:38259 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfFEMI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 08:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559736537;
        bh=uALAewAOufdcbS0zb+smgg7CtF+ehBwYfBj4Rn0SrxM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BVsQ0R96WKnQl8nS++reAphkrnKzcMRiyZ5XLnprVJZptFCoDbu3rtVpHZX+bOXRF
         BIY6q1KZOjghsrxGA4x0RivGbGZAEotJOrUyoOOwUb8tKJTmnRjMsvuS0s5ygbt8m5
         hQdziLe9uv43lHid13BmN2VuHNs+G7AzLWnG4n8s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MLunc-1hVBrh0Czc-007p6k; Wed, 05
 Jun 2019 14:08:57 +0200
Date:   Wed, 5 Jun 2019 14:08:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Wen Bei Li <wenbei123@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] mergetools: add support for VS Code
In-Reply-To: <20190604232134.14748-1-wenbei123@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906051406550.1775@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1906041542050.1775@tvgsbejvaqbjf.bet> <20190604232134.14748-1-wenbei123@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bucci8XCuHWvnnnm1XwztpqblbqRmlgTuQHq/0CSk6wrqjm/mJ3
 23Q1NiYfChwny2t04AysMGXrNwxYP2YkufD2X3j9eTlN1YMTA58ITOwSCptmC20MrnTcB08
 stAxUawmdsYP342h3WPaicS0DjqQ8k5bQ7E7IvQ95l4AZWJwjY4EauLLuHzgj+s+aqa4Elj
 MOk1JivYjH0p0FPuXlYwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lqnlzCnehu4=:yqqtU9YIPGZ+BA6FQrBoEG
 qE18gLmL5vk6LO+kxbU0kSe/iEwCjeyp6hqvJtDXOu2UpKtWScsnc74zSFNO3Lw4h9OwAtfP5
 LMg8lU81ynSgH7EvvRqzhs8gys6bFfN6CTRi7LU0OTLt8BzRIY/QW29M6rAiDtMFjOsCfLlTK
 KlqWpdXHPG9R9YxWf+El4j1JgMigRJ89gq1aUpvygKWAqaLTp0HgecrU4yaLeII7YQ1h0r08l
 WOdsMGg/CMlw3priW8b1fBo5inMHdACXKkdXSPJHgilDBz5hbfObUFUJvzYQ2G76Ku2uui4jq
 jai/ootQl2jiliNGvMdZwnSYC3pPXfUN0QenmiSi5B4zD0h6fGMqH7sGxL1j36d3UyBykNBXC
 50T8YowBO8FELFlqM5JBY5DZ2MAuoKNVxXhX2eCeayoxIym0+C+hpOD35MtWLLAmFRuUcBOJm
 wWLLcld0nInHoEzxvpMTa9wZ9bj5inM5Y5ySj/3bUlm7yqy6UrTSB+UR3a4aMIcqajptBjJYZ
 mFfPM/HQPBAfIA947us7Cm+v2MPFQgg3mevlVBftFoDW5+0MLfvm/1XCdGsi2YIOn2es/UkNZ
 Cow/mwEAct7j0LxM2fZXTXEwOZ5HUCxGnhgp17m2c3O0AZBXd8CfqIIZaTZIM6G6OKTavoznQ
 YnV9qR3BJM0o9g8RZepsu7WwMcb/y1LqNn8hwUJIV171FDOwLhoQd1UVWb4ta75OoNQtkpywG
 hsELt/R92o9zhDOBBibmJCtHFkspZz0eO2Z9areyJgLmEA+pZkCVMOuBuQLhiFln0H9PGN/uP
 ozeQa3xUGU4/oiZCyiNMV6pApmN/UDAFO+coNZvaoBaGgWEWoNUXofLBxuw9Kdh/0WahpvnJC
 zzuNO3JV4cwF6ojY2CpuBanh3G9ypP4SD4sIdeLMtz+CZU3FMnEFB5JiymjvhVO04j6bT6ST5
 UHKqENEG9TyhQ35eXfueOXAkKAkJatZywNnKHzrk/dD9IOY2zK2Q7oydwxrlfryLUPSLM4VC+
 +z/CuYRUmhrbXzZQO6iIppw=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Wen Bei Li,

On Tue, 4 Jun 2019, Wen Bei Li wrote:

> Teach difftool and mergetool about VS Code and VS Code Insiders
>
> Signed-off-by: Wen Bei Li <wenbei123@gmail.com>
> ---
> Hello Johannes, thank you for reviewing my patch. It's the first time
> I've done this via email.

Heh, I hear you. It makes me happy that we still can get contributions
despite the slight hurdle to do it by email.

> I've added `code-insiders` as you suggested, but I wasn't sure if I
> should send it as a v2.

Well, since this is the second revision of your patch, it *is* a v2,
whether you mark it as such or not ;-)

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion=
/git-completion.bash
> index 3eefbabdb1..6eaa0df5b2 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1502,7 +1502,7 @@ _git_diff ()
>
>  __git_mergetools_common=3D"diffuse diffmerge ecmerge emerge kdiff3 meld=
 opendiff
>  			tkdiff vimdiff gvimdiff xxdiff araxis p4merge bc
> -			codecompare smerge
> +			codecompare smerge code code-insiders
>  "
>
>  _git_difftool ()
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 204a5acd66..44f1967c84 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -283,7 +283,7 @@ list_merge_tool_candidates () {
>  		fi
>  		tools=3D"$tools gvimdiff diffuse diffmerge ecmerge"
>  		tools=3D"$tools p4merge araxis bc codecompare"
> -		tools=3D"$tools smerge"
> +		tools=3D"$tools smerge code code-insiders"
>  	fi
>  	case "${VISUAL:-$EDITOR}" in
>  	*vim*)
> diff --git a/mergetools/code b/mergetools/code
> new file mode 100644
> index 0000000000..566a0d9d63
> --- /dev/null
> +++ b/mergetools/code
> @@ -0,0 +1,7 @@
> +diff_cmd () {
> +	"$merge_tool_path" --wait --diff "$LOCAL" "$REMOTE"
> +}
> +
> +merge_cmd () {
> +	"$merge_tool_path" --wait "$MERGED"
> +}
> diff --git a/mergetools/code-insiders b/mergetools/code-insiders
> new file mode 100644
> index 0000000000..566a0d9d63
> --- /dev/null
> +++ b/mergetools/code-insiders
> @@ -0,0 +1,7 @@
> +diff_cmd () {
> +	"$merge_tool_path" --wait --diff "$LOCAL" "$REMOTE"
> +}
> +
> +merge_cmd () {
> +	"$merge_tool_path" --wait "$MERGED"
> +}

This looks good to me, thank you!
Johannes

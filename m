Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4DFC433F5
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 15:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352608AbiDZP67 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 11:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352652AbiDZP6y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 11:58:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8162E6B3
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 08:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650988530;
        bh=Q+LKt9UYmXtKfLvEVx/WlqtxfTl5KaeYNj1Sy2NnRLk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MLHuhlRtkCK2JSLyD9yiu+5zdr6rz343qI9wDxYhx+NQZVqIpJ/tRGfj9/ZiDGwmX
         9kVtK7tnYOygUHOV/qBJevn8N5SxK+PW34Cku3ZfvIWXgXbo6bEHQyRyw96g8b8MnT
         D+PwOkVR0Qes2knu/5hJEBCVMUWnZwSGS7OI55e8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.146.35] ([89.1.215.71]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPokD-1nX3Zq3dFj-00Mskj; Tue, 26
 Apr 2022 17:55:29 +0200
Date:   Tue, 26 Apr 2022 17:55:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH v3 2/4] ci: avoid brew for installing perforce
In-Reply-To: <20220423142559.32507-3-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2204261747530.355@tvgsbejvaqbjf.bet>
References: <20220422013911.7646-1-carenas@gmail.com> <20220423142559.32507-1-carenas@gmail.com> <20220423142559.32507-3-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-510691749-1650988529=:355"
X-Provags-ID: V03:K1:JM8maIUPVugbaThU2gr4vgREAJb6ALihb3sByp0e4dRnd2TSOXh
 Hb0jWp0ck8DvNG6rhwrvABJ3m73QNPyNhJf1KmO8mgDup+S+0zISKzR0KP9bNM3u6duoerG
 9j/uCMug5Dhr+ySIBwsgWjzl+XhurUgfu1GKfHGyAApv0ONMZVlK9rAhOQbAJI6D1c4jAZi
 aQdsWMoT5S5DQIK01IxxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bsbe/785xhY=:Goc9eMU0M9otxyiPu2oPT4
 oX51daiI+sWNMij/dShlv8CmrW/1sx5xxQOKGeFeKI1Irym6XeDU0vaiZeTe8PyfVmmMgcjRS
 9Ew7tdYoZKpfMbNMC6hsE3vE9NpbfSgJLw0566QusTZlF+MVcWyL844dClAJn6R1yPVWmldKW
 x47x8oxatxV9kaULQMtwWoRZTPsKBZQgwotbjvqI/HbP9LeBywOE0YCg68C1CQBZIsUUeNaa8
 Hu7Nj7EsZacnjrVRq6Eu2MW/OhzAH3k2amSOF9PLpYtAjVenJICh3U5auxBLEKZUQY5Yq9gRB
 tG17EE0L5xjlVooQolLi/gY6l8jqhO5zxDgLjBG6RxVqrJo2hPO+gq3pm39INrUT8QPtQUJTK
 bbNVNTbOiDnti37wkS1Ka+eNH+GpTUw+3xVw1+D0a8qrbXBJMqg/5C86z28VPEQVZvWf40YNA
 2nKdijzuXSr5QWmbZxDiHX1FeQr9BhKx3Dn9uGrU/6ES0rSU25engumMqwNyrjUWHt6W+CFEL
 oWykCSON08xCzlfF2Sk5k865IJ/AFfROBs9KJQJRSBikROv7f9bzg+xtrb1y0/+qPpuO4l4G4
 wb2d6ihkzPRqVFuBgHoylZtw8alqqisxEQ/rUD2zTWhZhhYuN7PNTEjLMMno0r8wLzuUeCHTw
 ULeYEZLJ+60gA9gNOVAb+eKIHnvgpk4UrAgmmOAgVi6ZzbBP/+CmoGTxIqNgoaZ2BdxEO9Vsv
 oawIcS9SgE0ghqAZHgv4EqVn0YVzO6TFERfVw6KZMPkUa1qTIOucYFE2Ze5Y/IU97LAePceRh
 bt2BpdS6/k20ceaktShD11B/2c+D0PbZQYmBTQAxcq/3b6cSAoTGlRoqG1B8TNt/Y0CJtDL5O
 6ZBruMW01YcfZ2WOtq7FnXKGQBwugPWMa8YshR6hANTlOteJU8DoOBN3h70OQwtA1cNwOn1aZ
 i99XiPZFN2R77prCgkib1DLcs2radWPy5muYksyb9qmoJQf2sc9kUEoSJcr+mKOW1twIYliky
 g4RBvdZ2HKAVPZn3wpb+iTnnD/ylT75+AFVpsLYxKWHS/cN03lNoQ4qnndDYUF0bZXOO3bsGm
 7HKsloQvGAiFyY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-510691749-1650988529=:355
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Sat, 23 Apr 2022, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 41e9290fbdd..9da03350d09 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -37,13 +37,14 @@ macos-latest)
>  	test -z "$BREW_INSTALL_PACKAGES" ||
>  	brew install $BREW_INSTALL_PACKAGES
>  	brew link --force gettext
> -	brew install --cask --no-quarantine perforce || {
> -		# Update the definitions and try again
> -		cask_repo=3D"$(brew --repository)"/Library/Taps/homebrew/homebrew-cas=
k &&
> -		git -C "$cask_repo" pull --no-stat --ff-only &&
> -		brew install --cask --no-quarantine perforce
> -	} ||
> -	brew install homebrew/cask/perforce
> +	mkdir -p $HOME/bin
> +	(
> +		cd $HOME/bin
> +		wget -q "https://cdist2.perforce.com/perforce/r21.2/bin.macosx1015x86=
_64/helix-core-server.tgz" &&

I vaguely recall that G=C3=A1bor Szeder attempted something similar, but I
_think_ that ultimately there were too many moving parts in that URL that
we did not want to hardcode.

For example, when opening a PR against `maint` or an even older topic
branch, we are stuck with the exact code in that revision that obtains
the perforce package. But since that server is outside our control, it can
very well evolve to a state that is not amenable to hard-coding such a
URL.

While I don't think that we can solve this fully, I would prefer to keep
the existing `brew install` calls but fall back to downloading from a
hard-coded URL. That still would have the shortcoming of hard-coded
`r21.2` and `1015`, but it should fail less often than the proposed patch.

For the record, the recent problems stem from the fact that the package
was cached on GitHub's build agents (I guess to avoid many identical
downloads), and the cached package did not match what was recorded in the
updated package definition. Which means that those `brew` errors are only
transient, until a new VM image is built that caches the then-current
perforce package.

Ciao,
Dscho

> +		tar -xf helix-core-server.tgz
> +	)
> +	PATH=3D"$PATH:${HOME}/bin"
> +	export PATH
>
>  	if test -n "$CC_PACKAGE"
>  	then
> --
> 2.36.0.266.g59f845bde02
>
>

--8323328-510691749-1650988529=:355--

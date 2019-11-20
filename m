Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E42C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 10:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B88B2230F
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 10:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="U/bjElms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfKTK7p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 05:59:45 -0500
Received: from mout.gmx.net ([212.227.17.20]:57219 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727438AbfKTK7p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 05:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574247577;
        bh=khev6lsY/0LL5WKZgEniy/j68kZX2Hkm8BAjG74tCmA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=U/bjElmsDTCN5orLkLB4hWCuFUecKgVWT+BCPI+icimkC7dxutNHj9ikjbvl9dn07
         1KJkiUd6P3Q6HRvqdkOB8IY/gJF0Y3uKHk2itSNvw8QNQBxaSCKzAdS3GAkEJJ7pYp
         89XPWmdO2J2LqBnRXkY9Zd3JlTKFnKX4wqdDnCmI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McH9Y-1hzPKn20q4-00ck6H; Wed, 20
 Nov 2019 11:59:37 +0100
Date:   Wed, 20 Nov 2019 11:59:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 1/1] ci(osx): use new location of the `perforce`
 cask
In-Reply-To: <xmqqk17ve45s.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1911201157500.15956@tvgsbejvaqbjf.bet>
References: <pull.400.v2.git.1571316454.gitgitgadget@gmail.com> <pull.400.v3.git.1571789978.gitgitgadget@gmail.com> <9d80e845bf923c4543c49f9947aacb10c59ff6ce.1571789978.git.gitgitgadget@gmail.com> <20191118221804.GA23183@szeder.dev>
 <nycvar.QRO.7.76.6.1911192155140.15956@tvgsbejvaqbjf.bet> <xmqqk17ve45s.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1389521074-1574247578=:15956"
X-Provags-ID: V03:K1:9hLC7h1GKJwl7+5BIJOYREBLHPu7Jyb84Rk/mYO9a+CPEOhox3r
 jNDHQQBuvp1U2LnlQjQgRd0uAPWck/hBpzHHNU8VajyzZGrfFrjpU0IUf39dAE1Xi9kbp7i
 fto3mBtyF0sqngaYl/uF9Y2L1VmhJO72fVBPxpoK77D7BWS+g0GvgBz9xnGe3t60J0TW4jk
 MPmqAy7tX29gngE4rTpnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nn1MFXTovt8=:is7IIWSeUwn+iFkjC5+/oW
 kVTOH/hHCEjMM0aGrvSOZcF4FYJmR8p+eS3wH7PcApLo0dAQJswfbNeq3qhp2WiMWC5KyHgd+
 a3pQOWzzcFKmGC3Xn/zv7AQZtfYRiiX8pTDvqUPyf2oq7z4VJT965Ir7wn5BsAHauqZ/SoOGJ
 6wgWDZLQltNGXuWlIIWdmvdune/I5qtsmGjcSo7yxq20Snc/NOBcA+DFIxfxu+X3CBg+2p3Ux
 Yz/OozzL0vrynrrxRfgsIzLaQBCM5/xIeq4x4wN227xvI2uizU5QEmNEcsznhcA7lVxBgGokn
 VvlwMZ9DCeeozds81kA/S4dlepOtDPgn/TufC3jeA+LawY3BAZSXdrUGKEkq1w77mVmBSff/S
 pjqGb5suYgbtA7VffPUrL1Z/E1xTZpAt1XpMdFt0k58fg03F/5OnhAmUbfIjG1vOnR8ds1Mba
 ahIyBMWbonTy3VjchS/g+Ik/FsYBhcfzvItduImt41TaEfAoGJAzNUq7YbrJ18La4v+/VAscC
 OikMoTnMRxzwzq2YyRIHAiDekjLfvzLaUwxI/HQhRW67nZLpK/TpDnxEgApv+aQ8QN9gDTM+j
 DNmcFDBx5SZmDeXgb5eV91i4udLsx9P99tb42no9KP7VNw584XCw8PwS3utyi2vsodXUjLJ/n
 s7sD9tkM/5rr/ewzaFUCCKh45LA0sv2JU5bho5b7UW/jKFetT1iqEvimxYYWnUlKx6W+zO6Jy
 mYBJQAiLdpTv38/ayggiV8K2f9BWmymQAS5FpKCvzjgJRMAyelk5CHHqbQjD95VWKa7Xgk01l
 6DchcD7Wc1w3BNSAkKOPkmUpj/STlSSIro8rToTBFWQhfDVvD1nLKE/So6AvI2TCfj3jbBj7I
 FvA8EkWc0ew6yB2QrFL5yEKqBEYijtTwWOVLU5x7cEMDBvyMn2JrBynkVEBDG+SA0ZQhWDHzG
 RZ1P+SgUaOzTWwD2Y2X8pXCUSD3u3Tedns5hSrCO3NTuH7AevGZBZ5mptZ8u9m38vKCbUmK6L
 IR8InMyMJUYG0yONRVQ7hU6YNK13ViT8mNXB4UU/MCWH/H5BOEqNKV3GeYahE05v+HivNKDUz
 L6/Gq6W5qT3eeyuKXYvl63gUS3wUaoq6OE/wT81dG/0MxrCsXrXjKg0Q9dDAhJ1KBYLgW5mg8
 hYNqyHnGYlJp+GROLLSQy+tvjdDyngunAe+lUzBaG8IjHBFeY/EmqAXfDkcW8f8ibYuJTy+m7
 K717OZ+Y0Tv4Vu13zsjSpV5HHweGj5EzYmdZzY+Jt67Ob+YmpLBvzXx0oSy4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1389521074-1574247578=:15956
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Wed, 20 Nov 2019, Junio C Hamano wrote:

> -- >8 --
> Subject: ci(osx): update homebrew-cask repository with less noise
>
> The OSX CI build procedure updates the homebrew-cask repository
> before attempting to install perforce again, after seeing an
> installation failure.  This involves a "git pull" that by default
> computes and outputs diffstat, which would only grow as the time
> goes by and the repository cast in stone in the CI build image
> becomes more and more stale relative to the upstream repository in
> the outside world.
>
> Suppress the diffstat to both save cycles to generate it, and strain
> on the eyeballs to skip it.
>
> Reported-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  ci/install-dependencies.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 4e64a19112..b6b4f4707f 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -42,7 +42,8 @@ osx-clang|osx-gcc)
>  	brew link --force gettext
>  	brew cask install perforce || {
>  		# Update the definitions and try again
> -		git -C "$(brew --repository)"/Library/Taps/homebrew/homebrew-cask pul=
l &&
> +		cask_repo=3D"$(brew --repository)"/Library/Taps/homebrew/homebrew-cas=
k &&
> +		git -C "$cask_repo" pull --no-stat &&

Even better! I missed that option because I usually read
`Documentation/git-<command>.txt` directly, and of course that is in the
included `Documentation/merge-options.txt`...

Thank you,
Dscho

>  		brew cask install perforce
>  	} ||
>  	brew install caskroom/cask/perforce
>

--8323328-1389521074-1574247578=:15956--

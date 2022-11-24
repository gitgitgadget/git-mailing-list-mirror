Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A831C4332F
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 08:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiKXITN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 03:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiKXITB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 03:19:01 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FF056EF8
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 00:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669277806; bh=vEtSLAlixPM82gNOzCpoGe1wiM1uSbu8/rgLp1B+/+M=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ERgE0yJEnynDKB3LQzCHOofs6VgHPkcLYKpXR42w2CIjeVPz8nU8xF8DQ6urJQqZt
         IeV7l66pIZTXb4gZVzWRmEFH4GlRydmim9pQ28U/ccsL/FIixIfY4zFShQy7pFeBAa
         XorJwC30llyN3wQFI0oQcFDorRBKcv9TFOSLFSZ33+SOCS0LMp8jk+WQz3ttFaMilw
         EjTTekTZ2+tdNxQNBWtiKwydDvjCcN+f2lFdG4FYoq+tqst1k1dTXiAXTLqTpI9I+8
         wPtV7+ygZbp7mr9FxGUsNbL5/ccbRE4sWzhLNpZ2EJgh3aq75UCnWTo4V2vZbxGmy9
         BqgNqkTeuJQyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.25.58.20] ([89.1.212.70]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLQxX-1ofla107wR-00IUI9; Thu, 24
 Nov 2022 09:16:46 +0100
Date:   Thu, 24 Nov 2022 09:16:44 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Jiang Xin <worldhello.net@gmail.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 2/2] ci: upgrade version of p4
In-Reply-To: <20221123150233.13039-3-worldhello.net@gmail.com>
Message-ID: <n79194n5-8q94-29n4-s447-64r0p2po4r76@tzk.qr>
References: <20221123150233.13039-1-worldhello.net@gmail.com> <20221123150233.13039-3-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Yw1GKy7ap+w0r94H4STrI1/5RP74Is/Wxl+n53fwqa5IO+BErCc
 mNythxi7Y70eHD/dtPdU8NTLEi5Y5oFbTRzjdreKB0dQbxtbY0fGF0jgjYWP5ZZdTSE95uR
 it/BR2/B3C3O7jrZAd1zIV2x65F8yhuo6i6QEZVwioVXyXd+0tdxxEFXqkUyBUoJBfJ9l4a
 qOk3Nsjnedb0tsy6B1tBw==
UI-OutboundReport: notjunk:1;M01:P0:gh8dP76vlHE=;G9Hq5e6xiGgyBzdae65MstklSU/
 /xHRBi5THI1o46L1E2Zo7Df9rpmxYHEgYEvFdmmdM5eKQpwxXPZQYtAMLB6VGf8k+7VhFt3d7
 ju/OIHsxc2S98E68Zk1nvzMfnVPVlEX5JtH+iy5+JjXQQarQTpblHxeyg3RU/RIJrgofzMiwh
 WSh6+F1oDanLMcJUCD0ovY75l2tySw0lvVEicWh3/givfA/oxCC+hZ2OqETFTeAQjaWhdGDq4
 Klz3Lws7dVjmzndXAF4myQ4y+43+NQcvf62w+XHalh8AViAR1/3kV7ajV49mn602CQgyQ55jU
 0ttPMiqEmBARUjdfSwkh8iALn5tn6Cbm3VJbKhgAPiIWakXgvO8MbtveVr605VYRm3+rqBDrB
 7r5ZhfoKgDXz0gg50/vvhFvg7H8n40PZ7LCiIWzMZgakOS05xiCyR6CdeW5h0fDtvCt3c3v0I
 ckP6he1/a9RX5bkBHNV90u/pX574MV8nXJLiI7w34pfdnPfpNrOU7olmJM1E5aEHq7bRQWP+7
 mHztsVtw6xH3HiUF9Apyzzp8OwuLOIxeCy5rdK06QDL1t3dwJ5YD77uRG069sq94kFl8J+Fpd
 lB/DO061npTPew1jS9R3k98qcKp0zIugWa/9/lcXyRqJ6hO3+EUqsopH3PHSX/21eGfHBMPS8
 iIVG21HvSviVJBE+RMKl8mh4sYtbEgjN4n1Ocs+Ohnv+rdjT2JOstxn6IA0ewB0uSzNj4NxdM
 NlVzVB3G51RFYmWuygKuk/Nqr7f7afQgLcAO5e8JUkzOSXqo4FTk7ycFKKFef8ptmVC8xb5lY
 SO6fbA2XDg14dI+oDL8uZ2oU/6hRFBzH0LJNUAhFugAV2uFamCNZE+CxvEn1vzwJHF2molkRM
 7Gm64VW7Q1DkXqVTcV4842CR+dngjl7d4lVltiX5WD/1GL9rHwMp4+eD0rlaey/iWb78PetTl
 9bqG3w==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 23 Nov 2022, Jiang Xin wrote:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> There would be a segmentation fault when running p4 v16.2 on ubuntu
> 22.04 which is the latest version of ubuntu runner image for github
> actions. Upgrade p4 from version 16.2 to 19.2 will fix this issue.

I was about to embark on a debugging session when I had the splendid idea
to look at the Git mailing list archives to see whether anybody else had
encountered that particular problem.

However, when I pushed a branch with this fix, it still segfaulted even
when downloading version 19.2 (link:
https://github.com/dscho/git/actions/runs/3538788474/jobs/5939977231#step:=
3:387):

 + wget --quiet https://cdist2.perforce.com/perforce/r19.2/bin.linux26x86_=
64/p4d
 + wget --quiet https://cdist2.perforce.com/perforce/r19.2/bin.linux26x86_=
64/p4
 + [...]
 + echo 'Perforce Server Version'
 Perforce Server Version
 + p4d -V
 + grep Rev.
 + echo 'p4d: bad version'
 p4d: bad version
 + p4d -V
 ci/install-dependencies.sh: line 91:  3051 Segmentation fault      (core
 dumped) p4d -V

I guess I'll embark on that debugging session after all ;-)

> Also add some instructions to show errors of command "p4 -V", so we can
> see why the output doesn't match.

This is an excellent addition. If I read the logs correctly, this change
adds the error message "Segmentation fault" to the output, which is really
helpful.

Thank you for working on this!
Dscho

>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  ci/install-dependencies.sh | 4 ++--
>  ci/lib.sh                  | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index f639263a62..291e49bdde 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -83,9 +83,9 @@ esac
>  if type p4d >/dev/null 2>&1 && type p4 >/dev/null 2>&1
>  then
>  	echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
> -	p4d -V | grep Rev.
> +	p4d -V | grep Rev. || { echo >&2 "p4d: bad version"; p4d -V; exit 1; }
>  	echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
> -	p4 -V | grep Rev.
> +	p4 -V | grep Rev. || { echo >&2 "p4: bad version"; p4 -V; exit 1; }
>  else
>  	echo >&2 "WARNING: perforce wasn't installed, see above for clues why"
>  fi
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 0c0767d354..8474b0f249 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -246,7 +246,7 @@ ubuntu)
>  	# were recorded in the Homebrew database upon creating the OS X
>  	# image.
>  	# Keep that in mind when you encounter a broken OS X build!
> -	export LINUX_P4_VERSION=3D"16.2"
> +	export LINUX_P4_VERSION=3D"19.2"
>  	export LINUX_GIT_LFS_VERSION=3D"1.5.2"
>
>  	P4_PATH=3D"$HOME/custom/p4"
> --
> 2.39.0.rc0
>
>

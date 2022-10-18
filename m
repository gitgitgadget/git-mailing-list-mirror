Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3D9C433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 14:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiJROs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 10:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiJROsq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 10:48:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F51AD8ECC
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 07:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666104518;
        bh=yxU4HweRBUq1Y4ltlhNLhGeGNthmEZgNCsG9xNzU1ug=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=k3cVBAFS9cCdmrUX4ndHkMQEhElkQoenrO9Y9lfiQoWorK5QfsjrQ94mPYkw2kDOm
         Q5KQA8DuXlA5gJE/4oUhF1rQ6xj82bgg0XyxoaHX1qpGZGy28+unZU7GKx6OZxmIsH
         ABDkv1MsXt7O35yzGqEJ1O6S94AWodUgjmcwdBHA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.67.214] ([213.196.212.100]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8XU1-1pFkzX2GRt-014VRD; Tue, 18
 Oct 2022 16:48:38 +0200
Date:   Tue, 18 Oct 2022 16:03:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Victoria Dye <vdye@github.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 4/5] cmake: avoid editing t/test-lib.sh
In-Reply-To: <531620e1-de4c-74aa-c840-c12ce81f8740@github.com>
Message-ID: <s9r33841-8197-1r04-5528-37qqo6363s62@tzk.qr>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com> <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com> <22473d6b8f3d4e4c482c27a4fb3b58705d4c93ca.1661243463.git.gitgitgadget@gmail.com> <531620e1-de4c-74aa-c840-c12ce81f8740@github.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-2000030779-1666080805=:174"
Content-ID: <25snn870-7rr7-208o-3n30-r9nr86oqrr52@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:99RwNHOTA/cPq+32w5ThY+2ccCAgArgLOtH7W46mvApw2iHLyBX
 L+wtPxS4NUXeyM/edkdAOSdbjHmmvg0YYRiPTkVGLsqAinTXy01PRs1AnN2Ex67sr9xK9wV
 XsXDDsVQ3QUYLub2ZJv5Um33C9lhBkO6qfNRJE0spqRNuIgHxVJXtcFf7qcb4LbgEITUFIU
 mQMqcSOOP4VU1gsedVeig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qK1PNHYLj60=:QxFSUxLko++t9hKgctbL6S
 tWR/We9K1OMpXBVukRLuWh7twA76EAOjs77yOPypqGIxk+soEJgXZ8IERIHOW+JViFtU28Gkm
 ZYwoy8ICqiKv9wVHREjwrtGCkZfVhVFdGm+u3mGMC8D54cd8EybiOY96ehtsiD1Mm3Vt7tF0K
 kAuunPdmp2F/f/q2Y3DiF/LBswKlkIOQJ4SDKY8U28bFKPskl3c8pWcu5FMl1etcuMve/HCR0
 +HbHR/6e0gZXFMPQjA/FnX8H51fxgypMSCGQ1QAYSUZYZQoTv/iLQqRnWpNjs7dc9quC98NlF
 RHuE1JNYiDx8LN66ErUG92ooiJ5NXtio3FBow6gqu6dGGaryU0Is9SsfCyz3zTsVGD541H/ua
 7yA76XS/tuoc0p4Jwbk3T/cZibIZE+offvWK5b5JCshe3MQyCciJzbCZlWr/DtdBE90TPqLE2
 lqPv1rvstVTtYL5kxfhpKBf77o/WkPkhtcdes/uhv155DMBwIQeJMFWhmmD2Kvr9V8q8MEDYM
 KGAoK/hoe3S1PdMaSnAHbpOw3FCv+cF8uLYfbcZc/EltZYAmWJ6tyEduH8quDwXEOxGdmS6xx
 wqtdhY5B7Y/uf32e9FDBwFz6KRREWmZK1pD7PFygnqWJ48Yf33fXPFBEjpLg/W1IrmvvgtVzI
 W5Wpv4StNgszroj/kQ83yWlJF97kSKavkgqFAgOas4QC/LfPwp/LnlB+ioioCY9dY4pa3dlOl
 5LM9J7MgubLfdgF51WpYosH2p47mjr5k663AVI7OqZHK6X2m0qu0UmIXk1BdgJupqIQxGyL6S
 agSbf6Li05bnanfp8g/+zQFfXX1GGsJN/+4Da0c87mfJgFRT/kXXaCOKZCaSHdyx/JtikPDD5
 xIQMDjdFNoDOwHkKc4WjUVu0TLmCQgp17yUYoS1kT8+fvQJ0Fhb/QIC2+IARZhF/bDoZ0ebDE
 aTOZcC3sUmwOrocpsO93aKrv6EP1p9VDbx2TvpWilXH/n07hCDL3wNLQHk39P8ETT5E8aNgZ5
 L1XurO4j5VCFl15rJxa371c9X4f6kWSjfIeP/4Bo4IazhLz31mjoQSog5JMNSuKQQ3X/9SyAa
 wPx6uzEiueSz8q2EdPAD3iz7PMPdSt1MDR3yGR/Xfslo0y88uee83qaMVY6ve+HGXdXIAmkmO
 I3ZkHpYL9rlm8jmp6NHFaOJQ5thWfK7ljgL4Q8OVDrqC5pTLOzhQIYYdujnCanSbsy6VN654U
 n7aslXzBpoRHejAnW4RtHlzmU48/vh4OLRrjVNXFUlAMqf3pjcneANwql286/Une6RDmpownn
 naDvuN7PXRf5P1l16IMpx3Vfa6SJnZXUDToiNPoOMgzpiZ5deDUWyLHdS1IKBjpzFoH7tEoXk
 4qSnIq00LovinpVYScOGJa6clVJwwa3BUXn1JiSk938Ibn8CuAkJeEixM7ScOetOEdkGXSuf1
 uMzRtAuLMbUk/XXyJLypNWplxiX3BmXDaVffIk9GI7UDd2qnieKyr3zAACa9zRYsjxjnugtwv
 dS622vO/UvNPydxOy8jNyjElpy7AEUyucroJdM6eCaMv7ueNJTEuntfuIID3kXT4h9A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2000030779-1666080805=:174
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <r9son3s2-p70o-944p-o8r2-q2o519r8543s@tvgsbejvaqbjf.bet>

Hi Victoria,

On Thu, 8 Sep 2022, Victoria Dye wrote:

> Johannes Schindelin via GitGitGadget wrote:
>
> > [...]
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index 55857af601b..4468ac51f25 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -42,7 +42,16 @@ then
> >  	TEST_OUTPUT_DIRECTORY=3D$TEST_DIRECTORY
> >  fi
> >  GIT_BUILD_DIR=3D"${TEST_DIRECTORY%/t}"
> > -if test "$TEST_DIRECTORY" =3D "$GIT_BUILD_DIR"
> > +if test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
> > +then
> > +	GIT_BUILD_DIR=3D"$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
> > +	# On Windows, we must convert Windows paths lest they contain a colo=
n
> > +	case "$(uname -s)" in
> > +	*MINGW*)
> > +		GIT_BUILD_DIR=3D"$(cygpath -au "$GIT_BUILD_DIR")"
> > +		;;
> > +	esac
> > +elif test "$TEST_DIRECTORY" =3D "$GIT_BUILD_DIR"
> >  then
> >  	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?"=
 >&2
> >  	exit 1
> Referring to =C3=86var's review in [1] - while I'm not overly concerned =
about the
> "switching between make & CMake" file staleness (if I'm not mistaken, th=
e
> same thing can happen now with the modified 'test-lib.sh', so this patch
> doesn't really make anything worse), I do think the changes to 'test-lib=
.sh'
> should be rearranged to preserve the "PANIC" check:
>
> ----------------->8----------------->8----------------->8---------------=
--
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 4468ac51f2..7b57f55c37 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -42,6 +42,11 @@ then
>  	TEST_OUTPUT_DIRECTORY=3D$TEST_DIRECTORY
>  fi
>  GIT_BUILD_DIR=3D"${TEST_DIRECTORY%/t}"
> +if test "$TEST_DIRECTORY" =3D "$GIT_BUILD_DIR"
> +then
> +	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >=
&2
> +	exit 1
> +fi
>  if test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
>  then
>  	GIT_BUILD_DIR=3D"$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
> @@ -51,10 +56,6 @@ then
>  		GIT_BUILD_DIR=3D"$(cygpath -au "$GIT_BUILD_DIR")"
>  		;;
>  	esac
> -elif test "$TEST_DIRECTORY" =3D "$GIT_BUILD_DIR"
> -then
> -	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >=
&2
> -	exit 1
>  fi
>
>  # Prepend a string to a VAR using an arbitrary ":" delimiter, not
> -----------------8<-----------------8<-----------------8<---------------=
--
>
> Otherwise, a user could run the tests from outside a 't/' directory if t=
hey
> built Git with CMake, which doesn't appear to be part of the intended
> behavior of this patch.

Good point!

Thank you,
Dscho

--8323328-2000030779-1666080805=:174--

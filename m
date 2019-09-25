Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82B7D1F463
	for <e@80x24.org>; Wed, 25 Sep 2019 15:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439540AbfIYPVK (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 11:21:10 -0400
Received: from mout.gmx.net ([212.227.15.18]:33249 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439500AbfIYPVE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 11:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569424858;
        bh=Frk3L58qXp3l/GPtPdoUs2gmrxr2veybPJkMM17k1Po=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=k4vIbHHezhEftIZI6w5ro1p8AOydxAlWE20Ib9muDxwaOOWRFZhxKTAjwxlJ0cJYM
         uw4ZQN4mjmqMsWxpQewFfuiR0n/HC+tv3IDoST/GYaBeYc89Oopsi0wLJUDM/hNng1
         Oe+lmMRIHay/b7MORTZCb2Dvts3GjdVk8nnIFQSc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNKhs-1iWUUa1sdO-00OkRM; Wed, 25
 Sep 2019 17:20:58 +0200
Date:   Wed, 25 Sep 2019 17:20:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH 1/1] contrib/buildsystems: fix Visual Studio Debug
 configuration
In-Reply-To: <525669b3b38ed57d6d4f188dfe0bb8fe10b63749.1569227313.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1909251720290.15067@tvgsbejvaqbjf.bet>
References: <pull.348.git.gitgitgadget@gmail.com> <525669b3b38ed57d6d4f188dfe0bb8fe10b63749.1569227313.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mZjjHTH1UMXpY770gsjLDEYIUPdIdVdGvx8++8lZ5hyZUttya6s
 8kwqe9KifWPRCUWn0r4s9RRlDHCU2dkvt806p2p/N8aiI0sR1AdCKjA1va2pKpssgXmhaom
 HgUeR+sfBAUvZrzjx/uZ6g9e/281vYM8WfPU4u+YXJvq3gsPsw05XT9ErktXI6tA1IYmLZr
 bAHbB7SC69c9UHUAYsgNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:udsXIoKkeoI=:DHDS/0iHSuKTQ12O+DvMmp
 /2O+HxtNuSFlT+XPmGxZOcO2uA7oxHX/n1agdqyRzanoOm6qcsodfduolaukIMUL48ouXN9if
 hmu3/GnlfYFdhgSPpQuhgE3m3huF3yNZuONrdFJyuwXib9pgNO2n4uTc+orO7PV+Pd2VTfZ/U
 nzEQ+eVTkdho4CIwfMg5Z1Ztnl36QQd8OduW9GK5cd6PvdcIr9C7CLYmXNptvth0GdronggHX
 hUyoszlpGlwGr/9P03M7OgtkOX8AJpQzVoHCLkRSCF7/RVNywqcW6W7ccrtk2P0z/EnErj4vw
 rfK01yU3xzscWqyI2yEY0NUMXHb1nJfCmug4IZyp7AIzD0TrfRU+10qeegGL26YvHd7KNo7Ca
 2Bu8oShOgrmv6z1PNBKbqtm3gFQ5AgobDJp4jhzppJWJvwbvHrACIQEKRWbTeaitoc+XRlzXP
 a5t7h0GBzmPbMPnZmruugT0DVnaquf83sL5wvEho15Zq/WaCsUzDixNdW/8ZFgqGpYu+2xTPG
 O9BD1kHMpRxwtVRqCURV6NVTQhgUlOVv9iMRi8br/5ZSfsW9P6RrWNnfT2f7GCfzUPoIIc1Dm
 6gxlPjO0aDVhfk5U3SiKKKh4YJUkIzvBYRumSW3WYjeuItfuaR6o/7QD1R7E1f5/8k41mpnUu
 zKf8XEeOSmMzQUuJ5OK71IGIz3esknsb8vEMfGlO13n0fWCQhhae624DGgn/4+BHj4DCNf1Up
 h89VX/WP3/cST3z2VIYJylvzIMJ3R7EQOurl9yCaUHZYpxaoliNCRVze8kex/I2bHNPELfC+v
 ro1MKzKWuV83xjxkJJT9B8jaf7Zjuy7Xhy82muPvFc6E+uCL12yvWMrN27VDR9EGrRR5mLgqJ
 j2g9vQHN/jLIoKkNmr9p0H2LaP63bw1CtcxU4b6MblcsoXNsV6+VFDhsz9y8yCgGTDLhJo6as
 NN0upyStPAqFI4nZ+Yg3clItZz6bjOguxcDi4CcG3p7xw7PC1GppTApJVmtaWK94hBgvN0+63
 EehgnO0VjIIuk+stI3/IWStUayTX3HIFrBkltiJSu6Fa1Yr+OWs7C5oZpT/LFSmqsnKXLxoAe
 XohpixzN8NawwU7w32v3nVEgQXPgi4gDqI7AjWnmJQwLFBGQ0vWxnwzooZQ+1BjARx2oU7AtE
 /UItIb/OSUjNFia9RIeaIY3TGEyZVONiFCcElOhE7VjMc1Y/a0Ke7wsBj8174z6YLhKZXdrGB
 YfVONdSiw/uf2DfrMAnRer6w65cVhmFMLuIMuD1l+3H/gILD59Ti79Wmy0Vw=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alexandr,

On Mon, 23 Sep 2019, Alexandr Miloslavskiy via GitGitGadget wrote:

> From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
>
> Even though Debug configuration builds, the resulting build is incorrect
> in a subtle way: it mixes up Debug and Release binaries, which in turn
> causes hard-to-predict bugs.
>
> In my case, when git calls iconv library, iconv sets 'errno' and git
> then tests it, but in Debug and Release CRT those 'errno' are different
> memory locations.
>
> This patch addresses 3 connected bugs:
> 1) Typo in '\(Configuration)'. As a result, Debug configuration
>    condition is always false and Release path is taken instead.
> 2) Regexp that replaced 'zlib.lib' with 'zlibd.lib' was only affecting
>    the first occurrence. However, some projects have it listed twice.
>    Previously this bug was hidden, because Debug path was never taken.
>    I decided that avoiding double -lz in makefile is fragile and I'd
>    better replace all occurrences instead.
> 3) In Debug, 'libcurl-d.lib' should be used instead of 'libcurl.lib'.
>    Previously this bug was hidden, because Debug path was never taken.
>
> Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

ACK!
Johannes

> ---
>  contrib/buildsystems/Generators/Vcxproj.pm | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/contrib/buildsystems/Generators/Vcxproj.pm b/contrib/builds=
ystems/Generators/Vcxproj.pm
> index 576ccabe1d..7b1e277eca 100644
> --- a/contrib/buildsystems/Generators/Vcxproj.pm
> +++ b/contrib/buildsystems/Generators/Vcxproj.pm
> @@ -79,7 +79,8 @@ sub createProject {
>      if (!$static_library) {
>        $libs_release =3D join(";", sort(grep /^(?!libgit\.lib|xdiff\/lib=
\.lib|vcs-svn\/lib\.lib)/, @{$$build_structure{"$prefix${name}_LIBS"}}));
>        $libs_debug =3D $libs_release;
> -      $libs_debug =3D~ s/zlib\.lib/zlibd\.lib/;
> +      $libs_debug =3D~ s/zlib\.lib/zlibd\.lib/g;
> +      $libs_debug =3D~ s/libcurl\.lib/libcurl-d\.lib/g;
>      }
>
>      $defines =3D~ s/-D//g;
> @@ -119,13 +120,13 @@ sub createProject {
>      <VCPKGArch Condition=3D"'\$(Platform)'=3D=3D'Win32'">x86-windows</V=
CPKGArch>
>      <VCPKGArch Condition=3D"'\$(Platform)'!=3D'Win32'">x64-windows</VCP=
KGArch>
>      <VCPKGArchDirectory>$cdup\\compat\\vcbuild\\vcpkg\\installed\\\$(VC=
PKGArch)</VCPKGArchDirectory>
> -    <VCPKGBinDirectory Condition=3D"'\(Configuration)'=3D=3D'Debug'">\$=
(VCPKGArchDirectory)\\debug\\bin</VCPKGBinDirectory>
> -    <VCPKGLibDirectory Condition=3D"'\(Configuration)'=3D=3D'Debug'">\$=
(VCPKGArchDirectory)\\debug\\lib</VCPKGLibDirectory>
> -    <VCPKGBinDirectory Condition=3D"'\(Configuration)'!=3D'Debug'">\$(V=
CPKGArchDirectory)\\bin</VCPKGBinDirectory>
> -    <VCPKGLibDirectory Condition=3D"'\(Configuration)'!=3D'Debug'">\$(V=
CPKGArchDirectory)\\lib</VCPKGLibDirectory>
> +    <VCPKGBinDirectory Condition=3D"'\$(Configuration)'=3D=3D'Debug'">\=
$(VCPKGArchDirectory)\\debug\\bin</VCPKGBinDirectory>
> +    <VCPKGLibDirectory Condition=3D"'\$(Configuration)'=3D=3D'Debug'">\=
$(VCPKGArchDirectory)\\debug\\lib</VCPKGLibDirectory>
> +    <VCPKGBinDirectory Condition=3D"'\$(Configuration)'!=3D'Debug'">\$(=
VCPKGArchDirectory)\\bin</VCPKGBinDirectory>
> +    <VCPKGLibDirectory Condition=3D"'\$(Configuration)'!=3D'Debug'">\$(=
VCPKGArchDirectory)\\lib</VCPKGLibDirectory>
>      <VCPKGIncludeDirectory>\$(VCPKGArchDirectory)\\include</VCPKGInclud=
eDirectory>
> -    <VCPKGLibs Condition=3D"'\(Configuration)'=3D=3D'Debug'">$libs_debu=
g</VCPKGLibs>
> -    <VCPKGLibs Condition=3D"'\(Configuration)'!=3D'Debug'">$libs_releas=
e</VCPKGLibs>
> +    <VCPKGLibs Condition=3D"'\$(Configuration)'=3D=3D'Debug'">$libs_deb=
ug</VCPKGLibs>
> +    <VCPKGLibs Condition=3D"'\$(Configuration)'!=3D'Debug'">$libs_relea=
se</VCPKGLibs>
>    </PropertyGroup>
>    <Import Project=3D"\$(VCTargetsPath)\\Microsoft.Cpp.Default.props" />
>    <PropertyGroup Condition=3D"'\$(Configuration)'=3D=3D'Debug'" Label=
=3D"Configuration">
> --
> gitgitgadget
>

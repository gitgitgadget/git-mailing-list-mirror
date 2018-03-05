Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FF5D1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 13:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934453AbeCENrx (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 08:47:53 -0500
Received: from mout.gmx.net ([212.227.15.15]:48183 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933799AbeCENrw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 08:47:52 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LiTF6-1eGTqT15Z6-00cflL; Mon, 05
 Mar 2018 14:47:49 +0100
Date:   Mon, 5 Mar 2018 14:47:48 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Colin Arnott <colin@urandom.co.uk>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] http.c: shell command evaluation for extraheader
In-Reply-To: <CngnTUCx1pVSyKUzINZV972DlD_JMH53F-L2PZtx0_RKMiwXYY4f2UzDPeJaC5fL-6oJBXAxQ5f0OC76I_fagEWxch5csI716N7bQDh3gR8=@urandom.co.uk>
Message-ID: <nycvar.QRO.7.76.6.1803051437000.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CngnTUCx1pVSyKUzINZV972DlD_JMH53F-L2PZtx0_RKMiwXYY4f2UzDPeJaC5fL-6oJBXAxQ5f0OC76I_fagEWxch5csI716N7bQDh3gR8=@urandom.co.uk>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:dF54tVHLKuIeKiCj3BNSgqJ3lOI33NiBe5JOtypPkPY0TL6P9/b
 FGMlcu9mo4dkYncWEIfvLOSqn/Lb6Jl406w/6Clb9naHAH03cmoE4dU9985uvtVINf72xp8
 xvZdUFY/JceBedoBBPklWQjEnxvhCTBN2p4L1b/M4XSZCUJ/kFgv70p3e4llaVTkqEALs3B
 eHQtqYXkJk3Twzwq0gk4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Fxf/xdmggDA=:Y9lekkwuiDq/8RT7nW20ns
 DGRIyc0PqE9fBjo6+QohC5RP5QuBazS1ImLeABBBDw2xkuCkAwf6/liF0tlYtdUB1MEgiNSXr
 27iFzBqqQLXpSZonA+jo9KzT6a5dp0QNv8jLZyH1UG5k31z/GmNQyXuEz0N+yz4V1qjPFwvlW
 /MjJjyE/l2jGJXsY2QzyYdhQm9kCCDwW7K3y50+WTWw0EHszsW5SzqFewlw6Cw8nlf4O3QLFJ
 JiSDnwVFkEzhiYlW27XvredCCSb9ne+J62t3gJcbcSP4eiu3c4JHPsJI2hBTdPLr+MA17DKGN
 aZkQQqbQChfmTlysYAoYMrrGAwi7eMihqU1ZxrYHkSI4k/FoJCVd79Ib0b4IDSxWNry0Zye9+
 qRBadMATKIK873V2EJioRlZM3YSvHY78z5RE88ZowVeftZ1+GLS217vz9yxDbeohDV92mxDwK
 mY6jDH7RCCAUpxAudOj049GOTarT41gxdfpJYFqrMWT/G2p4we6N5piyl8ELdV+NqTHfNJxi9
 5deB1fnNi4MrS2znhshaJsVbCCmCt6H/aiv9hwQn5TmfkNc1wt8GVZ2+4GdFvnEsglCEWLdLc
 0QOq3PR3X7k7c/3NP9XucfT4zw4r9k2z2SupJEyFknsGlCCWqcgl7xM9I+rGJSYen6bCrYMz8
 pQ+Ylng21xk1XMfuNQqehMbWRDyE1jYemIH7JP2BDm9XapegSR+fCXrCbzgm+cjQKsLdcbf7Y
 8lipcYIy4tG73KOT0dTufQjjvsjd7uyMkLoSzSZfFvYVaWHcAh/s9OZaINUt6p3sWqCrh9T0W
 WUGsTzVIQB3SFgsi5K+IsGJaiJfOV6sazJ7XTZ82o9nmGJKBn0mtxRNLLD435hENPuPEVDI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Colin,

On Sun, 4 Mar 2018, Colin Arnott wrote:

> The http.extraHeader config parameter currently only supports storing
> constant values. There are two main use cases where this fails:
> 
>   0. Sensitive payloads: frequently this config parameter is used to pass
>      authentication credentials in place of or in addition to the
>      Authorization header, however since this value is required to be in
>      the clear this can create security issues.
> 
>   1. Mutating headers: some headers, especially new authentication
>      schemes, leverage short lived tokens that change over time.
> 
> There do exist solutions with current tools for these use cases, however
> none are optimal:
> 
>   0. Shell alias: by aliasing over git with a call to git that includes the
>      config directive and evaluates the header value inline, you can
>      fake the desired mutability:
>        `alias git='git -c http.extraHeader="$(gpg -d crypt.gpg)"'`
>      This presents two problems:
>      a. aliasing over commands can be confusing to new users, since git
>         config information is stored in shell configs
>      b. this solution scales only to your shell, not all shells
> 
>   1. Global hook: you could implement a hook that writes the config
>      entry before fetch / pull actions, so that it is up to date, but
>      this does nothing to secure it.
> 
>   2. git-credential-helper: the credential helper interface already
>      supports shelling out to arbitrary binaries or scripts, however
>      this interface can only be used to populate the Authorization
>      header.

As the credential-helper is already intended for sensitive data, and as it
already allows to interact with a helper, I would strongly assume that it
would make more sense to try to extend that feature (instead of the simple
extraHeader one).

This would also help alleviate all the quoting/dequoting issues involved
with shell scripting.

Besides, the http.extraHeader feature was designed to accommodate all
kinds of extra headers, not only authentication ones (and indeed, the
authentication was only intended for use in build agents, where both
environment and logging can be controlled rather tightly).

I also see that in your implementation, only the extraHeader value is
evaluated, without any access to the rest of the metadata (such as URL,
and optionally specified user).

It would probably get a little more complicated than a shell script to
write a credential-helper that will always be asked to generate an
authentication, but I think even a moderate-level Perl script could be
used for that, and it *would* know the URL and user for which the
credentials are intended...

Ciao,
Johannes

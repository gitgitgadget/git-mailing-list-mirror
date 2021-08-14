Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66898C4338F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 22:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 443D360F36
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 22:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhHNW3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 18:29:46 -0400
Received: from mout.gmx.net ([212.227.17.22]:33713 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233223AbhHNW3p (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Aug 2021 18:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628980147;
        bh=bAWSoaNYhfwiKEvPdaotpQa7M1EAzifrX/BxiISijR8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=IZOi4l4lVURs3Mest0VSW9fApy92rcBBt2z6lle6fAuhtxyJowCrDzGYBsQyVxQNH
         USPXEkPaPZbo0myL3BEjby/Z2ssabjjGxyRDTGs86Od4OTlqMC+jjno0DjDdRTSTZx
         zxqz72JrRfyqkReG8XQmlZ2i6tC5zIBJNPG+vHtY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.60.179] ([213.196.213.229]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M72oB-1mANyv2itj-008Xew; Sun, 15
 Aug 2021 00:29:06 +0200
Date:   Sun, 15 Aug 2021 00:29:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, emaste@FreeBSD.org
Subject: Re: [PATCH] ci: update freebsd 12 cirrus job
In-Reply-To: <20210813093909.GA3866771@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.2108150022160.59@tvgsbejvaqbjf.bet>
References: <20210812202200.82465-1-carenas@gmail.com> <20210813093909.GA3866771@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1871771184-1628980146=:59"
X-Provags-ID: V03:K1:GxCg4/c9O2kgQ2krsQhToOuOjQkN/RHA95x9d9n8HDk4gTg3q59
 mZEwrbAQav78+9eD/QCCEwVEeaSBFf+/1c+oKSCu1DMqmQIVjkSibSN6trng+14km5eMPfZ
 5NG4p5XGycQICjuyoSd35BbJNjN0El5hVHnBIJKUfGUhkQkCmNItKNLJfXVBcz1vwDOEWQ0
 1tBtjRckpy5ZCyOrjlX8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xhwzYa7g5qg=:/gJDbz2DFR8UM+x6bMwIRI
 0IfxpKuvfISQBJandjPIJFLji4zvZhxs8KUZEAgfrNbIGl1lKv8UJr4Hr5PVNS38XDlL05mfJ
 kKzLvUuPPCmdhwmOVjsYhtABKWfpQofzUWiG2P0j8bLRAtwzdLUnbbNRaYJAX2bcHz5RFQbHn
 /UXpE9TfBbsgyojt5yDRPQKOdb+LDb1hWgEFu+cyxTriipEDxp+PnasfabMTp4/WBtXsyL0ZR
 6GYLt8kql0LTzfvIhuUfxR7XlYkys1zHhSndJgi4XFIFldbIcngXKB78/CumI5swp3qAq8x9m
 zp9CTT3KTJKC0L98MoHQKeIUTuplASzmBkwuYvIB7tqbq/+ZZ4wqgwRn3FzN6k2GckT5y4mIt
 WBiYDO2x2ZYYOrMGAlPPEvR+JlhteN8eaAxKgcErJeN2oZ1iPfaMuEtvub55khep3SnjJwmPJ
 c+I6XkydyBrx7lrq0k0Nn4HMpjWr0uLu1PRYtDtbsOkwG7aZoiIQHDWDjSkF/xErPaB45jhpo
 UCeT4pxx2cwnn6ibRpP2kB/1J6Kmkm/0l4isHQ6Oaizv0XnsBGfNJn+fvMvvjhDfuHys02CeN
 4dRu2GAWDg5zpCGp1Xjwi+Qk7dMZFCP9vFJqV0U0nK+9cn1yqghj6xWJNhHEVKFtCiEfdWomH
 sTSx0ONAGiU/G993oUl+svVANLQ2qb+1ZrwUt3UVWaoXM8+GOZbPCYr69ZMHfGlcymsqOP1Dn
 V/ODYNj+20AZlGLb1xoKYJMTCZjL7rRUAnAXDQKUWAPA0aRC4VcHQgF+QJbrkmq3Fv2ZhA1QL
 waqiNY3nczoW0eyTyknxD60t7x5HImb2KF6VUmuCozpb9BJ/yQ7ojzwrXB9F1hlonQHO8lU7W
 pJmjV8tgz5q56p+mvrDPopHxDjIUcWG8br3YIujpP9mmXuEZTkMbdCToyZbxk3hNsK5YECNDn
 +6ba3Y1Ptfw5+VUyKZ9r+W1u33rYO2GlIfeeOTR5ztDFfUOaoh+tqxkyTJT8ZBdVRGWGkCiKY
 5mTPkrCYQWoR1tgQiOaE9xSN9t6gZ36eAkKgfBUabCNF/EpAVxH7bY4oevaBPbuWuTLY2uXtw
 OW+6ZdlvLJKrThuYJOECVhu0W1FWOx+soLQSagtWwefkCZgEsOUWgZ0xw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1871771184-1628980146=:59
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Fri, 13 Aug 2021, SZEDER G=C3=A1bor wrote:

> On Thu, Aug 12, 2021 at 01:22:00PM -0700, Carlo Marcelo Arenas Bel=C3=B3=
n wrote:
> > make sure it uses a supported OS branch and uses all the resources
> > that can be allocated efficiently.
> >
> > while only 1GB of memory is needed, 2GB is the minimum for a 2 CPU
> > machine (the default), but by increasing parallelism wall time has
> > been reduced by 35%.
> >
> > Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> > ---
> >  .cirrus.yml | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/.cirrus.yml b/.cirrus.yml
> > index c2f5fe385a..e114ffee1a 100644
> > --- a/.cirrus.yml
> > +++ b/.cirrus.yml
> > @@ -2,8 +2,15 @@ env:
> >    CIRRUS_CLONE_DEPTH: 1
> >
> >  freebsd_12_task:
> > +  env:
> > +    GIT_PROVE_OPTS: "--timer --jobs 10"
>
> Why these prove options?

The only problem I see with it is that its `--jobs 10` disagrees with the
`MAKEFLAGS: -j4` below. Either both should say 10, or both should say 4.

> On other CI systems we pass 'prove' the option
> '--state=3Dfailed,slow,save' as well to reduce runtime.  However, this
> only works when there is a persistent place for prove's state files,
> e.g. the cache feature of Travis CI.  If Cirrus CI lacks a similar
> feature, then we can't benefit from this option, but it'd be worth
> mentioning in the commit message.

We also don't benefit from this in the GitHub workflow because there is
likewise no easy way to persist the state.

> > +    GIT_TEST_OPTS: "--no-chain-lint --no-bin-wrappers"
>
> Why these test options?

I guess that's for the same reason we use these options in the Windows
tests: it speeds up things for a historically pretty slow build axis. At
least I seem to see FreeBSD runs lagging behind all the time.

> chain-linting is done by a mighty sed script; I think it's worth
> running it with FreeBSD's 'sed' as well.
>
> Quoting 't/README', '--no-bin-wrappers' "can speed up test runs
> especially on platforms where running shell scripts is expensive".  Is
> running shell scripts really that expensive on FreeBSD?

I don't think it is FreeBSD per se, but the available VMs that make this
speed-up worth our while.

> OTOH, why are there no options that would show us some information
> about test failures, i.e. why no '--verbose-log -x --immediate' like
> on other CI systems?

That's because we don't use the `ci/` scripts at all, and the failures are
not actually shown.

This is a mild annoyance to me, I have to admit: there is very little in
the way of actionable information whenever the FreeBSD jobs fail.

Lucky for me, I've so far only encountered breakages that _also_ affected
the macOS build axes, and therefore I could diagnose the issues in the
GitHub workflow run logs.

But yes, it would be nice if the FreeBSD CI runs were more helpful in case
of problems.

As far as this here patch goes: I am in favor of integrating it as-is.

Ciao,
Dscho

>
> > +    MAKEFLAGS: "-j4"
> > +    DEFAULT_TEST_TARGET: prove
> > +    DEVELOPER: 1
> >    freebsd_instance:
> > -    image: freebsd-12-1-release-amd64
> > +    image_family: freebsd-12-2
> > +    memory: 2G
> >    install_script:
> >      pkg install -y gettext gmake perl5
> >    create_user_script:
> > --
> > 2.33.0.rc1.379.g2890ef5eb6
> >
>

--8323328-1871771184-1628980146=:59--

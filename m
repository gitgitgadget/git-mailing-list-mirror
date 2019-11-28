Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C728C432C0
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 22:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE1621771
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 22:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="R4xdQpX6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfK1WRj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Nov 2019 17:17:39 -0500
Received: from mout.gmx.net ([212.227.15.18]:35715 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbfK1WRj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Nov 2019 17:17:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574979448;
        bh=aQHIORytZ7nmbG0AF9Tluwm1pqTbv4z9CI9v4VuYoM8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=R4xdQpX69kV7YyLiW7kY6CgPd2EhBZPR0GC89/aLhB856pEMCfVtmWgBbhShHBz2E
         2r1irLeP3fdxWWd7HnwOmEDLXFBVAfz03RcHW1dHKdakNDpDnn3f4TP/ax5QygFJ23
         /t+foN+l8nTpC4w+wV23PJN5+0vBZTUo0p377N74=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKKUv-1iMuUZ1HbT-00LjHW; Thu, 28
 Nov 2019 23:17:28 +0100
Date:   Thu, 28 Nov 2019 23:17:12 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Wong <e@80x24.org>
cc:     Jeff King <peff@peff.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] doc: recommend lore.kernel.org over
 public-inbox.org
In-Reply-To: <20191128194829.GA15521@dcvr>
Message-ID: <nycvar.QRO.7.76.6.1911282315570.31080@tvgsbejvaqbjf.bet>
References: <20191127125231.GH22221@sigill.intra.peff.net> <20191127125343.GA27983@sigill.intra.peff.net> <20191127125936.GA9877@dcvr> <nycvar.QRO.7.76.6.1911272059050.31080@tvgsbejvaqbjf.bet> <20191127200421.GA27456@dcvr> <nycvar.QRO.7.76.6.1911281123100.31080@tvgsbejvaqbjf.bet>
 <20191128194829.GA15521@dcvr>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6FFL/4WlFPU4vZLkeQyHdKg18YYe6wBj/995iIWCTeM+Ihu4kZ1
 1YpGy4ql7I2j8A0l2ikLk0OM7hDu3tfJ8pHmBSTF/4e4KsABiGQIzCh+Z/UH+vr4ZiUsiq2
 k7Fy7zmzduDET7chdhNQYJAL0Um9epY9J5P7+ZtI8OBlxQFnmp62RUj3bQvj4Sqr/49CH3Z
 CO5Dj1BmdhaZ96FGGvNkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:38lRdATB+vw=:MJyJ9xPP3NLWMk0KWWqasX
 WrBIuy/QegIn50uFP1xU12r/xQuw4WjrYV7zS/hFU877AYx7K7sKYeXfxo3m6inmSwVNAMRHs
 XaCSgIT6ZEkfJVhbwM0VC0eZWMptbLm8vlt36LhdnEuu4OujkTlcQSEHKw6qVdrUk+tFE8LD+
 lVV4v612ts8sWNL9meTnZ66jc89JnX213w2VPPJNvkoLCaSG9gj4eKbc+tgCPIKr00aiWTM/w
 IXQjShNzPDm5bSYOC6JtcSp0rzC+G/TToOaum6HUvNsHkbHtUfq89S1M2p5ZEeN9tyOk/eYwm
 u/AXgjsebwPb3mJb/QF+Df1kP7jh5EnvVUXa5mkVmuA/doDzNGAkKOmZ11cnfe2Hy2pqwlPPg
 m/KOcNT2E9sIAH1k+lY6XRzRUwMhJz3Z/z+AFIGXPwv4XxdcpqElc7N2AG7yFhPfKq5wjstjT
 gDufZedJywOrIyJd2TEeuHUAFqBTtg9mhNG3O72OIhONQfCOXY1hWM3JC6tk0KTKNUPc610Tn
 bFSRPioFwSGvTRJrsC9BX71pHwR2nwo+lhzF+X3Ck3S/rXqgB9QKnRMkY8lO4ZaAS7a4CqOST
 LeZoLXsC1UJcB48bR5sgZSS1GQs3oroSDEcKygQbMQSmgzGxUUJfRxEzyFpFqWPxD3WwG/wou
 tbEw2h5pAxJtG1UOXdP4Fe8NduO+VUzzF9xaeri1XKpN2o9iEYC46Ebu3BKiov03jFQSL4rWS
 317Kvzic84U6yRiDZz1N0FU4TTqMyu/acJb54m6Ra3IdrJ/Xq7xGP/L/kfL7bYtRsiQYiqQCj
 25CvlDdwLirCt1xJ5mAjg5tM0FdsYUSuMPT1fZk3BunJfXGYCUonw4tTwoK2+0OLsnhydbRVY
 XFzTA7PnLEHuwDnhjAc7KMned+Ws7M6nWqwNVMLnBjLoqsH3q6Sjcsiffmhh/YBmI3B5hKWb3
 dHgZ8k8VXF0QXoA2KYBvoPznq9arIuWFkn/IGk6gfSWsMpPrPWDuZO06fM7HNnN7deJI47RNP
 FWsNZGQKIcJHDmZPd8XkZAzFdoOCly80ihMStHOwTuY90Jnc1VvrXJgtXxX299O3S9MCjd1zD
 +n1wkFZMjIxFCuqv5eJrrUwHV78Dssb+JcnCZfDk1iKX7g/gT5DSgNCKrIKQHeA0kWfbzxH/9
 IhlHlBzUQQvWBV3Unj2MBD6cqL723VipwfeQWtB6f5azXjWHpI/wmIGV+8WZbxZ+gc0VCQDVq
 4HCGfDQVzNkk6AsATL/OvEIsTdu+a76M0uR83QZh6tF6U+K/BBhzTA4dCJw8=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Thu, 28 Nov 2019, Eric Wong wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > And: if I want to track the latest mails in GitGitGadget, what indicat=
ion
> > will I have that I'll need to switch to `.../1`?
>
> You can use the gzipped JSON grokmirror manifest at:
> https://lore.kernel.org/git/manifest.js.gz
>
> grokmirror could be a bit of a pain to install because of Python
> dependencies, so periodically attempting to clone the next
> numbered epoch ought to be fine, too.
>
> I've also considered adding epoch info into
> https://lore.kernel.org/git/_/text/config/raw
> so shell scripters w/o JSON parsers can use "git config"

I just had a look at its contents:

=2D- snip --
; example public-inbox config snippet for "git"
; see public-inbox-config(5) manpage for more details:
; https://public-inbox.org/public-inbox-config.html
[publicinbox "git"]
	inboxdir =3D /path/to/top-level-inbox
	; note: public-inbox before v1.2.0 used "mainrepo"
	; instead of "inboxdir", both remain supported after 1.2
	mainrepo =3D /path/to/top-level-inbox
	address =3D git@vger.kernel.org
	listid =3D git.vger.kernel.org
	filter =3D PublicInbox::Filter::Mirror
	newsgroup =3D org.kernel.vger.git
	nntpmirror =3D nntp://nntp.lore.kernel.org/org.kernel.vger.git
=2D- snap --

Isn't `inboxdir` and `mainrepo` incorrect?

And yes, adding `epoch` information there would be very welcome.

Thanks,
Dscho

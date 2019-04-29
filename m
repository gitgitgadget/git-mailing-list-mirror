Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F298C1F453
	for <e@80x24.org>; Mon, 29 Apr 2019 12:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfD2M2n (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 08:28:43 -0400
Received: from mout.gmx.net ([212.227.15.19]:46277 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728006AbfD2M2m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 08:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556540909;
        bh=g14TfcTvrFtTncfK82TG6YeR3nbZCoroMQk3LHFwNOs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gRLgnnMn1gVEDuhC0HMKlXlsq40pvu5TUnDSGm1QjaDRVkVoywLQZKEkrpoDdqirB
         6PIQd/dSEY8hw9p6WUz2+PpzzLUirlVvozu2PZDQcsALJ6lJXoaPqYDoPVeXpJESzh
         LwvIdIhe6AkeBWFDGXQMh7DzBBvL2IM5zBHL86OU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.106.210.16] ([167.220.152.16]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MAgvb-1hVlh81eVH-00BwGz; Mon, 29
 Apr 2019 14:28:29 +0200
Date:   Mon, 29 Apr 2019 08:28:31 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 5/8] docs: exclude documentation for commands that
 have been excluded
In-Reply-To: <xmqqef5yefkg.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1904290828090.45@tvgsbejvaqbjf.bet>
References: <pull.168.git.gitgitgadget@gmail.com> <pull.168.v2.git.gitgitgadget@gmail.com> <f8d133c59725938afa85f6be349c2bba05fe98e7.1555593396.git.gitgitgadget@gmail.com> <xmqqef5yefkg.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dDyMCdSoBXifO2SPxlQPVjaDzr6K2tVCQUI83muVVrH6p1ITE9C
 WuSDI5aTPbfyq4pCexAQsTeugIxxnO6Gb1vFikBZlUkKGyKljcITzf5FeXwcEfw6dqaMA5d
 9+ixVUz8/XqXvSc6UUZOksaYsim5NnIUab4jwfvFHyeax45dCwgVBETyRCFh7nzjovK32m5
 3qNmxMKCJZMicxO+UDRKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aJqy+Zn6pkU=:ERqR6KJoJTiA51f/jdfESp
 Vl31wpLvHVaC7Q93hmBMrijPU6yWcTYG3DSXBE5C2UPPu4ijus/OfiLjqEVJyCoJH1P/RioeH
 TFFYidyY+0YBeGD9w970FzfHYmOpMDvQM3rzh/vkDUtHakMoYkSEDl4tWh3w/bbp+bc+Ekadi
 8NbxpXag+pJaLLg0jKw9X6aF0t85rr5JhRZhtfp9jNv50P6VhjecDa2JDbrSZ+jKZRIsJYX2L
 cxAUUdn0H9t0DasDotL1djvHsNQFC5bMrvOcKQr6Hh/yPO9cbLMmflv7DKu2b+vnhrYxj9YgO
 owV6541tuSnOi3z4yULt39cKUUcfgXYl8R6DnDhUqf8yVLN3hBnmCU1nIkF6KaRzQnXNY3oLR
 b6FgoY4oTpYPSl2I0XGZvTM5CoUGzNbnNbyc2WTAdU2AgQYgi9OaoxbUyUunEbsErln1kkNqh
 GeC7zFRbcRuDepFcNcAaix9L/O9lIE17pBYnXQvK2fWcohK079QC/NPs4bv3RtNT99qVFlHJW
 2KCE7WHT02mTBbCeGcnxpdI0NEY2AD0jdc8mNNYCrfH8XupDYhHkZlltY8cIqKXIYMEjIP1Ed
 mKEVbDVE2uZO6Yx/mtn50rcZGoHyv0uWL4+BO4kHCo+/QthZht+lphmzIKq5gwU2eAAZRed88
 SoZ3G8tBDU8IzuowPcWD0OspCZ5Fnu4ZvOHYWCqFPFUIBc4GyuOLMBE2TJI0KVCCaZabwXY9L
 CnT+NJX3FzB6lydubQ1oNG4gA4RBttAdxcXFPWXfi2mc4ycfrT1vGr2kmn7yTE81gUMhttp0a
 pdX+xHs3wUEHagqOw1hKUnGSMyFVAbDtBz47pqrMFFTAhJcSTIo8YGYwi2D2D0/N5n4K0i3LM
 OxGq0lWV1jZOM7EbP+dfXSSHR3hKTLCoc16XDUccAP+v1DwXnbO4DH7qhTd/R93TpzoYy7tgK
 mLHhCxEqclQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 19 Apr 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When building with certain build options, some commands are excluded
> > from the build. For example, `git-credential-cache` is skipped when
> > building with `NO_UNIX_SOCKETS`.
> >
> > Let's not build or package documentation for those excluded commands.
> >
> > This issue was pointed out rightfully when running `make check-docs` o=
n
> > Windows, where we do not yet have Unix sockets, and therefore the
> > `credential-cache` command is excluded (yet its documentation was buil=
t
> > and shipped).
> >
> > Note: building the documentation via `make -C Documentation` leaves th=
e
> > build system with no way to determine which commands have been
> > excluded. If called thusly, we gracefully fail to exclude their
> > documentation. Only when building the documentation via the top-level
> > Makefile will it get excluded properly, or after building
> > `Documentation/GIT-EXCLUDED-PROGRAMS` manually.
>
> I certainly know where you come from, but I am on the fence.  Being
> able to omit documentation, without thinking, for what you do not
> ship is surely handy, but at the same time, being able to format
> everything you have the necessary material for is also valuable.

I guess you need a maintainer's mode ;-)

Ciao,
Dscho

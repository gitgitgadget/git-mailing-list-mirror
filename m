Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62C3120248
	for <e@80x24.org>; Fri, 22 Mar 2019 13:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfCVNRv (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 09:17:51 -0400
Received: from mout.gmx.net ([212.227.15.19]:49211 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbfCVNRu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 09:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553260658;
        bh=49TGaXPbHDvgaduuLsBOmur62TixLTP+ew2cCM5lvVo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Wxf0lEF0gpGvHaJyXQmGtkq8a3k2b1lyVGEMugjjhRqffqwJEK+K7x95KM74FiFGg
         uAMpQS4xQuf/KyneYKdzJreLu/JZq0kgpo/u1hh/eaGg1u5QzT5F/eIuySbsLGyPZu
         Bh2J/rwZxsb2GpqWB5R3OtzDJ9PBA/F6brsi1X3g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LngNT-1gVXvJ2kzn-00hxvX; Fri, 22
 Mar 2019 14:17:38 +0100
Date:   Fri, 22 Mar 2019 14:17:22 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/15] Trace2 tracing facility
In-Reply-To: <87mulocmgz.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903221416230.41@tvgsbejvaqbjf.bet>
References: <pull.108.v5.git.gitgitgadget@gmail.com> <pull.108.v6.git.gitgitgadget@gmail.com> <87a7iyk0r8.fsf@evledraar.gmail.com> <0aff8302-371e-cb5e-fe5e-f08e45456559@jeffhostetler.com> <87k1gxa8cm.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1903211528090.41@tvgsbejvaqbjf.bet>
 <87mulocmgz.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-962455917-1553260658=:41"
X-Provags-ID: V03:K1:ZdqmH8+Q/hezwi1tnnD2hibxuLxFFyVQgjyPgUQjAWa5mSxJq83
 Z5VieTm36Ku5/rF/u/IM2105RxVrGF1iT92l0x8HcrSYmf2pWATGGJVSTRgr5YCav2nxpqP
 mG6AkqiqAeJUgf9ybVhzOX0JCV0vyYZDRIAjoTIbC4fuhBx4xluCBTWaq63xO79iTva+7Zq
 a+DXPcJdrMHBrPfdIJ1wQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C5HlhE+QRhE=:/J/Ko+5BFIlxA3zCX+bjvx
 G+Z7mUA1JdBFqiaV2ISokj2ye/PX5KtYsYxzBe2pyd9VnJTn1mOkTbuWEhhgVqAK8wefb1ne2
 xjIlMllma6OPyPiPiS8AWk+B7GCIr3N6eH8eMgSaMN++ok9bGEZsizZ/imgzbK/Drn9NQBHht
 j985l46toNp6hlRBFb+mXGRRrHHGC01VHtxLsoUyfOtooSZNM9yD9+jmv0HGMgwFs++VRJKmh
 nBV8Gh4OeJ40qqmUX/19TdWRpmMwy8+I14FAl4h+/9xHDfcGBdXHWqLgFmKQ7Vm3Q6pNNl7KC
 C0IgMp3VgC8kgKJaXX9Fxaq3Dl26Sw57Jud3kWDIVjxfCe0XpZGedTbqmgbLnZf+46pNCdOcl
 5bwSq10lAkYrmK2XVUysxCTTnbYoLsWjFPmw0Wg4UhtibRjAIA6rXCnwhkTHBqg3MqpjHfvLR
 0GyfPyAssFykLm0p2cXz1ZbAEoBQtrQ8p7BkZOH7+K+HA/g8RX2Kaxold9WCXVG/i2VMfFEhS
 8AH3WrdsyGQOfCsWdnl7Yppa0p783Jd1bBRPM0XJTJ9QJ9Uxqk/fED6hVY67v4//mT66WNL69
 08jnyCQSH3jjIIqn1xWQxEJ7jbu9czwtPGR4sgIaC9E55uuE2EIlhCfx3ngyJ5tttYTpxC3AP
 xlnpKYwfRrKJQhALh/E56E3iFJdJwQu/YoEpY7G750PI9ECXze54jfWLLisjzRarkTN9kdSwK
 HHZjgNsiulEZXXlWVCVsrrcSbS1c01UFDVLoPbe1didwLg2tVoTaIfO5DLPsk1+1gCnPM3crk
 urhuEdEQx4xORjrVzkh2h2vr4cVRp5Qn0vboSciXvA/KIILV3OqTHvhYzgamAPv1ncXmLbxWH
 uSEd5BqUV554Vk0a6+0K4ITiVejF8iT4WrT3G0pZj3yiPZuoquwcT86nDbcJ1bGPwl5rDrJzR
 arYOgvwUSQg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-962455917-1553260658=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thu, 21 Mar 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Thu, Mar 21 2019, Johannes Schindelin wrote:
>
> > On Sun, 17 Mar 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> >>
> >> On Fri, Feb 15 2019, Jeff Hostetler wrote:
> >>
> >> > I could see having a "~/.git_tr2_config" or something similar in
> >> > some place like "/etc" that only contained the Trace2 settings. It
> >> > would be safe to read very early inside main() and we would not
> >> > consider it to be part of the real config.  For example, "git
> >> > config" would not know about it.  Then you could enforce a
> >> > system-wide setting without any of the env var issues.
> >>
> >> I haven't written a patch for this, but it seems to me that we could
> >> just start reading /etc/gitconfig via some custom config callback
> >> code early as e.g. 58b284a2e91 ("worktree: add per-worktree config
> >> files", 2018-10-21) does for the worktree config.
> >
> > Oy. Oy, oy, oy.
> >
> > Maybe use `read_early_config()` instead? That would be *a lot*
> > cleaner. You could maybe use a9bcf6586d1a (alias: use the early config
> > machinery to expand aliases, 2017-06-14) as an inspiration.
>
> Thanks. I was thinking *only* to do /etc/gitconfig and not the whole
> .git/config -> ~/.gitconfig etc. sequence just in terms of saving
> critical time (this is the performance trace path, after all...).
>
> But on a second reading I see that read_early_config() can do that if
> you set config_source->file, opts->respect_includes etc. I.e. it just
> (depending on options) resolves to git_config_from_file() which
> 58b284a2e91 used directly.

Sure, it can exclude the repo and user config, but would that not be
rather confusing?

Ciao,
Dscho

--8323328-962455917-1553260658=:41--

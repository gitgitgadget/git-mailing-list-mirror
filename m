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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BB1C07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 15:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B594608FE
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 15:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbhGPPyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 11:54:04 -0400
Received: from mout.gmx.net ([212.227.15.19]:38757 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233725AbhGPPyE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 11:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626450663;
        bh=/PvZzGay4ucCw3uWx9WAiin+fTBg/k+jiQKkRNDRK+g=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UCZFF5S2SzKKI23dJTQqQNYc1IotCATHnG5zjT5+eyXEq2npT0+ldYcrWFO0xHvSe
         bb6c+TO6BEsv+4P0tbthdqJoiRxRSnv8F3VucAff0DZOMo4ji85U+IhzFYvWyYFbS0
         o9suLtUfYf2bPh/tGEymrAlMJMtIVqE3xGa9oM/E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.111.2] ([89.1.214.95]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MsHns-1lGIEn2cgM-00tlay; Fri, 16
 Jul 2021 17:51:03 +0200
Date:   Fri, 16 Jul 2021 17:51:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 12/34] fsmonitor-fs-listen-macos: stub in backend for
 MacOS
In-Reply-To: <87sg0xbq9v.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2107161748050.59@tvgsbejvaqbjf.bet>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com> <pull.923.v3.git.1625150864.gitgitgadget@gmail.com> <587580489473a7a2ad665bdf3c482ea5d2c54f61.1625150864.git.gitgitgadget@gmail.com> <87sg0xbq9v.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1769554384-1626450663=:59"
X-Provags-ID: V03:K1:wbC/275pHmHZaj3HOx8Ink4bbZD8YXOq27qZ8IiCCpBReAMLf46
 IUOPwbAVV3jbp2polf4qyHp7q5gTEOW47YTzUSqDAQtW+Q95mAle6Qc8DMUTbj5GOhlZGFs
 77HeXRM0vwd74zFqP2yGZd6dxZukUHfmycL23QjOsgXSGihxI0A/IVrpH8VE4W9g/mQ8eHG
 zwEr6agOnH9TTF3EwXSJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oFoULrMYIv8=:Em0iNHT2tJq+FdR73ArDuN
 l5kvLYc78aN7c5vlICahEwBscJKpcZhgnTmTi7hcOFJmI5mfEXRnSjNi1PgPQMw7fjc1Ft/g7
 EGevtD1uZess1stsfc5qtqlJEti4g2UGIxmE1yfDprdSvET5981ZSSOesANLCiyCmI48ISQJN
 s105XuMUS9f9HqjScfbzd6gT+rVBCN5c+wZ623TOe0tS2w6mAe2PbCHUI3VHUA1bWWTJ/AoG6
 GOAH2sgz9KijcXuqLphgtwSA8AMXURtNwmiRLcKsnYU7hpNiVLRwioFPGI1lHc464URcSbnUI
 grfgrkwsbiPb9GwVhp1G9Fr/r7mvPoUaD9zn3XPQpezFr+ySKg5PNCNPzVo4wvVsP7yM+tHUw
 WIr4l8qkpSWqh84o1aTxTDdrBapWQiGpvqT+s8ZWF2IJ22MPQMzCgx0YiGf2/PYsK60g0CdMz
 90rfHjTrcyGJEyHdwH2OjjqVMOPLLtj6Q4jAeYNP4n858TKm9JMp980ZigTMcKUwaIhEPHmft
 3baaUnO7k608KcoNKcnDk6AEQBlFrA0UjkId3+WiGZQNEKw3hR8oOGHvNgq1H5W7vYcKoF6KM
 4RgR7hYMny34mv21cBSr0p8cNBRIHO4UswhmBqZT44ACCv+cjUPOcnpEMTjimDDKtbmLchDB/
 BjNMciYFZypE9/K3AbR2jRoOL8PavMr54QiRV5PFEIgTA5DH4o3TViXSB5EDDmgbUSugMpE6p
 tvDDo+DUREtkOS7XI922P1FvNOAFFbbI076DVyuKHnYM9OqiA9yujbf6M6sRDnqBmQ/EgCsuo
 1e/DW1zvLmK5uO5kgjJtpUTvKYl0JUYWeNNPuXYmRmqyg0FgbbXlTYhE7adi1b+RemKfc2SCO
 /uXk3ejH8V8QA1zJyEkzxaUB2btmM7cSIrW845tfBueXHpGtkAlEojj+bPBfCmjVoVi1oEQxA
 PJ2KXRy76J6BPbUV6U66IMzlyDdbxDkEBFC1Sv22C60+03/ETQOlTiNL5FzqpSDPUT5hdXS4q
 ftuQ+9r78raVuqL14jo8G9c3f4iBVPjJ93nWdXATo+3U6mQ2Hlry5wDuV2jFaJd7TaTW1zP7j
 o2VZ6vgsPlg1hA69HrtJJPxn41UXvxHEr0wZEwkkZFQflgAH5LY4qno4Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1769554384-1626450663=:59
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Fri, 2 Jul 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
>
> > From: Jeff Hostetler <jeffhost@microsoft.com>
> >
> > Stub in empty implementation of fsmonitor--daemon
> > backend for MacOS.
> >
> > Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> > ---
> >  compat/fsmonitor/fsmonitor-fs-listen-macos.c | 20 +++++++++++++++++++=
+
> >  config.mak.uname                             |  2 ++
> >  contrib/buildsystems/CMakeLists.txt          |  3 +++
> >  3 files changed, 25 insertions(+)
> >  create mode 100644 compat/fsmonitor/fsmonitor-fs-listen-macos.c
> >
> > diff --git a/compat/fsmonitor/fsmonitor-fs-listen-macos.c b/compat/fsm=
onitor/fsmonitor-fs-listen-macos.c
> > new file mode 100644
> > index 00000000000..b91058d1c4f
> > --- /dev/null
> > +++ b/compat/fsmonitor/fsmonitor-fs-listen-macos.c
> > @@ -0,0 +1,20 @@
> > +#include "cache.h"
> > +#include "fsmonitor.h"
> > +#include "fsmonitor-fs-listen.h"
> > +
> > +int fsmonitor_fs_listen__ctor(struct fsmonitor_daemon_state *state)
> > +{
> > +	return -1;
> > +}
> > +
> > +void fsmonitor_fs_listen__dtor(struct fsmonitor_daemon_state *state)
> > +{
> > +}
> > +
> > +void fsmonitor_fs_listen__stop_async(struct fsmonitor_daemon_state *s=
tate)
> > +{
> > +}
> > +
> > +void fsmonitor_fs_listen__loop(struct fsmonitor_daemon_state *state)
> > +{
> > +}
> > diff --git a/config.mak.uname b/config.mak.uname
> > index fcd88b60b14..394355463e1 100644
> > --- a/config.mak.uname
> > +++ b/config.mak.uname
> > @@ -147,6 +147,8 @@ ifeq ($(uname_S),Darwin)
> >  			MSGFMT =3D /usr/local/opt/gettext/bin/msgfmt
> >  		endif
> >  	endif
> > +	FSMONITOR_DAEMON_BACKEND =3D macos
>
> A rather trivial point, but can't we pick one of "macos" or "darwin"
> (I'd think going with the existing uname is better) and name the file
> after the uname (or lower-case thereof)?
>
> Makes these make rules more consistent too, we could just set this to
> "YesPlease" here, and then lower case the uname for the file
> compilation/include.

So you suggest that we name the new stuff after an `uname` that reflects a
name that is no longer relevant? I haven't seen a real Darwin system in
quite a long time, have you?

I don't find such a suggestion constructive, I have to admit.

Ciao,
Johannes

--8323328-1769554384-1626450663=:59--

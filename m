Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F14491F407
	for <e@80x24.org>; Fri, 15 Dec 2017 15:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932229AbdLOPc7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 10:32:59 -0500
Received: from mout.gmx.net ([212.227.17.22]:57659 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932072AbdLOPc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 10:32:58 -0500
Received: from [192.168.0.129] ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MNf1y-1eN7tS0g1q-007BLc; Fri, 15
 Dec 2017 16:32:56 +0100
Date:   Fri, 15 Dec 2017 16:32:55 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 1/4] travis-ci: use 'set -x' in 'ci/*' scripts for extra
 tracing output
In-Reply-To: <CAM0VKjmpJ_J+GjJ3PyU_pxsWx85L6cPa2tLM0xJx3cJu2T87Zg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1712151632140.406@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <20171101115535.15074-1-szeder.dev@gmail.com> <20171211233446.10596-1-szeder.dev@gmail.com> <20171211233446.10596-2-szeder.dev@gmail.com> <9AAC2BCC-AA06-46F9-8E6E-1D99CD959FDD@gmail.com> <CAM0VKjkVw8QeDErDg9aXcQ1sAgY34eBEeA0QJGamvEEBOG8y9w@mail.gmail.com>
 <77E6AE23-44FF-42E0-94FF-C4B35D913D5B@gmail.com> <CAM0VKjkv0XqHf8s94Wj2DHsD49gTP0M6HU2AY=36Jj-5SYhS9A@mail.gmail.com> <alpine.DEB.2.21.1.1712151308230.406@MININT-6BKU6QN.europe.corp.microsoft.com>
 <CAM0VKjmpJ_J+GjJ3PyU_pxsWx85L6cPa2tLM0xJx3cJu2T87Zg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-639650515-1513351976=:406"
X-Provags-ID: V03:K0:AIxG4PFCUYjJ5U+s9OPE18STVTa3NcIi67nJno4Apcy6YOvFsGT
 epBFjpEE8yk4eFSrfYGlI7UvbBGvTDpU7Hklg2Wc5QY2mlgtsYMlbcF5Fz72j4VdHwOk3YH
 6hBwkIynnt+ldEEAy5NSsjFJmiywTpzjFZLR+c/DB2Qt/g72kWrW7JWocETz/2bQrfjKpve
 yNK2C7XuP+pkyG2jA2XsA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CG6474DzWUk=:jekDi0V8hiThA98LqqWOP/
 taeZMULVy6mbZi6oWG3g1AM40ye+f1UwtWasbD7uLncJ/YOTeCT9qpKazrHGRE+YDAb1Jw8vF
 x9W9zzbdEMKlFZkjnptu+YdC4asVzcSHJTrU1oVmQeuOjw2nLk22h8A7PuYnSWefQj1WqWskR
 rXjw8MU2+S35kJrgpV//AcuMEy8pf3mS5NquhXlBUoliKsO+si38+4YIjWbhlZYOGeY9k0E+e
 RmiYmezEoFQXS6VceDClE0O7q62dufB7DxGy2OlG0kkdJXV03coqkQVpBlC83eMQYPc6MOmF+
 xsx30c8w39l7FyGFDsf9i8Edil0yj1YrkByt83205Y6Edgn3DXsM3UcDc0ovmMczQT9CNRMWN
 MBqe2x2HXlIH8xTuY0BccRJoSSmdXIE1Q/ArqWgNFm3jjLdadNfAJMXJR/SAuJZ1LzGIX6YZ9
 wot+EWc1pQypVx1bQnEpUedb65tw+5nDfgd7/DVn0wbgQ4GCUzFIZ5YeNRciOqfmND1z1X0Xb
 BfUsCtsdbslJOlOVZmq/k9Cr1fB3Vkih87+npcFhsgELanApCSnffUL3M9ffn8xkINJ42lPX/
 QBf9Hu/4KJxYAthqmd8zowj9cZrO5+DDfBKzfUnqnoj4NJ4ybZsGS5RWgce/nQKtt1U4haAdT
 7janCNGS8ft153KQxsodTMKBp4XC4IaIu3xTaoZzeC1FRvUmS0JP5kHXOc+OIIZbuzfQgYnDe
 T/ZJ7uTZi64cnvj3LZAjLB+cKlPEdH/+LlI8SOGwadfrnokS0mc2EIo/IlCfmpn12FTBL13BH
 nM9q+ks7HT1XcOP1YlAcUvkL7ki5iKmtC+GUz3a5oI/IArcZOQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-639650515-1513351976=:406
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi G=C3=A1bor,

On Fri, 15 Dec 2017, SZEDER G=C3=A1bor wrote:

> On Fri, Dec 15, 2017 at 1:10 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> >> There is a lot going on in 'run-windows-build.sh', so the output of
> >> 'set -x' might be useful or might be considered too much clutter, I
> >> don't know.  I put Dscho on Cc, I think it's mainly his call.
> >
> > Certainly it might be useful.
> >
> > However, please make sure that the secret token is not leaked that
> > way.  Like, *really* sure. Due to the failure of Git to use a portable
> > and performant test suite, it does take about 90 minutes to build and
> > test a revision, therefore it would be very easy to DOS my build
> > system, and I really, really need it not to be DOSed because I use it
> > in my day job, too.
>=20
> Ugh, I was completely unaware of this issue, and the first version of
> this patch is already in 'pu'...  **runs to check the trace logs**
>=20
> Great, it seems we are in luck, as the secret token was specified as an
> encrypted environment variable in git/git repository settings on Travis
> CI.  It's redacted in the trace log [...]

That's good enough.

Thanks for making sure,
Dscho
--8323329-639650515-1513351976=:406--

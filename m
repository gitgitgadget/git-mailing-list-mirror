Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADA8F20248
	for <e@80x24.org>; Tue, 26 Feb 2019 22:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbfBZWhf (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 17:37:35 -0500
Received: from mout.gmx.net ([212.227.15.19]:52515 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729030AbfBZWhf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 17:37:35 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M2cYX-1hEucl0Jxl-00sODu; Tue, 26
 Feb 2019 23:37:26 +0100
Date:   Tue, 26 Feb 2019 23:37:10 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v13 00/27] Convert "git stash" to C builtin
In-Reply-To: <87r2buusud.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1902262335270.41@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet> <20190225231631.30507-1-t.gummerer@gmail.com> <87r2buusud.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1594693050-1551220646=:41"
X-Provags-ID: V03:K1:+LjcFssomtsW2dtvJHnMYsELFVsjs0/M8OvvZlb1Wxt0g4q8GK5
 JqWU7o1JnAiTBioEiPXneXKJ53L1HwwnkKpEWWTIx7OL0IcM4AXfF+6sg0Pc0c3SP7TcvSO
 m2Nr9wbWW71YjK3EYh2iVXqGZC1fjBg+hjEp4j1IgtNEhhqDCegPKc7q3/QNGEoc3WdZx1d
 b6yX4YaG1wlo1LZwuQXmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZR7tnyBmmgw=:VV8Xx0PI/ImQm39D+oJ5WC
 +rVDWqPcMj4NAaMtuwI1Ywr7uFdYLutvj8IdiYJ6vbVWU/ua6PZkwxX2Yhi9fsfxOTI+geZYH
 FhJbbARd6QbS7dyv9x+efhnCnXkroMt6mOjWN4xb2wdSOjPXZ8WySkk8CSUQAqhfGeWie/2Sf
 45AT0KWp0FsoMQwNQ8fJ7TzMAxLLDo63V1LsZGwfrsTpwVfiLdImGrX/gQhij9V724kU6VOsS
 yWBn5ZWXlTffNu5AdS0qjg78UIK6IbmMGCuMHEe3C7mSx7sQOTi9u5QGyt1VETD/DvEzS7OIp
 NNSG9fmt+3Bm6IU29KjcMdY2gTL0dqDlyMFTNZuIzaDux6SkUPRnWcI1TaoKqM/gdRIjiJ91t
 reG+Mla0FtNUdmv8EtV/akJc95qpos09d3F9dsyf8/HC7xhEAlCDqcGGPSifo9NBKWtwz8T1H
 JtpIy8i8gwBGHBc/ekowLruNgmLChvBrU9zjGPxJXNTCRSxCNFZfX4XUPkJjAdW5j7p4Qmvp8
 itFlIBe/2BdYQJ5hZWQD23hncS5hZesC3IFmm128wMH+ri2nrQJvW6rhagFrHACkxHUmZgA3i
 ZPjG+WSMqumCenf0ndECdL2dmV0inLqm/AuMqjGIiVLq8FuN0CFJPyZVaKD4V7TjDfx5N5Bqe
 vPzUC9rzK2beacKU38nOi7S9WOYJrw/dHOYYtr5woQ7S35hw7xcedOo1hV5cUvfTRlF/Tn/qt
 0al7DY5fRrxUajMu+0/uLQmGbZDQiK9Ins7EhRnxcY1pP7z01eNrJl+0vpJsUhRZljfuWVtda
 pXjSLgsHGkdeS61WCbbKBlMCK0oj7EU3EUDmGLI9723faFqH67eVwiFpM0B4Cm6RoR32n6Wdn
 /iO1rc2WrTfLJgFICJKCyQxZzhSBW8fwLesOhhMb7Q3DgJ4PGnbPCvuIRIcmxyiNbC+7N686e
 QLAhvb4UGIQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1594693050-1551220646=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Tue, 26 Feb 2019, Ævar Arnfjörð Bjarmason wrote:

> 
> On Tue, Feb 26 2019, Thomas Gummerer wrote:
> 
> > As I was advocating for this series to go into 'next' without a large
> > refactor of this series, I'll put my money were my mouth is and try to
> > make the cleanups and fixes required, though without trying to avoid
> > further external process calls, or changing the series around too
> > much.
> >
> > One thing to consider here is that we have a GSoC project planned
> > based on 'git stash'.  If we can't get this to 'next' soon, I'd vote
> > for taking that project out of this years GSoC, and maybe try again
> > next year, if nobody implemented the feature in the meantime.
> 
> FWIW I'd like to +1 getting it into "next" so this can be given thorough
> testing in the 2.22

Indeed. It is time.

> If there's still bugs or other regressions I think it's better sorted
> out without the cognitive load of reviewing it all again.

Fully agree!

> Worst case we can always add something on top to flip the default of
> stash.useBuiltin.

I actually don't think that will be necessary. If my track record with
fixing all kinds of built-in rebase corner-case bugs leading up to v2.20.0
is any indication, the built-in stash will be cooking well.

Ciao,
Dscho
--8323328-1594693050-1551220646=:41--

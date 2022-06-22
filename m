Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8A7C433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 14:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiFVOct (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 10:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357218AbiFVOcq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 10:32:46 -0400
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Jun 2022 07:32:45 PDT
Received: from hekla.abc.se (hekla.abc.se [158.174.61.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E183B3EF
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 07:32:44 -0700 (PDT)
Received: from orm.abc.se (orm.abc.se [158.174.61.226])
        by hekla.abc.se (OpenSMTPD) with ESMTPS id 559495fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 22 Jun 2022 16:26:03 +0200 (CEST)
Date:   Wed, 22 Jun 2022 15:26:03 +0100 (CET)
From:   Peter Krefting <peter@softwolves.pp.se>
To:     Jiang Xin <worldhello.net@gmail.com>
cc:     =?VISCII?Q?Tr=A5n_Ng=F7c_Qu=E2n?= <vnwildman@gmail.com>,
        Git l10n discussion group <git-l10n@googlegroups.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?ISO-8859-15?Q?Matthias_R=FCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?ISO-8859-15?Q?Christopher_D=EDaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?ISO-8859-15?Q?Jean-No=EBl_Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Emir SARI <bitigchi@me.com>, Fangyi Zhou <me@fangyi.io>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [L10N] Kickoff for Git 2.37.0 round #1
In-Reply-To: <CANYiYbGWoMpCOA43k=5a_kio2thf91BV69nfSySwhHZbbMOSkg@mail.gmail.com>
Message-ID: <7df7a2fe-386d-c996-b783-8c95fb78b0ea@softwolves.pp.se>
References: <20220614112858.16576-1-worldhello.net@gmail.com> <CAPv0VGvKFEbVzZEdn+eb-4Bb9KfQWCa=pM3iC_Dyu-6AKGCcug@mail.gmail.com> <CANYiYbGWoMpCOA43k=5a_kio2thf91BV69nfSySwhHZbbMOSkg@mail.gmail.com>
User-Agent: Alpine 2.25 (BSO 592 2021-09-18)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 19 Jun 2022, Jiang Xin wrote:

> You forgot to remove file-location comments in "po/vi.po".  If you
> send me pull request on GitHub, a CI workflow will be triggered to
> execute the command below,

Is that why the sv.po pull request is also standing still?

Running "make po/git.pot" generates the full location lines, so naturally
the PO file will also include it. If the makefile is fixed to remove them
they should go away.

I modified my update script to run make first, as you removed git.pot from
the repo, and it generates it there.

-- 
\\// Peter - http://www.softwolves.pp.se/

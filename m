Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_BL_SPAMCOP_NET,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E4FC1F461
	for <e@80x24.org>; Wed,  7 Nov 2018 13:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbeKGWlN convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 7 Nov 2018 17:41:13 -0500
Received: from fed1rmfepo202.cox.net ([68.230.241.147]:35838 "EHLO
        fed1rmfepo202.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbeKGWlN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 17:41:13 -0500
Received: from fed1rmimpo306.cox.net ([68.230.241.174])
          by fed1rmfepo202.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20181107131053.XICD21918.fed1rmfepo202.cox.net@fed1rmimpo306.cox.net>
          for <git@vger.kernel.org>; Wed, 7 Nov 2018 08:10:53 -0500
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo306.cox.net with cox
        id x1As1y00459yGBo011AsmK; Wed, 07 Nov 2018 08:10:52 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A09020D.5BE2E45C.0059,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=OaEs8SbY c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=8nJEP1OIZ-IA:10 a=JHtHm7312UAA:10 a=GOwLXTS0TI-lUztTLAoA:9 a=wPNLvfGTeEIA:10
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 38D278602ED;
        Wed,  7 Nov 2018 06:10:52 -0700 (MST)
From:   Stephen & Linda Smith <ischis2@cox.net>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 1/2] range-diff doc: add a section about output stability
Date:   Wed, 07 Nov 2018 06:10:52 -0700
Message-ID: <2504086.hWFjgDPvVf@thunderbird>
In-Reply-To: <20181107122202.1813-2-avarab@gmail.com>
References: <nycvar.QRO.7.76.6.1811071202480.39@tvgsbejvaqbjf.bet> <20181107122202.1813-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, November 7, 2018 5:22:01 AM MST Ævar Arnfjörð Bjarmason wrote:
> +OUTPUT STABILITY
> +----------------
> +
> +The output of the `range-diff` command is subject to change. It is
> +intended to be human-readable porcelain output, not something that can
> +be used across versions of Git to get a textually stable `range-diff`
> +(as opposed to something like the `--stable` option to
> +linkgit:git-patch-id[1]). There's also no equivalent of
> +linkgit:git-apply[1] for `range-diff`, the output is not intended to
> +be machine-readable.
> +
> +This is particularly true when passing in diff options. Currently some
> +options like `--stat` can as an emergent effect produce output that's

"`--stat` can as an emergent": I read that for times to decided it was correct 
grammar.   Should it be reworded to read better?   Just a nit.

> +quite useless in the context of `range-diff`. Future versions of
> +`range-diff` may learn to interpret such options in a manner specifc
> +to `range-diff` (e.g. for `--stat` summarizing how the diffstat
> +changed).





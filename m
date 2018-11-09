Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_BL_SPAMCOP_NET,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 353B41F453
	for <e@80x24.org>; Fri,  9 Nov 2018 13:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeKIXGi convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 9 Nov 2018 18:06:38 -0500
Received: from fed1rmfepo203.cox.net ([68.230.241.148]:37294 "EHLO
        fed1rmfepo203.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbeKIXGi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 18:06:38 -0500
Received: from fed1rmimpo209.cox.net ([68.230.241.160])
          by fed1rmfepo203.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20181109132600.ZLNH4163.fed1rmfepo203.cox.net@fed1rmimpo209.cox.net>
          for <git@vger.kernel.org>; Fri, 9 Nov 2018 08:26:00 -0500
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo209.cox.net with cox
        id xpS01y00159yGBo01pS0EE; Fri, 09 Nov 2018 08:26:00 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A09020E.5BE58AE8.0046,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=dNgSZ9Rb c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=8nJEP1OIZ-IA:10 a=JHtHm7312UAA:10 a=WDhBSedXqNQA:10
 a=aZ0nhyytKW-HyRDvnrcA:9 a=wPNLvfGTeEIA:10
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id E076F861905;
        Fri,  9 Nov 2018 06:25:59 -0700 (MST)
From:   Stephen & Linda Smith <ischis2@cox.net>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Martin =?ISO-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v4 3/3] range-diff: make diff option behavior (e.g. --stat) consistent
Date:   Fri, 09 Nov 2018 06:25:59 -0700
Message-ID: <23017996.O9Ifb9KJqy@thunderbird>
In-Reply-To: <20181109101803.3038-4-avarab@gmail.com>
References: <20181107122202.1813-3-avarab@gmail.com> <20181109101803.3038-4-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, November 9, 2018 3:18:03 AM MST Ævar Arnfjörð Bjarmason wrote:
> 
> But we should behave consistently with "diff" in anticipation of such
> output being useful in the future, because it would make for confusing
> UI if two "diff" and "range-diff" behaved differently when it came to
 's/ two//'

> how they interpret diff options.
> 



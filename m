Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70D4D1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 00:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbfAVAxr convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 21 Jan 2019 19:53:47 -0500
Received: from fed1rmfepo101.cox.net ([68.230.241.143]:47795 "EHLO
        fed1rmfepo101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfAVAxr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 19:53:47 -0500
Received: from fed1rmimpo305.cox.net ([68.230.241.173])
          by fed1rmfepo101.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20190122005345.SFQQ4064.fed1rmfepo101.cox.net@fed1rmimpo305.cox.net>
          for <git@vger.kernel.org>; Mon, 21 Jan 2019 19:53:45 -0500
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id C552CB82367;
        Mon, 21 Jan 2019 17:53:44 -0700 (MST)
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A09020E.5C466999.001D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=St8kF8G0 c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=8nJEP1OIZ-IA:10 a=3JhidrIBZZsA:10 a=bwPjQjSQctvptlAGYgEA:9 a=wPNLvfGTeEIA:10
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
From:   Stephen & Linda Smith <ischis2@cox.net>
To:     SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 5/5] Add `human` date format tests.
Date:   Mon, 21 Jan 2019 17:53:44 -0700
Message-ID: <2997973.Dc0KG2NI2d@thunderbird>
Organization: Personal
In-Reply-To: <20190121150429.GR840@szeder.dev>
References: <20181231003150.8031-1-ischis2@cox.net> <20190121051646.20991-6-ischis2@cox.net> <20190121150429.GR840@szeder.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday, January 21, 2019 8:04:29 AM MST SZEDER Gábor wrote:
> Note that the relative time output is translated, see all the Q_()
> calls in show_date_relative().  Consequently, these tests fail in
> GETTEXT_POISON builds.  Please use 'test_i18ncmp' instead.
> 
> Furthermore, I think it would help readibility of this helper function
> if the commands in the 'test_expect_success' block were indented.

No problem.   I will wait a day or two for any more comments




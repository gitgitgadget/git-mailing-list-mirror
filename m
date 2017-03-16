Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A63520323
	for <e@80x24.org>; Thu, 16 Mar 2017 18:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753348AbdCPSX6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 14:23:58 -0400
Received: from fester.cwi.nl ([192.16.191.27]:39930 "EHLO fester.cwi.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752455AbdCPSXs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 14:23:48 -0400
Received: from mail.cwi.nl (zwebmail.cwi.nl [194.187.76.178])
        by fester.cwi.nl (8.14.4/8.12.3) with ESMTP id v2GIMKpr025603;
        Thu, 16 Mar 2017 19:22:20 +0100
Received: from mail.cwi.nl (localhost [127.0.0.1])
        by mail.cwi.nl (Postfix) with ESMTPS id D52203C00CC;
        Thu, 16 Mar 2017 19:22:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail.cwi.nl (Postfix) with ESMTP id C663B3C03D3;
        Thu, 16 Mar 2017 19:22:15 +0100 (CET)
Received: from mail.cwi.nl ([127.0.0.1])
        by localhost (mail.cwi.nl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rNKCteux_kXq; Thu, 16 Mar 2017 19:22:15 +0100 (CET)
Received: from mail.cwi.nl (mail.cwi.nl [194.187.76.178])
        by mail.cwi.nl (Postfix) with ESMTP id A4D0A3C00CC;
        Thu, 16 Mar 2017 19:22:15 +0100 (CET)
Date:   Thu, 16 Mar 2017 19:22:14 +0100 (CET)
From:   Marc Stevens <Marc.Stevens@cwi.nl>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Shumow <danshu@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <2006239187.136016.1489688534478.JavaMail.zimbra@cwi.nl>
In-Reply-To: <1392458356.3351662.1489439723458.JavaMail.zimbra@cwi.nl>
References: <20170301195302.3pybakmjqztosohj@sigill.intra.peff.net> <CY1PR0301MB2107876B6E47FBCF03AB1EA1C4250@CY1PR0301MB2107.namprd03.prod.outlook.com> <20170313194848.2z2dlgpomu6e3dkh@sigill.intra.peff.net> <1e6a592f-7da1-8043-0b29-0bb7c8cda3f3@cwi.nl> <CA+55aFyNi2uHwd9nzjy3dOu2L1A0jPN6AD43WKj-05km1GNtRQ@mail.gmail.com> <161775901.3349663.1489438074825.JavaMail.zimbra@cwi.nl> <20170313210023.bumtp6wyw6blmymp@sigill.intra.peff.net> <1392458356.3351662.1489439723458.JavaMail.zimbra@cwi.nl>
Subject: Re: [PATCH] Put sha1dc on a diet
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [84.31.180.140]
X-Mailer: Zimbra 8.6.0_GA_1162 (ZimbraWebClient - GC51 (Win)/8.6.0_GA_1162)
Thread-Topic: Put sha1dc on a diet
Thread-Index: zcqlgFnpFzsgEDuuKkGZcaxVksZ+/1NXrlB9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Today I merged the perf-branch into master after code review and correctness testing.
So master is now more performant and safe to use.

-- Marc

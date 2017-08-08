Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A56820899
	for <e@80x24.org>; Tue,  8 Aug 2017 19:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752248AbdHHTAM (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 15:00:12 -0400
Received: from oker.escape.de ([194.120.234.254]:35888 "EHLO oker.escape.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751998AbdHHTAL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 15:00:11 -0400
Received: from oker.escape.de (localhost [127.0.0.1])
        (envelope-sender: urs@isnogud.escape.de)
        by oker.escape.de (8.14.4/8.14.4/$Revision: 1.86 $) with ESMTP id v78J03ah014439;
        Tue, 8 Aug 2017 21:00:03 +0200
Received: (from uucp@localhost)
        by oker.escape.de (8.14.4/8.14.4/Submit) with UUCP id v78J03k0014400;
        Tue, 8 Aug 2017 21:00:03 +0200
Received: from tehran.isnogud.escape.de (localhost [127.0.0.1])
        by tehran.isnogud.escape.de (8.14.9/8.14.9) with ESMTP id v78IuerR020066;
        Tue, 8 Aug 2017 20:56:40 +0200
Received: (from urs@localhost)
        by tehran.isnogud.escape.de (8.14.9/8.14.9/Submit) id v78IucMP020063;
        Tue, 8 Aug 2017 20:56:38 +0200
X-Authentication-Warning: tehran.isnogud.escape.de: urs set sender to urs@isnogud.escape.de using -f
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org
Subject: Re: [PATCH] git svn fetch: Create correct commit timestamp when using --localtime
References: <ygf8tiyx480.fsf@tehran.isnogud.escape.de>
        <xmqqlgmvni8x.fsf@gitster.mtv.corp.google.com>
        <20170808024239.GA2915@starla>
        <xmqqfud2c80z.fsf@gitster.mtv.corp.google.com>,
        <ygf8tj26npy.fsf@tehran.isnogud.escape.de>
From:   Urs Thuermann <urs@isnogud.escape.de>
Date:   08 Aug 2017 20:56:38 +0200
In-Reply-To: <xmqqfud2c80z.fsf@gitster.mtv.corp.google.com>; from Junio C Hamano on Tue, 08 Aug 2017 09:57:00 -0700
Message-ID: <ygfinhxzy55.fsf@tehran.isnogud.escape.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> > Yep, seems alright.  Can you apply directly?
> > Been a bit preoccupied as of late.  Thanks.
> 
> Surely, I'll just add your Reviewed-by: myself ;-)

OK, thanks.  This will fix the bug I've reported here a week or so ago
(see the References header).

urs

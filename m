Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C77C433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 18:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54E0520BED
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 18:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbgJMSp6 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 13 Oct 2020 14:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgJMSp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 14:45:58 -0400
Received: from mx.pao1.isc.org (mx.pao1.isc.org [IPv6:2001:4f8:0:2::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B6DC0613D0
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 11:45:58 -0700 (PDT)
Received: from zmx1.isc.org (zmx1.isc.org [149.20.0.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.pao1.isc.org (Postfix) with ESMTPS id BC2853AB009;
        Tue, 13 Oct 2020 18:45:57 +0000 (UTC)
Received: from zmx1.isc.org (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTPS id AED0A16008D;
        Tue, 13 Oct 2020 18:45:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTP id 9EED0160090;
        Tue, 13 Oct 2020 18:45:57 +0000 (UTC)
Received: from zmx1.isc.org ([127.0.0.1])
        by localhost (zmx1.isc.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9pcCrY8cG0cs; Tue, 13 Oct 2020 18:45:57 +0000 (UTC)
Received: from larwa.hq.kempniu.pl (unknown [212.180.223.213])
        by zmx1.isc.org (Postfix) with ESMTPSA id D80E816008D;
        Tue, 13 Oct 2020 18:45:56 +0000 (UTC)
Date:   Tue, 13 Oct 2020 20:45:53 +0200
From:   =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] diff: add -I<regex> that ignores matching changes
Message-ID: <20201013184553.GA9341@larwa.hq.kempniu.pl>
References: <20201001120606.25773-1-michal@isc.org>
 <20201012091751.19594-1-michal@isc.org>
 <20201012091751.19594-3-michal@isc.org>
 <nycvar.QRO.7.76.6.2010121315170.50@tvgsbejvaqbjf.bet>
 <20201013063646.GB3278@larwa.hq.kempniu.pl>
 <nycvar.QRO.7.76.6.2010131401110.50@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2010131401110.50@tvgsbejvaqbjf.bet>
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

> Oh wow, from a cursory look it seems as if the diff machinery was not
> exactly careful with releasing memory. I might be mistaken, but if I am
> not, then this would deserve a separate patch series, methinks.

Oh, okay.  Since that sounds like a non-trivial task, I should probably
finish this patch series first, making sure it releases memory properly,
and only then move on to looking for memory leaks in diff.c.

-- 
Best regards,
Michał Kępień

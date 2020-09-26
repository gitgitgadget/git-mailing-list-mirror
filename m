Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE8AC2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 17:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84135206FC
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 17:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgIZR5m (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 13:57:42 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:34252 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIZR5m (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 13:57:42 -0400
Received: from panel-Aspire-1425P (unknown [IPv6:2a01:e0a:562:1540:a670:ff22:ed7e:bd05])
        by smtp3-g21.free.fr (Postfix) with ESMTPS id C5E2513F7F0
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 19:57:09 +0200 (CEST)
Message-ID: <1601143029.5937.10.camel@free.fr>
Subject: git bug?
From:   PANEL Christian <ch.panel@free.fr>
To:     git@vger.kernel.org
Date:   Sat, 26 Sep 2020 19:57:09 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hello,

Using .git/info/exclude file to ignore some of my directories, I notice a curious think I took for a bug :

I wanted to exclude all except that is inside my /TED/ directory
I wrote a file exclude first as this


*
!/TED/


but this doesn't work and is dangerous because no warning, and git status said (after I realize commit and push on server)
working copy is clear.
fortunately looking at repository I realize the mistake and trying a "git add" tells me there is something wrong in the
exclude file
I changed it as this

/*
!/TED/

and it works
but I don't know exactly why 
Have you a begin of answer ?

thanks a lot in advance for any answer





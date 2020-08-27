Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DDAC433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 19:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3858207CD
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 19:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b="XrZqdZ/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgH0TXV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:23:21 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:47630 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbgH0TXU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 15:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1598556200; bh=BpcmiRJSpO/B4pgp3P1fB/pch0Siyyqm4aKRjnInxc8=;
        h=Subject:From:To:Cc:Date:In-Reply-To;
        b=XrZqdZ/Ps7qOm0CQWy/JRYTady1kNvTglbUO8WP/u1hJyai+6ASvPknFX/vF4dp8C
         jEIF2Id+RB3cPxnLz3tLvoztg7Lnm2CAB0IB89KyVQ4WUkr/YQwQoTeIT2NceH6++e
         IyZoVI7zfD/qqUsUS8s71iGuvzotl+7UL4K6/I/Y=
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH] send-email: do not prompt for In-Reply-To
From:   "Drew DeVault" <sir@cmpwn.com>
To:     =?utf-8?q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
Date:   Thu, 27 Aug 2020 15:23:00 -0400
Message-Id: <C580VF2ZNJ0D.2WFFMIG1B5LO3@homura>
In-Reply-To: <20200827192029.GA63138@Carlos-MBP>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I can reproduce both on git 2.28.0 and on github.com/git/git master.

Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4889BC433E6
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 23:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20ACE207F7
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 23:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b="vYUxNtKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgH0XHF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 19:07:05 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:48044 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbgH0XHF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 19:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1598569624; bh=8xOw5bZIZqk5d55uQ1trYIdtGAP9Aqj8IdkBaI2IKX8=;
        h=Cc:Subject:From:To:Date:In-Reply-To;
        b=vYUxNtKc0mGBvHKODPGT46GbOe06szAdX9qFvI0JZ1u8I9/QgUAUXC8CLr6VRWLry
         WWeYZ5PemZxMZ02s827xKRaFmk/ZyJQR0fqrsB/s0zuo/6/ZQ4HVmSeuVRVMhd4bdA
         Ahp5jEs9TYXJyNv18QfpfjOUvrqmNN5FBIPb+BLY=
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: do not prompt for In-Reply-To
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Drew DeVault" <sir@cmpwn.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        =?utf-8?q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Date:   Thu, 27 Aug 2020 19:05:50 -0400
Message-Id: <C585M18ZSR87.2CMIKK2VKMC1S@homura>
In-Reply-To: <C585GT9K2V93.4O470Q21FXFD@homura>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oh, and I should mention the fact that this breaking change is less
severe than we initially thought, only breaking an edge case - when --to
is not specified - so it's likely to have a pretty small impact. We'll
find out when someone emails us to complain, I suppose.

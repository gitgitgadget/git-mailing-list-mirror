Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80EEC433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 19:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB542073A
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 19:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b="mLFlAWES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgH0TPT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:15:19 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:47584 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgH0TPS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 15:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1598555718; bh=kBcr511VCXGGkQBnWkJpE2wjYaZeA0pZoXzLht4n+XI=;
        h=Cc:Subject:From:To:Date:In-Reply-To;
        b=mLFlAWESuGT8semA8v7wmruCR1VT2pQXEZRjo0BoBz4K8oLHN8pk1+YezTa4eE81W
         6WOWktLP2oGOEACrNpjLP54X0TxzAnNqZDVjmA5MEyidXwyYZElwDQU29B/KlFID10
         iwGoqbFBOhmQnehwvhk6oCRIBJKu+/FdABKjvFO4=
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: do not prompt for In-Reply-To
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Junio C Hamano" <gitster@pobox.com>
Date:   Thu, 27 Aug 2020 15:15:03 -0400
Message-Id: <C580PCBW40LU.3EIZ34DNZN9B5@homura>
In-Reply-To: <xmqq7dtjrjut.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Okay, thanks for the info! I'll take this back to the drawing board and
come up with a plan which follows more closely to that.

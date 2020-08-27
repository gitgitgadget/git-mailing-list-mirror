Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08F7C433E6
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 23:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89FC42080C
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 23:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b="E2v4wq4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgH0XYs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 19:24:48 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:48076 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbgH0XYs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 19:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1598570687; bh=pkozSSlL4ahHEU8tUX+qG34dDBAUg/+gZtlGenxKUGQ=;
        h=Cc:Subject:From:To:Date:In-Reply-To;
        b=E2v4wq4NMB9NU+82DxDSFWz7fN2iJiKxvuBdM2Dq2g28CZiCMTrK0ETBfe4CuwmTT
         3tdv31JZH5Oh1rJqkX8VOjvc7kXgMRRwSBsI0Wj5Zh6gvsK/WqdvDm971z0SQ2W76+
         TZ7XQ9OqdItpvR6ngqY6uxdAK4Sb/6sAqkWxK4dM=
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     =?utf-8?q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: do not prompt for In-Reply-To
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Junio C Hamano" <gitster@pobox.com>
Date:   Thu, 27 Aug 2020 19:24:14 -0400
Message-Id: <C58604CW0C8Y.27SRQLJ1C6X43@homura>
In-Reply-To: <xmqq4konptab.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu Aug 27, 2020 at 7:23 PM EDT, Junio C Hamano wrote:
> Carlo and I were discussing how best to describe the behaviour we
> have better to the users, which is unrelated to any code change that
> would be required to "make it harder make it easier."
>
> We need to do so to help users in the meantime, before any behaviour
> change (which need to happen over several releases, as outlined
> earlier) happens.

Ah, I see what you mean. I'll add some messaging like that in my v2, but
the point's likely moot anyway since I expect to have the patch ready
for the next release.

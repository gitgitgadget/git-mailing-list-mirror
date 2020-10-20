Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FA1C4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 21:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED9B32224A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 21:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sfconservancy.org header.i=@sfconservancy.org header.b="ALO7wtr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389687AbgJTVqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 17:46:43 -0400
Received: from pine.sfconservancy.org ([162.242.171.33]:37296 "EHLO
        pine.sfconservancy.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389617AbgJTVqm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 17:46:42 -0400
Received: from localhost (unknown [216.161.86.19])
        (Authenticated sender: bkuhn)
        by pine.sfconservancy.org (Postfix) with ESMTPSA id 00FBAE280;
        Tue, 20 Oct 2020 21:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sfconservancy.org;
        s=pine; t=1603230402;
        bh=VGVqjbB6X05qNbxKJIm0gL5jzI1PwYNo8RElw3D/fW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ALO7wtr+muUh75sUn8+x190GoZVnh97fS5QlSKf/1VTqoPzcSw0WqyuWQxirMQWyV
         IA9z2MjOE+2ckwuqUJfLiBqcBmtfEPYt75eeTRvdh6OOgARsbc4wFfi3Nq+kGdu3yT
         MaKhXZ/wij72s5U0dmAijFCcsUWE7c6x6FC4S0XVpYg2OzM6GoXeP+YrAWbHXkV65Y
         xuQ7fc15pPTOoVFgfptOFc1allUHh7mehl2ZUaVs63LhUgex8q+MOowxMnbt28WQJr
         iIZZAbrCevdq/1rwOqBHXtjxcpOD2PKIRWLwdYUhNud07dsfL0T7zXlZk+QVet5jIF
         Qon4t42QMDOJQ==
Date:   Tue, 20 Oct 2020 14:44:31 -0700
From:   "Bradley M. Kuhn" <bkuhn@sfconservancy.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 2/4] Documentation: clarify and expand description of
 --signoff
Message-ID: <20201020214431.GA1398231@ebb.org>
References: <xmqqy2k1dfoh.fsf@gitster.c.googlers.com> <xmqq8sc0d91d.fsf@gitster.c.googlers.com>
 <cover.1603155607.git.bkuhn@sfconservancy.org>
 <418d15c53268f947e11dac2f22d1f8c3c8c60997.1603155607.git.bkuhn@sfconservancy.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <418d15c53268f947e11dac2f22d1f8c3c8c60997.1603155607.git.bkuhn@sfconservancy.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,

Junio wrote in the sub-thread about [PATCH v3 4/4]:
>> It seems the patches [1-3/4] are identical to what has been queued
>> in 'seen', which is a good sign.

One change I made in v3 patchset was to add Peff's Signed-off-by, as it
is *not* there in commit 04c2b9ebd0 in seen:

I wrote in [PATCH v3 2/4]:
> Signed-off-by: Jeff King <peff@peff.net>

… given that Peff made edits to this before it was posted, I think we want to
be sure Peff's Signed-off-by is included.  It just seems like the "right
thing" to get the Signed-off-by trailers 100% correct on a commit that
changes the description of Signed-off-by. 😆

I wrote in [PATCH v3 2/4]:
> Reviewed-by: Taylor Blau <me@ttaylorr.com>

I doubt Taylor cares whether this Reviewed-by trailer makes it in,
but I did add that too based on Taylor providing it earlier in the
discussion of this patch. ☺
--
Bradley M. Kuhn - he/him
Policy Fellow & Hacker-in-Residence at Software Freedom Conservancy
========================================================================
Become a Conservancy Supporter today: https://sfconservancy.org/supporter

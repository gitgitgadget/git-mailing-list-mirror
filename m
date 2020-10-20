Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15FBC4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 21:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50D0822244
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 21:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sfconservancy.org header.i=@sfconservancy.org header.b="jquyfM6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438647AbgJTVds (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 17:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409954AbgJTVds (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 17:33:48 -0400
Received: from pine.sfconservancy.org (pine.sfconservancy.org [IPv6:2001:4801:7822:103:be76:4eff:fe10:7c55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17BFC0613D3
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 14:33:47 -0700 (PDT)
Received: from localhost (unknown [216.161.86.19])
        (Authenticated sender: bkuhn)
        by pine.sfconservancy.org (Postfix) with ESMTPSA id 41677E281;
        Tue, 20 Oct 2020 21:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sfconservancy.org;
        s=pine; t=1603229627;
        bh=RT+XQrFs7mhwas+/QljpjpjqAab5UO0pZbJHi6F9RRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jquyfM6Yxa77qWBTjHxC0E7GNSB/gvHafGw9Wb0Pb6SIbW9dZcxfV7G+X/JeihoqN
         IbKaWsk1AGkj5NOUdyN0soZ4E9r4wViOjb/zRJLJlcXjoekcTW1H+2RoVsAgf+urG+
         Jhwvs8Lf565ygH0vCQiGHUQP8mAFwhz/0GrrXR6pYUp9jT+BAB3mxvqdsU6n5DN/Aq
         F81jdOlCIyRRiBQFPtdgD+9WKgweDNjcvOQi7O9+ke3Hva9wOpzBZpuAUV7sBa1do/
         g6gDpcGoFjFmJWtsaoDUOjgKm+fBoWjoKYqgUcxbKD9YN6or8U/OTQL0I51xd+vYLm
         m2VOv45GrUxDw==
Date:   Tue, 20 Oct 2020 14:33:15 -0700
From:   "Bradley M. Kuhn" <bkuhn@sfconservancy.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 4/4] Documentation: stylistically normalize references
 to Signed-off-by:
Message-ID: <20201020213315.GB1368742@ebb.org>
References: <xmqqy2k1dfoh.fsf@gitster.c.googlers.com>
 <cover.1603155607.git.bkuhn@sfconservancy.org>
 <448b9d464eafdb0ee8faa8cd41ee08f844e27701.1603155607.git.bkuhn@sfconservancy.org>
 <xmqq8sc0d91d.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8sc0d91d.fsf@gitster.c.googlers.com>
X-No-Archive: yes
X-Archive: no
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Did you hand edit the second hunk starting at line 340 to
> git-send-email.txt?

I don't think so, although this is only the third time I've used the git
format-patch/send-email workflow so it's entirely possible I did something
funky …

>  I've fixed it up manually, so no need to resend.

… but thanks for taking care of it!

--
Bradley M. Kuhn - he/him
Policy Fellow & Hacker-in-Residence at Software Freedom Conservancy
========================================================================
Become a Conservancy Supporter today: https://sfconservancy.org/supporter

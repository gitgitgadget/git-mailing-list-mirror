Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C980BC433E7
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 05:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6436D207EA
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 05:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sfconservancy.org header.i=@sfconservancy.org header.b="Tn1SCdfs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411714AbgJQFaR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 01:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411632AbgJQF3n (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 01:29:43 -0400
Received: from pine.sfconservancy.org (pine.sfconservancy.org [IPv6:2001:4801:7822:103:be76:4eff:fe10:7c55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D25C05BD43
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 20:04:18 -0700 (PDT)
Received: from localhost (unknown [216.161.86.19])
        (Authenticated sender: bkuhn)
        by pine.sfconservancy.org (Postfix) with ESMTPSA id 1ABA9EA8C;
        Sat, 17 Oct 2020 03:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sfconservancy.org;
        s=pine; t=1602903857;
        bh=NrZaVOgfV18401tvp8LC0BWQz/NCDE13DCTJKLQjTyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tn1SCdfsbZoxB2DI20X9YPs8R2SSH2smzLx3Yo31e9JA4OkgdNcPYsUfdEk5K948o
         LD0OWL7McxxB/6Vg2imhCDho+Brxl5kLruVkLNyX+6jMhRiVFYVt59M7zG6KuXCNV2
         CnoVYZy3ka2gyjzh7USgdOQSEx3GCP4Q/TTUNX2k4SFOFkfgJeJkD8OQ9yWSPvd8IJ
         8owPpek83exP3VgwYjGzRAIRxp6jxpgNm1nfsNIOKT5Dcc3YJ7qO+r9cVXO+JK3wIz
         5AdtfQZrI/yu7Dkes3NDUd3FiiUyhhUV5wwTFxL+NmKaSilWAbqRAi5GxOKrzH1wFU
         aYaUPTH2458Zg==
Date:   Fri, 16 Oct 2020 20:00:50 -0700
From:   "Bradley M. Kuhn" <bkuhn@sfconservancy.org>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 0/1] Clarify and expand description of --signoff
Message-ID: <20201017030050.GA351024@ebb.org>
References: <20201015215933.96425-1-bkuhn@sfconservancy.org>
 <59E3B060-63E3-41C2-A7C4-5B2C888F8D68@gmail.com>
 <CAPc5daWenXds=0BW0CXa=4MOF2UxDeQ8DF2+7V9-WkKwCFCDBw@mail.gmail.com>
 <20201016015937.GA3335046@coredump.intra.peff.net>
 <xmqqft6eewc5.fsf@gitster.c.googlers.com>
 <xmqqh7quaqwb.fsf@gitster.c.googlers.com>
 <20201016201119.GA3356073@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016201119.GA3356073@coredump.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> You said "squashing", but I'd suggest keeping it as its own patch on top
> of Bradley's.

While I admit a certain vain desire to have my name appear in Git's own
commit history (given that it's unlikely I'll ever be able to spare the time
to make another contribution), if it's cleaner to squash my change, I can
assent to that and you can consider both patches discussed in this thread
together:

  Signed-off-by: Bradley M. Kuhn <bkuhn@sfconservancy.org>

--
Bradley M. Kuhn - he/him
Policy Fellow & Hacker-in-Residence at Software Freedom Conservancy
========================================================================
Become a Conservancy Supporter today: https://sfconservancy.org/supporter

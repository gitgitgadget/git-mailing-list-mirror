Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292E8C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 22:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9F5B20776
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 22:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sfconservancy.org header.i=@sfconservancy.org header.b="NgmWr8/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbgJOWKH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 18:10:07 -0400
Received: from pine.sfconservancy.org ([162.242.171.33]:43850 "EHLO
        pine.sfconservancy.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731726AbgJOWKH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 18:10:07 -0400
X-Greylist: delayed 473 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Oct 2020 18:10:06 EDT
Received: from localhost (unknown [216.161.86.19])
        (Authenticated sender: bkuhn)
        by pine.sfconservancy.org (Postfix) with ESMTPSA id 75386E9C5;
        Thu, 15 Oct 2020 22:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sfconservancy.org;
        s=pine; t=1602799332;
        bh=fbYWPKFMB7VP1pznj2OrR525DmAbvvsPeB0rEod0yPc=;
        h=From:To:Subject:Date:From;
        b=NgmWr8/eQEXwRJ1BZpZKCLMrey65EOWPFu5igEcCFejgwEGZe24/lOXd6vz3kHl4T
         nkVdNcv5x30c/PWPvnnv73x7k8o3LXCCqp47XGzUysW48wjGtM1I6PdN4BkaMdJtQ+
         DtPhc21gIetB4oY53mgdRhRdCV7vR24DGTQqEBhHcXvC2nVNW2FUOX+hMzxODCXFfn
         mDY5n/etrSCLlzaM36GIzajZMg0Ei/NA6TO16wYAT+m/YOdNp+YXGOkpi0r5LB+94F
         wutV3ZHayLUysxGe49jheOiaFLS9jK7mKuN2Vndtqg3MEHqQL7+xgIEdN+xojFyR8H
         i4fiYeI33gY/Q==
From:   "Bradley M. Kuhn" <bkuhn@sfconservancy.org>
To:     git@vger.kernel.org
Subject: [PATCH 0/1] Clarify and expand description of --signoff
Date:   Thu, 15 Oct 2020 14:59:32 -0700
Message-Id: <20201015215933.96425-1-bkuhn@sfconservancy.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As you know, it's rare that Conservancy offers specific patches upstream to
our member projects, but I've attached a patch that updates the documentation
regarding Signed-Off-By.

While the Git and Linux projects use this specifically to refer to a DCO as
published on the URL provided, other projects have various meanings of
Signed-Off-By, and we noticed in a recent check of Conservancy member
projects that details on it vary.  Ultimately, I don't think Git wants anyway
to opine about the meaning of Signed-off-by for every project that uses Git,
so this documentation change hedges while still explaning and recommending
the DCO used by Linux and Git.

Peff gave me some feedback on this change and we did a bit of redrafting in a
private email thread, but I think this is now ready for public review and
discussion.

I apologize in advance if I've made a mistake in format or form in submitting
this patch; it's my first upstream contribution to Git!  I did try my best to
follow Documentation/MyFirstContribution.txt carefully! :)

Bradley M. Kuhn (1):
  Documentation: Clarify and expand description of --signoff

 Documentation/git-commit.txt    | 13 ++++++++-----
 Documentation/merge-options.txt | 13 ++++++++-----
 2 files changed, 16 insertions(+), 10 deletions(-)

-- 
Bradley M. Kuhn - he/him
Policy Fellow & Hacker-in-Residence at Software Freedom Conservancy
========================================================================
Become a Conservancy Supporter today: https://sfconservancy.org/supporter

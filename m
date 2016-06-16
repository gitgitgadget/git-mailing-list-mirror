Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB89E1FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 13:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530AbcFPN3z (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 09:29:55 -0400
Received: from ud10.udmedia.de ([194.117.254.50]:52387 "EHLO
	mail.ud10.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbcFPN3z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 09:29:55 -0400
DKIM-Signature:	v=1; a=rsa-sha256; c=simple; d=trippelsdorf.de; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=k1; bh=ZdKQPgy207yzMmcidA5+oP308UHL
	8JumtAz64PIiFP8=; b=Ikono8DtkSpPfSOj014tLRIVx5Ye8TKjHkbh7dUgZbR2
	5/lOPo/NMSLO1f2l+rKKaj3DmgRTnowUMeEA17Wq7OGlxE6sIlZYCz+vO1zgC3Xf
	CGVUvJLYaHkx7odKzCrppERKQeF5DyPyE8YEjXTvmDjq9J2SPj44qhvdQtLCDW8=
Received: (qmail 4943 invoked from network); 16 Jun 2016 15:29:52 +0200
Received: from ip5b41f88a.dynamic.kabel-deutschland.de (HELO x4) (ud10?360p3@91.65.248.138)
  by mail.ud10.udmedia.de with ESMTPSA (ECDHE-RSA-AES256-SHA encrypted, authenticated); 16 Jun 2016 15:29:52 +0200
Date:	Thu, 16 Jun 2016 15:29:52 +0200
From:	Markus Trippelsdorf <markus@trippelsdorf.de>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>
Subject: Re: final git bisect step leads to: "fatal: you want to use way too
 much memory"
Message-ID: <20160616132952.GC314@x4>
References: <20160616125326.GA314@x4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160616125326.GA314@x4>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 2016.06.16 at 14:53 +0200, Markus Trippelsdorf wrote:
> markus@x4 gcc % git bisect good
> f216419e5c4c41df70dbe00a6ea1faea46484dc8 is the first bad commit
> commit f216419e5c4c41df70dbe00a6ea1faea46484dc8
> fatal: you want to use way too much memory
> markus@x4 gcc % 

The issue started with:

commit fe37a9c586a65943e1bca327a1bbe1ca4a3d3023
Author: Junio C Hamano <gitster@pobox.com>
Date:   Tue Mar 29 16:05:39 2016 -0700

    pretty: allow tweaking tabwidth in --expand-tabs


-- 
Markus

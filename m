Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1D7B1FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 13:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754196AbcFPNBt (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 09:01:49 -0400
Received: from ud10.udmedia.de ([194.117.254.50]:40226 "EHLO
	mail.ud10.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753796AbcFPNBt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 09:01:49 -0400
DKIM-Signature:	v=1; a=rsa-sha256; c=simple; d=trippelsdorf.de; h=date
	:from:to:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=k1; bh=qrrcvZTxGYo4vapayH66frqvLz2OmPiJPXJOnFRLp
	mM=; b=EbsLcm7GlOUJDxsNqNyp2zkLo9pJZ6qDEt9ukWCZZhRqQupcRVRDsImKI
	1HtAHaQKcY3kmYqiIrdY8upLbb7ek2x0CjredrT+NT1c1BeBLABw2El8X4XbKavy
	oeMZkT3EurKm812BJVQ4rBdb1ldkf3F9020Xaq3nxupPvYzKDY=
Received: (qmail 23358 invoked from network); 16 Jun 2016 14:55:06 +0200
Received: from ip5b41f88a.dynamic.kabel-deutschland.de (HELO x4) (ud10?360p3@91.65.248.138)
  by mail.ud10.udmedia.de with ESMTPSA (ECDHE-RSA-AES256-SHA encrypted, authenticated); 16 Jun 2016 14:55:06 +0200
Date:	Thu, 16 Jun 2016 14:55:06 +0200
From:	Markus Trippelsdorf <markus@trippelsdorf.de>
To:	git@vger.kernel.org
Subject: Re: final git bisect step leads to: "fatal: you want to use way too
 much memory"
Message-ID: <20160616125506.GB314@x4>
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
> To reproduce the issue, just run:

Forget to mention:

markus@x4 ~ % git --version
git version 2.9.0

git-2.8.4 is fine.


-- 
Markus

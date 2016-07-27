Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4852203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 12:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309AbcG0MCP (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 08:02:15 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60326 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754131AbcG0MCO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2016 08:02:14 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id F0168207CC;
	Wed, 27 Jul 2016 08:02:13 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 27 Jul 2016 08:02:14 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=pennock-tech.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=FoZpY
	GjAfwfWMYXzbwdPSnnwMUQ=; b=p3+lV/VMvz0Y8aA0pnYv9faqD2j+x30HBSU7x
	AK/MkleqBg/IL0JHdf223cuLN1rs0OffHlRnuYNieEFc3bVfSvNiOV76rrQS3Yqx
	SgetvLRKtQD13+UQyEYdr+t+owPLZmVerMnoIKIiwF4NHMIYuQBa6d60DPNhFHL0
	6dQ/kc=
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=FoZpYGjAfwfWMYXzbwdPSnnwMUQ=; b=om+mM
	j6m9IA2grgRt2q2y5WThgnjLR69dFGhyCwIREobusJjxb38WSZVbvmQ4w/h7AOeO
	ITVcIHy+rOIzq1/sSw8pv3QBXZKibqLygiIBpKIrht0T8kjTPm+efRTv3FmR8YVj
	YSVdQT83PE3tOm8ocjiLbWnnIAwOMB62N/RC/s=
X-Sasl-enc: yfNUatqohBZYqx+zv8qBA48PGt6k7bJhBFdsGiEXXx6p 1469620933
Received: from breadbox (pool-72-95-220-245.pitbpa.fios.verizon.net [72.95.220.245])
	by mail.messagingengine.com (Postfix) with ESMTPA id 74916F29FE;
	Wed, 27 Jul 2016 08:02:13 -0400 (EDT)
Date:	Wed, 27 Jul 2016 08:02:11 -0400
From:	Phil Pennock <phil@pennock-tech.com>
To:	git@vger.kernel.org
Cc:	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH] pretty format string support for reflog times
Message-ID: <20160727120210.GA22669@breadbox>
References: <20160727081414.GA21451@breadbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160727081414.GA21451@breadbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 2016-07-27 at 04:14 -0400, Phil Pennock wrote:
>  pretty.c                      | 36 ++++++++++++++++++++++++++++++++++++
>  reflog-walk.c                 | 16 ++++++++++++++++
>  reflog-walk.h                 |  3 +++
>  t/t4205-log-pretty-formats.sh | 26 ++++++++++++++++++++++++++
>  4 files changed, 81 insertions(+)

After sleep, I realized that while I included tests I forgot to update
the docs.  Those will go into a v2 of the patch; sorry about that.

Feedback sought upon everything _else_ wrong with this which should be
addressed in v2.

[apologies to explicit CC'd who may see this twice; apparently the
 mobile client for this mail-provider infests messages with HTML with no
 option to disable]

-Phil Pennock

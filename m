Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8196C1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 21:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbcHCVIf (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 17:08:35 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43052 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758382AbcHCVIW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 17:08:22 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 125711F40E;
	Wed,  3 Aug 2016 21:08:22 +0000 (UTC)
Date:	Wed, 3 Aug 2016 21:08:21 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>, "Kyle J. McKay" <mackyle@gmail.com>,
	git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH 1/1 v2] pager: move pager-specific setup into the build
Message-ID: <20160803210821.GA17510@whir>
References: <20160801214937.4752-1-e@80x24.org>
 <20160801214937.4752-2-e@80x24.org>
 <20160803161911.dxucq7f2pvnoovoc@sigill.intra.peff.net>
 <xmqq4m718tay.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4m718tay.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> All bugs are from my original, I think.  Here is a proposed squash.

Thanks, I'll take the git-sh-setup changes.

I actually just rewrote setup_pager_env using split_cmdline and
eliminated all the scary (to me) pointer arithmetic and avoided
strbuf, too.

Unfortunately, my Internet connection on that machine dropped
before I could finish testing and pushing :<

This was also the machine running http://czquwvybam4bgbro.onion/git/ :<

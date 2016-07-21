Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A71CA203C2
	for <e@80x24.org>; Thu, 21 Jul 2016 17:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538AbcGURK3 (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 13:10:29 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33346 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753153AbcGURK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 13:10:28 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96942203C2;
	Thu, 21 Jul 2016 17:10:26 +0000 (UTC)
Date:	Thu, 21 Jul 2016 17:10:25 +0000
From:	Eric Wong <e@80x24.org>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-lib: on FreeBSD, look for unzip(1) in
 /usr/local/bin/
Message-ID: <20160721171025.GA30979@plume>
References: <31dce0b28ae094c976890c1604c4ebbcaef0e7ef.1469116960.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <31dce0b28ae094c976890c1604c4ebbcaef0e7ef.1469116960.git.johannes.schindelin@gmx.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> The common work-around is to install Info-Zip on FreeBSD, into
> /usr/local/bin/.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thanks, t5003 now works out-of-the-box.
Tested with Info-ZIP unzip installed and uninstalled.

Tested-by: Eric Wong <e@80x24.org>

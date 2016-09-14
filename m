Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A479F207DF
	for <e@80x24.org>; Wed, 14 Sep 2016 11:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760911AbcINL7V (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 07:59:21 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:37114 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756249AbcINL7V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 07:59:21 -0400
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
        by smtp.onerussian.com with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <yoh@onerussian.com>)
        id 1bk8qU-0002ZF-Qd; Wed, 14 Sep 2016 07:59:18 -0400
Received: from yoh by washoe.onerussian.com with local (Exim 4.84)
        (envelope-from <yoh@onerussian.com>)
        id 1bk8qU-0002ZA-Kk; Wed, 14 Sep 2016 07:59:18 -0400
Date:   Wed, 14 Sep 2016 07:59:18 -0400
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 0/3] http: avoid repeatedly adding curl easy to curlm
Message-ID: <20160914115918.GS9830@onerussian.com>
References: <20160909221942.GS9830@onerussian.com>
 <20160913002557.10671-1-e@80x24.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160913002557.10671-1-e@80x24.org>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: e@80x24.org, git@vger.kernel.org, peff@peff.net, gitster@pobox.com
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, 13 Sep 2016, Eric Wong wrote:
> What is unclear to me is how only Yaroslav's repository seems to
> trigger this bug after all these years...

Thank you Eric very much for tracking down this issue!  Since issue is
intermittent, I guess people just didn't bother going through reporting
if they got an error once in a while, and/or could have attributed
to somehow misran update-server-info.

> However, I am fairly sure this fixes the bug Yaroslav
> encountered.  This patch series is also needed for 2.9.3 and
> perhaps older maintenance tracks for distros.

FWIW I have tested your branch locally - and do not observe that bug any
longer.  Thanks again!

-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        

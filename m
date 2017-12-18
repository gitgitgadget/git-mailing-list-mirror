Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A30F91F424
	for <e@80x24.org>; Mon, 18 Dec 2017 14:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758232AbdLROVP (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 09:21:15 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:40138 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752858AbdLROVO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 09:21:14 -0500
Received: from [10.31.178.4] (helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <yoh@onerussian.com>)
        id 1eQwHx-0004yF-Fe; Mon, 18 Dec 2017 09:21:07 -0500
Date:   Mon, 18 Dec 2017 09:21:00 -0500
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>, kyle@kyleam.com
Message-ID: <20171218142100.3mhshemnooc3sykv@hopa.kiewit.dartmouth.edu>
References: <20171211211102.rrxqd6yscnd33efd@hopa.kiewit.dartmouth.edu>
 <20171211225615.GC214273@aiede.mtv.corp.google.com>
 <xmqqtvww3gea.fsf@gitster.mtv.corp.google.com>
 <20171216220120.GB6217@genre.crustytoothpaste.net>
 <CA+P7+xpFyD0zuOz7XSCc6cV1T1zu6j-gZD=EMQs-t2WPxi1EMA@mail.gmail.com>
 <20171218064042.GA25733@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171218064042.GA25733@sigill.intra.peff.net>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: NeoMutt/20170609 (1.8.3)
X-SA-Exim-Connect-IP: 10.31.178.4
X-SA-Exim-Rcpt-To: peff@peff.net, jacob.keller@gmail.com, sandals@crustytoothpaste.net, gitster@pobox.com, jrnieder@gmail.com, git@vger.kernel.org, kyle@kyleam.com
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: Re: Q: rational for $XDG_CONFIG_HOME/git/config to be "non global"
 or just a bug?
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, 18 Dec 2017, Jeff King wrote:

> To complete that abstraction it seems like reading via "--global" should
> read from both (in the same precedence order that normal config lookup
> uses).

FWIW +1 from me on that ;)

-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB0F820A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 02:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbeLHCPi (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 21:15:38 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:50528 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeLHCPi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 21:15:38 -0500
Received: from c-76-24-253-1.hsd1.nh.comcast.net ([76.24.253.1] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <yoh@onerussian.com>)
        id 1gVS9Z-0006LF-AH
        for git@vger.kernel.org; Fri, 07 Dec 2018 21:15:37 -0500
Date:   Fri, 7 Dec 2018 21:15:31 -0500
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     git <git@vger.kernel.org>
Message-ID: <20181208021531.GB4633@hopa.kiewit.dartmouth.edu>
References: <20181206173554.GH4633@hopa.kiewit.dartmouth.edu>
 <CAGZ79kY8uv8zDm3f8Jb6aC-nit7OZduixyOekGYWa_xnqFqw-w@mail.gmail.com>
 <20181206212459.GN4633@hopa.kiewit.dartmouth.edu>
 <CAGZ79kYoGqWW4tv4-caA18SHKe+y2mnDT84AEWVksDtDObLq0g@mail.gmail.com>
 <20181207012256.GR4633@hopa.kiewit.dartmouth.edu>
 <CAGZ79kbeAd1C-ySnJye-QU5FFf2jygksUsWtEmbvPZ_dQy_3uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbeAd1C-ySnJye-QU5FFf2jygksUsWtEmbvPZ_dQy_3uA@mail.gmail.com>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: 76.24.253.1
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: Re: [wishlist] git submodule update --reset-hard
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, 07 Dec 2018, Stefan Beller wrote:
> > the initial "git submodule update --reset-hard" is pretty much a
> > crude workaround for some of those cases, so I would just go earlier in
> > the history, and redo some things, whenever I could just drop or revert
> > some selected set of commits.

> That makes sense.
> Do you want to give the implementation a try for the --reset-hard switch?

ok, will do, thanks for the blessing ;-)

-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        

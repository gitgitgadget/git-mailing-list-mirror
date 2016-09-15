Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DEE92070F
	for <e@80x24.org>; Thu, 15 Sep 2016 16:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbcIOQkj (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 12:40:39 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:41418 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbcIOQkh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 12:40:37 -0400
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
        by smtp.onerussian.com with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <yoh@onerussian.com>)
        id 1bkZiG-0007yb-1L
        for git@vger.kernel.org; Thu, 15 Sep 2016 12:40:36 -0400
Received: from yoh by washoe.onerussian.com with local (Exim 4.84)
        (envelope-from <yoh@onerussian.com>)
        id 1bkZiF-0007yW-Po
        for git@vger.kernel.org; Thu, 15 Sep 2016 12:40:35 -0400
Date:   Thu, 15 Sep 2016 12:40:35 -0400
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [wishlist?] make submodule commands robust to having
 non-submodule Subprojects
Message-ID: <20160915164035.GL9830@onerussian.com>
References: <20160915130233.GC9833@onerussian.com>
 <CAGZ79kZLdsKcf0t=dDB24VVe+V=uqQCW_VNQwSJ638m5Keu2nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZLdsKcf0t=dDB24VVe+V=uqQCW_VNQwSJ638m5Keu2nQ@mail.gmail.com>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, 15 Sep 2016, Stefan Beller wrote:

> > I think it would be more logical to make it a 'warning:' not a 'fatal:' and
> > proceed.

> So maybe we would want to introduce a switch
>   `--existing-but-unconfigure-gitlinks=(warn|ignore)`
> as well as
> `git config submodule.existing-but-unconfigured (warn|ignore)`
> for a more permanent solution?

possibly ignorant question:  is  gitlink === Subproject    or a
Subproject is a kinda of a gitlink and there are other gitlinks which
aren't Subprojects? ;)

-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        

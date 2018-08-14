Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BF511F404
	for <e@80x24.org>; Tue, 14 Aug 2018 00:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbeHNDV5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 23:21:57 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:46785 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbeHNDV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 23:21:57 -0400
Received: from c-76-24-253-1.hsd1.nh.comcast.net ([76.24.253.1] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <yoh@onerussian.com>)
        id 1fpNKn-0007Rb-Mm
        for git@vger.kernel.org; Mon, 13 Aug 2018 20:37:18 -0400
Date:   Mon, 13 Aug 2018 20:37:12 -0400
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <20180814003712.GK580@hopa.kiewit.dartmouth.edu>
References: <20180813162236.GO732@hopa.kiewit.dartmouth.edu>
 <xmqqva8e2bpf.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqva8e2bpf.fsf@gitster-ct.c.googlers.com>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: 76.24.253.1
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: Re: wishlist: "--cached|--staged" to "git commit file(s)"
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, 13 Aug 2018, Junio C Hamano wrote:
> > command.  ATM there is no non-interactive (via --patch/--interactive I
> > think it is possible) way to commit selected subset of staged files not
> > from the worktree (as it is done with "git commit file(s)") but from the
> > index.

> Hmph, so

> 	edit A B C
> 	git add A B
> 	edit A B C
> 	git commit --cached B

> would create a commit that is different from the original HEAD by
> the edit to file B you did in the first step, but not the edit to A
> or C, or edit to B after you did "git add"?

yes

> That sounds like a useful feature.  If you do not need that "exclude
> the later edit since the last 'git add'", you can do "git commit B",
> but if you added crufts to B in the working tree since you added a
> good copy of B to the index, that would not do what you want to do.

exactly

> Sounds like a good starter project for somebody who wants to try to
> get their hands dirty...

asking "around" ;-)


-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        

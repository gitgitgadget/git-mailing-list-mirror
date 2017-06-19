Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABA411FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 16:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbdFSQOq (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 12:14:46 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:45807 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbdFSQOo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 12:14:44 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jun 2017 12:14:43 EDT
Received: from hopa.kiewit.dartmouth.edu ([129.170.31.151] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <yoh@onerussian.com>)
        id 1dMz5O-0003nz-31; Mon, 19 Jun 2017 11:59:31 -0400
Date:   Mon, 19 Jun 2017 11:59:24 -0400
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Message-ID: <20170619155924.7ra2vwvaelr2yj2v@hopa.kiewit.dartmouth.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 129.170.31.151
X-SA-Exim-Rcpt-To: git@vger.kernel.org, sbeller@google.com
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: in case you want a use-case with lots of submodules
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

On a recent trip I've listened to the git minutes podcast episode and
got excited to hear  Stefan Beller (CCed just in case) describing
ongoing work on submodules mechanism.  I got excited, since e.g.
performance improvements would be of great benefit to us too.

In our project, http://datalad.org, git submodules is the basic
mechanism to bring multiple "datasets" (mix of git and git-annex'ed
repositories)  under the same roof so we could non-ambiguously
version them all at any level.

http://datasets.datalad.org ATM provides quite a sizeable (ATM 370
repositories, up to 4 levels deep) hierarchy of git/git-annex
repositories all tied together via git submodules mechanism.  And as the
collection grows, interactions with it become slower, so additional
options (such as --ignore-submodules=dirty  to status) become our
friends.

So I thought to share this as a use-case happen you need more
motivation or just a real-case test-bed for your work.  And thank
you again for making Git even Greater.

P.S. Please CCme in your replies (if any), I am not on the list

With best regards,
-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        

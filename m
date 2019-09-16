Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C6F31F463
	for <e@80x24.org>; Mon, 16 Sep 2019 21:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732070AbfIPVvN (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 17:51:13 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:49598 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfIPVvN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 17:51:13 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 583361F463;
        Mon, 16 Sep 2019 21:51:13 +0000 (UTC)
Date:   Mon, 16 Sep 2019 21:51:13 +0000
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: git-svn future goals...
Message-ID: <20190916215113.cc5znsitcwtfkqlj@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It looks like git-svn has mostly killed SVN(*), but commands like
"git svn find-rev" and maybe "git svn log" will continue to be
useful for projects that already migrated to git.

So I'm hoping to find time at some point in the future to port
some non-libsvn-dependent parts over to C, and maybe improve
things (like having find-rev work across branches).

Not sure when I'll have time (because I barely have time for
existing FLOSS projects), but it's something I'd like to do at
some point because Perl5 startup time is atrocious...


(*) unfortunately centralization has become stronger,
    and I'll continue working on killing centralization :P

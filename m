Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88C041F935
	for <e@80x24.org>; Tue, 20 Sep 2016 08:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753586AbcITIyj (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 04:54:39 -0400
Received: from dd28836.kasserver.com ([85.13.147.76]:41329 "EHLO
        dd28836.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752924AbcITIy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 04:54:27 -0400
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Sep 2016 04:54:27 EDT
Received: from [10.1.1.70] (nat1.ableton.net [217.110.199.117])
        by dd28836.kasserver.com (Postfix) with ESMTPSA id C348B30062C
        for <git@vger.kernel.org>; Tue, 20 Sep 2016 10:46:02 +0200 (CEST)
To:     git@vger.kernel.org
Subject: Limitiations of git rebase --preserve-merges --interactive
From:   lists@haller-berlin.de (Stefan Haller)
Date:   Tue, 20 Sep 2016 10:46:02 +0200
Message-ID: <1mtveu4.19lvgi1c0hmhaM%lists@haller-berlin.de>
User-Agent: MacSOUP/2.8.6b1 (Mac OS 10.11.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The BUGS section of the git-rebase manpage says that editing or
rewording commits "should work fine", but attempts to reorder commits
usually don't do what you want.

I'd like to know more about what does or doesn't work. For example, will
squashing commits work? (I.e. using the "fixup" or "squash" commands in
the todo sheet.)

Will dropping commits work?

Does it make sense to insert "exec" commands, or will they run at
arbitrary times?


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/

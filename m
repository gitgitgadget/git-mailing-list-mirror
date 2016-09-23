Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E00B1F935
	for <e@80x24.org>; Fri, 23 Sep 2016 10:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758994AbcIWKkc (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 06:40:32 -0400
Received: from dd28836.kasserver.com ([85.13.147.76]:52365 "EHLO
        dd28836.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758771AbcIWKkb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 06:40:31 -0400
Received: from [10.1.1.70] (nat1.ableton.net [217.110.199.117])
        by dd28836.kasserver.com (Postfix) with ESMTPSA id 14D92301D1C;
        Fri, 23 Sep 2016 12:40:29 +0200 (CEST)
To:     anatoly.borodin@gmail.com (Anatoly Borodin), git@vger.kernel.org
In-Reply-To: <ns1gr4$pjs$1@blaine.gmane.org>
Subject: Re: Limitiations of git rebase --preserve-merges --interactive
From:   lists@haller-berlin.de (Stefan Haller)
Date:   Fri, 23 Sep 2016 12:40:29 +0200
Message-ID: <1mu13z0.1hye7bq1uqj26sM%lists@haller-berlin.de>
User-Agent: MacSOUP/2.8.6b1 (Mac OS 10.11.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anatoly Borodin <anatoly.borodin@gmail.com> wrote:

> PS There are also some pieces of "what should work" in these tests:
> 
> t/t3409-rebase-preserve-merges.sh*
> t/t3410-rebase-preserve-dropped-merges.sh*
> t/t3411-rebase-preserve-around-merges.sh*
> t/t3414-rebase-preserve-onto.sh*

Thanks, this is interesting; I'm having trouble understanding the tests
though. Some of them use rebase -p -i, but I don't understand why they
use -i, or why that even works in a test (i.e. why it doesn't open an
editor).

In one test I saw "GIT_EDITOR=: git rebase -i -p", which I guess means
"use the initially given todo sheet unchanged". I don't see any tests
that do an interactive rebase and actually change the todo list.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/

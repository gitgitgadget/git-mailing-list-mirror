Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 298951F4DD
	for <e@80x24.org>; Fri, 25 Aug 2017 08:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754947AbdHYIZz (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 04:25:55 -0400
Received: from dd28836.kasserver.com ([85.13.147.76]:47727 "EHLO
        dd28836.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754895AbdHYIZy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 04:25:54 -0400
X-Greylist: delayed 573 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Aug 2017 04:25:54 EDT
Received: from [10.1.0.148] (nat1.ableton.net [217.110.199.117])
        by dd28836.kasserver.com (Postfix) with ESMTPSA id B4873300633;
        Fri, 25 Aug 2017 10:16:19 +0200 (CEST)
To:     stefandotterweich@gmx.de (Stefan Dotterweich), git@vger.kernel.org
Cc:     paulus@samba.org (Paul Mackerras)
In-Reply-To: <6d65267a-1811-8c25-dd59-98fa5ef19655@gmx.de>
Subject: Re: [PATCH] gitk: different color for boundary commits
From:   lists@haller-berlin.de (Stefan Haller)
Date:   Fri, 25 Aug 2017 10:16:20 +0200
Message-ID: <1nbb55y.15cu111u8kiwwM%lists@haller-berlin.de>
User-Agent: MacSOUP/2.8.6b1 (Mac OS 10.12.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Dotterweich <stefandotterweich@gmx.de> wrote:

> When using filters, the commit list shows not only commits matching
> the filter criteria, but also boundary commits. When going through a
> list of say, all commits changing the variable `foo`, often half of
> the displayed commits are boundary commits. In this case the boundary
> commits are of little interest.
> 
> However, there is no way to hide them or quickly distinguish them from
> the actual commits.  Boundary commits can be identified by the white
> color inside the circle, but that is not easily recognisable.  On each
> line you  have to look at the circle color to identify the commit
> type. This makes it hard to just quickly skim a list of commits,
> especially when looking at dates and authors which are further to the
> right.
> 
> Therefore, to make boundary commits easier to recognise, display their
> text in a different color.

I would like to go one step further and not show the boundary commits at
all. Why do we need them again? (I think this has been discussed before,
but I can't find it right now. The only reference I could find is this
thread: <https://public-inbox.org/git/571F6852.1070405@qt.io/T/#u>,
which doesn't explain *why* gitk shows the boundary commits in the first
place.)

In my opinion, when saying "gitk --author=foo", the list of commits in
the top pane should look the same as the ouput of 
"git log --oneline --author=foo".


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/

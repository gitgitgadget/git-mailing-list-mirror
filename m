Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C97220989
	for <e@80x24.org>; Tue, 11 Oct 2016 01:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752867AbcJKBOq (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 21:14:46 -0400
Received: from sobre.alvarezp.com ([173.230.155.94]:48892 "EHLO
        sobre.alvarezp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752674AbcJKBOq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 21:14:46 -0400
X-Greylist: delayed 616 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Oct 2016 21:14:45 EDT
Received: from [IPv6:2806:220:2:4:d307:486a:3563:beab] (unknown [IPv6:2806:220:2:4:d307:486a:3563:beab])
        by sobre.alvarezp.com (Postfix) with ESMTPSA id 8DD81614C
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 21:04:27 -0400 (EDT)
To:     git@vger.kernel.org
From:   Octavio Alvarez <alvarezp@alvarezp.ods.org>
Subject: Invisible file remove during merge
Message-ID: <d7e42701-363b-70a4-8eb0-da4715cd9ba5@alvarezp.ods.org>
Date:   Mon, 10 Oct 2016 18:04:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

If I do a "git rm file" during conflict resolution, the removed file
(mysterious-file.txt) does not show up on "git log --stat" nor "git show
--patch" for the merge commit.

"git log --all --stat --follow -- mysterious-file.txt" only shows the
commit where the file was added.

I also tried --full-history

I prepared a sample repository that exhibits a behavior I was not expecting:

https://github.com/alvarezp/invisible-remove-git-demo

Am I missing some option?

Thanks.


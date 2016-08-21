Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5304D1FD99
	for <e@80x24.org>; Sun, 21 Aug 2016 02:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbcHUCqt (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Aug 2016 22:46:49 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:35162 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751936AbcHUCqs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2016 22:46:48 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id D14DE1FD99;
        Sun, 21 Aug 2016 02:46:47 +0000 (UTC)
Date:   Sun, 21 Aug 2016 02:46:47 +0000
From:   Eric Wong <e@80x24.org>
To:     Nikolaus Rath <Nikolaus@rath.org>
Cc:     git@vger.kernel.org
Subject: Re: Most recent revision that contains a string
Message-ID: <20160821024647.GA19536@starla>
References: <87d1l3ce40.fsf@thinkpad.rath.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87d1l3ce40.fsf@thinkpad.rath.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nikolaus Rath <Nikolaus@rath.org> wrote:
> What's the easiest way to find the most recent revision (of any file in
> the repository, including those that have been deleted in the current
> HEAD) that contains a given string?

I normally do something like:

	git log -r --raw -p -SSTRING
	git log -r --raw -p -GREGEXP

You can also add --diff-filter=D to filter only on deletes.


Btw, please don't set these headers on kernel.org lists:

	Mail-Copies-To: never
	Mail-Followup-To: git@vger.kernel.org

Like any mail server, vger fails from time-to-time and
reply-to-all prevents it from being a single point of failure.
Thanks.

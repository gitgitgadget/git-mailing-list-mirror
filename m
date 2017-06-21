Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB28C20D0C
	for <e@80x24.org>; Wed, 21 Jun 2017 22:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbdFUWg6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 18:36:58 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47570 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751755AbdFUWg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 18:36:58 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id AA6E620D0C;
        Wed, 21 Jun 2017 22:36:57 +0000 (UTC)
Date:   Wed, 21 Jun 2017 22:36:57 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Tim Hutt <tdhutt@gmail.com>, git@vger.kernel.org
Subject: Re: Monitoring a repository for changes
Message-ID: <20170621223657.GA1141@dcvr>
References: <CAKuVd4Bdhreu6wrwDp1Bia56Db=TXYMQcitsznaRM+QcYVzJnQ@mail.gmail.com>
 <87efud8jrn.fsf@gmail.com>
 <20170621195252.GA31582@starla>
 <87a85180om.fsf@gmail.com>
 <20170621222013.GA24176@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170621222013.GA24176@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> wrote:
> And, yes, email does seem redundant, and
> modern header sizes (with DKIM, etc) are gigantic; but
> connection lifetime and concurrency is manageable to the server
> even if not instantaneous.

I should add that any email notification message should be
significantly shorter than a normal message going to the list;
possibly just a parsable subject line and empty body.

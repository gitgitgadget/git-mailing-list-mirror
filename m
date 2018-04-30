Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF410215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 16:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754852AbeD3Qqe (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 12:46:34 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:46150 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753334AbeD3Qqe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 12:46:34 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id E6EED215F4;
        Mon, 30 Apr 2018 16:46:33 +0000 (UTC)
Date:   Mon, 30 Apr 2018 16:46:33 +0000
From:   Eric Wong <e@80x24.org>
To:     Stefan Beller <sbeller@google.com>,
        Samuel Lijin <sxlijin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: public-inbox.org down?
Message-ID: <20180430164633.GA22326@dcvr>
References: <CAJZjrdWEgdXmcXuxmF2CH3S6SZT8Lt-3Cw8ZJKiN6fnig-wivg@mail.gmail.com>
 <CAGZ79kaKqVyq=y6Ocbhg8Unb2eKLSzNUkE0ZNHBgC1Tvkiu3vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kaKqVyq=y6Ocbhg8Unb2eKLSzNUkE0ZNHBgC1Tvkiu3vg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oops, some upgrades went awry for the non-Tor HTTPS endpoint termination.

The Tor .onions should remain available if that happens
http://ou63pmih66umazou.onion/git
http://czquwvybam4bgbro.onion/git
http://hjrcffqmbrq6wope.onion/git

nntp://ou63pmih66umazou.onion/inbox.comp.version-control.git
nntp://czquwvybam4bgbro.onion/inbox.comp.version-control.git
nntp://hjrcffqmbrq6wope.onion/inbox.comp.version-control.git


And my monitoring scripts didn't test HTTPS :x  Just fixed that, at least.

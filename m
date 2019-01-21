Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B44D1F453
	for <e@80x24.org>; Mon, 21 Jan 2019 21:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfAUVAZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 16:00:25 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:38434 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbfAUVAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 16:00:25 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 1525A1F453;
        Mon, 21 Jan 2019 21:00:25 +0000 (UTC)
Date:   Mon, 21 Jan 2019 21:00:24 +0000
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: testing some changes to a public-inbox .onion
Message-ID: <20190121210024.7ywfhke2rwxzjx77@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

WITHOUT reading meta@public-inbox.org, maybe some of you
can spot some differences :)   You'll need to use Tor
to access .onions, of course:

       http://hjrcffqmbrq6wope.onion/git/

Tested with Netsurf and dillo.

People with machines powerful enough to run Firefox
(or Tor Browser Bundle) can use "View -> Page Style" to
adjust colors.

Unfortunate downside is current page rendering on the
server-side is 10-20% slower than before.

And there's a big fairness problem with the current
implementation of bl^H^Ha "new feature" :>

So I'll need to address the fairness problems before I can
comfortably deploy it on the non-Tor endpoint.

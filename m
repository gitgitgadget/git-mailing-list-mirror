Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5415720193
	for <e@80x24.org>; Thu, 11 Aug 2016 19:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbcHKTnf (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 15:43:35 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:46784 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751093AbcHKTne (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 15:43:34 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C00620193;
	Thu, 11 Aug 2016 19:43:33 +0000 (UTC)
Date:	Thu, 11 Aug 2016 19:43:33 +0000
From:	Eric Wong <e@80x24.org>
To:	git@vger.kernel.org
Subject: public-inbox.org/git updates
Message-ID: <20160811194333.GA27387@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This mainly affects the folks following the top-level
Atom feed at https://public-inbox.org/git/new.atom
or over NNTP.

There'll be over 5000K injected messages from 2006 I missed from
the initial import :x

I noticed this while adding gmane:NNNN mapping support to the
search engine:
  https://public-inbox.org/git/20160811002819.GA8311@starla/T/#u

There will still be some missing messages because some are spam.
news.gmane.org remains up if you want to check my work
(please do, because I am careless)


Also, the following two .onions are geographically separate
so it should remain up if the main server at
http://ou63pmih66umazou.onion/git/ goes down.  These two are
on better hardware than the main one:

	http://czquwvybam4bgbro.onion/git/
	http://hjrcffqmbrq6wope.onion/git/

Users without tor installed may use one of the MITM proxies at
run by www.tor2web.org, too.

And yes, I break stuff all the time and often run barely-tested
development code on my server(s) :>


Finally, HTTPS termination for public-inbox.org is provided by
yahns, a Ruby/Rack server: git clone git://yhbt.net/yahns
(more barely-tested code running off ruby/trunk)

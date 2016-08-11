Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_SBL,
	URIBL_SBL_A shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9B6C2018E
	for <e@80x24.org>; Thu, 11 Aug 2016 00:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbcHKA2Z (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 20:28:25 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:58956 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932543AbcHKA2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 20:28:25 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 390322018E;
	Thu, 11 Aug 2016 00:28:19 +0000 (UTC)
Date:	Thu, 11 Aug 2016 00:28:19 +0000
From:	Eric Wong <e@80x24.org>
To:	git@vger.kernel.org
Cc:	Lars Schneider <larsxschneider@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
Subject: Re: Alternatives to mid.gmane.org?
Message-ID: <20160811002819.GA8311@starla>
References: <481D1EE2-6A66-418F-AB28-95947BBF3680@gmail.com>
 <CACsJy8Cr-=09dDMTNpqobPkcVjU54+b-fLX61+cz2jkS8o+Tiw@mail.gmail.com>
 <20160728220601.GA13110@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160728220601.GA13110@dcvr>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eric Wong <e@80x24.org> wrote:
> Duy Nguyen <pclouds@gmail.com> wrote:
> > I read this and thought "temporarily" but apparently it's not [1]. A
> > lot of our links in the mail archive are gmane's :(
> > 
> > [1] https://lars.ingebrigtsen.no/2016/07/28/the-end-of-gmane/
> 
> I may not have time to integrate this extensibly into the public-inbox
> search engine today, but at least here is an NNTP article number to
> Message-ID mapping for non-NNTP users:

I'm working on getting "gmane:NNN" searches working.

I'm deploying and reindexing this change to one of the onions, first.
So, to get article 123 from "gmane:123":

	http://czquwvybam4bgbro.onion/git/?q=gmane%3A123

	(%3A is the URI escape for ':')

For those unable to run Tor, you can also try using a Tor2web
proxy listed at https://www.tor2web.org/  For example:

	http://czquwvybam4bgbro.onion.to/git/?q=gmane%3A123

Additionally, searching by Message-ID with the search box will
also work after the reindexing (instead of just using the
Message-ID in the URL):

	https://public-inbox.org/meta/20160810232358.GA29130@whir/

After this is fully-deployed and working well; the plan is also
to be able to fix existing gmane links (and also handling
the $gmane/NNN links that were commonly used).

> https://public-inbox.org/.temp/gmane.comp.version-control.git-300599.txt.gz
> (~5 MB)
> 
> Script used to generate this:
> 
> https://public-inbox.org/meta/20160728220145.13024-1-e@80x24.org/

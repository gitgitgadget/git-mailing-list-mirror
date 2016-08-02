Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 496881F855
	for <e@80x24.org>; Tue,  2 Aug 2016 00:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755469AbcHBAIP (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 20:08:15 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55124 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755462AbcHBAIN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 20:08:13 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CC661F855;
	Tue,  2 Aug 2016 00:07:36 +0000 (UTC)
Date:	Tue, 2 Aug 2016 00:07:36 +0000
From:	Eric Wong <e@80x24.org>
To:	Jeff King <peff@peff.net>
Cc:	Stefan Tauner <stefan.tauner@gmx.at>, git@vger.kernel.org
Subject: Re: Un-paged commit messages in git filter-branch's commit-filter?
Message-ID: <20160802000736.GA8716@starla>
References: <0McmFl-1aux6M2oV7-00Hv9A@mail.gmx.com>
 <20160616095947.GA15988@sigill.intra.peff.net>
 <0MTjMy-1buKad2Fg8-00QUQV@mail.gmx.com>
 <20160801213631.2ttdlermxw2wbnbi@sigill.intra.peff.net>
 <0LzskF-1bGAH81g5T-014za7@mail.gmx.com>
 <20160801232429.mb43wxev5lyhxyiw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160801232429.mb43wxev5lyhxyiw@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> I don't recall offhand whether git-svn does line-wrapping or any other
> commit-message munging.

Definitely no line-wrapping.  Munging is minimal:
it respects i18n.commitencoding, adds a trailing newline,
and "git-svn-id:" line.

Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EAEB1FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 17:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbcFWRaw (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 13:30:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:59179 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750979AbcFWRav (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 13:30:51 -0400
Received: (qmail 29782 invoked by uid 102); 23 Jun 2016 17:30:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 13:30:51 -0400
Received: (qmail 12667 invoked by uid 107); 23 Jun 2016 17:31:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 13:31:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jun 2016 13:30:48 -0400
Date:	Thu, 23 Jun 2016 13:30:48 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Simon Courtois <scourtois@cubyx.fr>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/7] more ANSI attributes
Message-ID: <20160623173048.GA19923@sigill.intra.peff.net>
References: <etPan.576bcdfa.7aee6fa4.9bf5@cubyx.fr>
 <20160623130828.GA25209@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160623130828.GA25209@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Here's a re-roll of my earlier patches to add "italic" support.

It fixes the documentation problem Junio mentioned (along with some
other issues there). It also cleans up parse_attr() to make it a bit
easier to read and maintain, and adds a few more features.

  [1/7]: color: fix max-size comment
  [2/7]: doc: refactor description of color format
  [3/7]: add skip_prefix_mem helper
  [4/7]: color: refactor parse_attr
  [5/7]: color: allow "no-" for negating attributes
  [6/7]: color: support "italic" attribute
  [7/7]: color: support strike-through attribute

-Peff

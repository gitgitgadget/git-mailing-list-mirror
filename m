Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4927E20189
	for <e@80x24.org>; Wed, 22 Jun 2016 19:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230AbcFVTjI (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 15:39:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:58725 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751400AbcFVTjH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 15:39:07 -0400
Received: (qmail 7379 invoked by uid 102); 22 Jun 2016 19:39:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Jun 2016 15:39:06 -0400
Received: (qmail 5004 invoked by uid 107); 22 Jun 2016 19:39:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Jun 2016 15:39:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Jun 2016 15:39:04 -0400
Date:	Wed, 22 Jun 2016 15:39:04 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/2] t/perf tests against older versions
Message-ID: <20160622193904.GA1509@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

One of the points of the t/perf suite is to be able to detect
performance regressions between versions. But I don't think anybody
really runs it systematically; we mostly just use it to show off our
shiny new improvements. :)

So I decided to run the suite against v2.0.0 and v2.9.0, to catch any
regressions that have crept in the past few years. The good news is that
there aren't any. But I did need a few patches to show that:

  [1/2]: t/perf: fix regression in testing older versions of git
  [2/2]: p4211: explicitly disable renames in no-rename test

The first one fixes the issue I reported in [1], which let me run the
suite against v2.0.0 at all. And the second fixes something that looks
like a regression in the results, but really isn't.

-Peff

[1] http://article.gmane.org/gmane.comp.version-control.git/297875



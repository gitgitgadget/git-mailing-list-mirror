From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] Add date formatting and parsing functions relative
 to a given time
Date: Sun, 30 Aug 2009 22:22:28 -0400
Message-ID: <20090831022228.GA4833@coredump.intra.peff.net>
References: <20090830093642.GA30922@coredump.intra.peff.net>
 <20090830214309.GA16119@coredump.intra.peff.net>
 <20090830215127.GA16303@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 04:22:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhwXY-0004WT-6A
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 04:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217AbZHaCWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 22:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754202AbZHaCWa
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 22:22:30 -0400
Received: from peff.net ([208.65.91.99]:33411 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754134AbZHaCWa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 22:22:30 -0400
Received: (qmail 20260 invoked by uid 107); 31 Aug 2009 02:22:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 30 Aug 2009 22:22:42 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Aug 2009 22:22:28 -0400
Content-Disposition: inline
In-Reply-To: <20090830215127.GA16303@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127451>

On Sun, Aug 30, 2009 at 05:51:27PM -0400, Jeff King wrote:

> I think the most sane thing is to rebase the whole series on top of
> lt/approxidate. Let me see what I can do.

And here it is. It was a little more complex than a simple rebase
because lt/approxidate actually introduced new bugs. :) Hopefully this
will be the last re-roll required.

The new series applies on top of lt/approxidate, and contains:

  [1/4]: Add date formatting and parsing functions relative to a given time
  [2/4]: refactor test-date interface
  [3/4]: tests: add date printing and parsing tests
  [4/4]: fix approxidate parsing of relative months and years

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/10] userdiff: cpp pattern simplification and test
 framework
Date: Mon, 24 Mar 2014 17:49:54 -0400
Message-ID: <20140324214954.GG13728@sigill.intra.peff.net>
References: <53282741.5010609@web.de>
 <cover.1395433874.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org,
	Thomas Rast <tr@thomasrast.ch>, l.s.r@web.de,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Mar 24 22:50:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSCkt-0007ee-Bl
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 22:50:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbaCXVt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 17:49:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:46129 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751553AbaCXVt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 17:49:56 -0400
Received: (qmail 9834 invoked by uid 102); 24 Mar 2014 21:49:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Mar 2014 16:49:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Mar 2014 17:49:54 -0400
Content-Disposition: inline
In-Reply-To: <cover.1395433874.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244884>

On Fri, Mar 21, 2014 at 10:07:12PM +0100, Johannes Sixt wrote:

> Here is a series that makes the hunk header pattern for C and C++ even
> simpler than suggested by Peff in [1] to catch a lot more C++ functions
> and two more C patterns.
> 
> As a preparatory work, the test cases are totally rewritten to make it
> a lot simpler to drop in new tests. There was an earlier attempt to
> change the infrastructure [2], and it is the reason for the widened Cc
> list.

Thanks. This looks sane overall, and I am especially happy about the
increased test coverage. I do not know if your 10/10 misses some cases,
but at least now we can collect and reason about a set of examples going
forward.

-Peff

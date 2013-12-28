From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] t0000 cleanups
Date: Sat, 28 Dec 2013 04:27:32 -0500
Message-ID: <20131228092731.GA26337@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>, Thomas Rast <tr@thomasrast.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 28 10:27:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwqBK-0007B9-0A
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 10:27:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094Ab3L1J1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 04:27:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:51485 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753822Ab3L1J1e (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 04:27:34 -0500
Received: (qmail 632 invoked by uid 102); 28 Dec 2013 09:27:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 28 Dec 2013 03:27:34 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Dec 2013 04:27:32 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239761>

When I want to debug a failing test, I often end up doing:

  cd t
  ./t4107-<tab> -v -i
  cd tra<tab>

The test names are long, so tab-completing on the trash directory is
very helpful. Lately I've noticed that there are a bunch of crufty trash
directories in my t/ directory, which makes my tab-completion more
annoying.

It turns out they're leftovers from t0000 running, due to a bad
interaction with some other fixes from last April. The first patch fixes
that.

The second patch is a follow-on cleanup enabled by the first.

The third is an unrelated cleanup that I noticed when I ran t0000 47
times in a row. :)

  [1/3]: t0000: set TEST_OUTPUT_DIRECTORY for sub-tests
  [2/3]: t0000: simplify HARNESS_ACTIVE hack
  [3/3]: t0000: drop "known breakage" test

 t/t0000-basic.sh | 19 +++++++------------
 t/test-lib.sh    |  2 --
 2 files changed, 7 insertions(+), 14 deletions(-)

-Peff

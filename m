From: Jeff King <peff@peff.net>
Subject: [PATCH 0/7] create argv_array API
Date: Tue, 13 Sep 2011 17:50:26 -0400
Message-ID: <20110913215026.GA26743@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 23:51:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3asz-0007N6-D2
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 23:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932864Ab1IMVu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 17:50:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37173
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932836Ab1IMVu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 17:50:28 -0400
Received: (qmail 1830 invoked by uid 107); 13 Sep 2011 21:51:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Sep 2011 17:51:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Sep 2011 17:50:26 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181307>

On Tue, Sep 13, 2011 at 10:34:58AM -0700, Junio C Hamano wrote:

> > Will do. Junio, do you want me to re-roll the quadratic fix, or just
> > build the refactoring on top?
> 
> The latter would be fine and it probably is not even urgent.

I went ahead and did it now, while it is still in my head. The first two
patches are unrelated fixups I noticed while working on it. The third is
the refactoring, and then the rest use it in various places. They're
certainly not urgent, and the final one borders on code churn, so they
may not all be worth applying.  But I don't think they conflict with
anything in 'next', so now might be a good time.

These are on top of what you have in jk/maint-fetch-submodule-check-fix.

  [1/7]: add sha1_array API docs
  [2/7]: quote.h: fix bogus comment
  [3/7]: refactor argv_array into generic code
  [4/7]: quote: provide sq_dequote_to_argv_array
  [5/7]: bisect: use argv_array API
  [6/7]: checkout: use argv_array API
  [7/7]: run_hook: use argv_array API

-Peff

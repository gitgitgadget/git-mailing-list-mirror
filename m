From: Jeff King <peff@peff.net>
Subject: [PATCH 0/5] coverity mixed bag
Date: Thu, 24 Jul 2014 00:39:41 -0400
Message-ID: <20140724043940.GA31282@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <stefanbeller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 24 06:39:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAAor-0001bc-S1
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 06:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934045AbaGXEju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 00:39:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:39349 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934043AbaGXEjt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 00:39:49 -0400
Received: (qmail 20323 invoked by uid 102); 24 Jul 2014 04:39:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Jul 2014 23:39:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jul 2014 00:39:41 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254143>

Since Stefan has recently started feeding git builds to coverity, I
spent a few minutes poking through the results. There are tons of false
positives, so there is some work to be done there with tweaking our
coverity models. But there are some real issues, too. Here are fixes for
the handful that I looked at.

  [1/5]: receive-pack: don't copy "dir" parameter
  [2/5]: free ref string returned by dwim_ref
  [3/5]: transport: fix leaks in refs_from_alternate_cb
  [4/5]: fix memory leak parsing core.commentchar
  [5/5]: apply: avoid possible bogus pointer

-Peff

From: Jeff King <peff@peff.net>
Subject: [PATCH 0/4] mediawiki/credential cleanups
Date: Wed, 18 Jul 2012 08:03:07 -0400
Message-ID: <20120718120307.GA6399@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jul 18 14:03:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrSyd-0004tB-74
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 14:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142Ab2GRMD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 08:03:27 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39065
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753257Ab2GRMDP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 08:03:15 -0400
Received: (qmail 18814 invoked by uid 107); 18 Jul 2012 12:03:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jul 2012 08:03:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jul 2012 08:03:07 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201676>

Hi Matthieu,

Your initial credential plumbing series went by while I was on vacation,
and I finally got a chance to look at it in more detail. Overall it
looks very good; thank you (and your students) for working on it. It was
especially nice to have a test harness with complete instructions. :)

I came up with a few commits on top. Patches 1 and 2 are cleanups that should
hopefully be non-controversial. Patch 3 is the "url=" attribute we
discussed earlier, and then patch 4 makes use of it in mw-to-git.

  [1/4]: docs/credential: minor clarity fixups
  [2/4]: mw-to-git: check blank credential attributes via length
  [3/4]: credential: convert "url" attribute into its parsed subparts
  [4/4]: mw-to-git: use git-credential's URL parser

 Documentation/git-credential.txt       | 22 ++++++++++++++++------
 contrib/mw-to-git/git-remote-mediawiki | 34 +++++-----------------------------
 credential.c                           |  2 ++
 3 files changed, 23 insertions(+), 35 deletions(-)

-Peff

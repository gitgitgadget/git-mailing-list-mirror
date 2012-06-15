From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] diff --no-index pager cleanups
Date: Fri, 15 Jun 2012 16:28:13 -0400
Message-ID: <20120615202813.GA12253@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 22:28:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sfd80-0005bF-Gp
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 22:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757770Ab2FOU2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 16:28:16 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:57777
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757759Ab2FOU2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 16:28:16 -0400
Received: (qmail 3803 invoked by uid 107); 15 Jun 2012 20:28:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Jun 2012 16:28:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jun 2012 16:28:13 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200094>

While testing Tim's broken case, I noticed a few annoyances with the
pager handling. These patches should clear them up.

  [1/2]: fix pager.diff with diff --no-index
  [2/2]: do not run pager with diff --no-index --quiet

-Peff

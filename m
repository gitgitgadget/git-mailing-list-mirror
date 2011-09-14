From: Jeff King <peff@peff.net>
Subject: [PATCH 0/5] credential helper super fun pak
Date: Wed, 14 Sep 2011 15:17:04 -0400
Message-ID: <20110914191704.GA23201@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Brian Gernhardt <benji@silverinsanity.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 21:17:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3uxP-0002jt-Lg
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 21:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519Ab1INTRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 15:17:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35547
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757306Ab1INTRG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 15:17:06 -0400
Received: (qmail 13595 invoked by uid 107); 14 Sep 2011 19:17:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Sep 2011 15:17:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Sep 2011 15:17:04 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181388>

Here's a mixed bag of bugfix commits to go on top of what's in
jk/http-auth-keyring.

  [1/5]: docs: minor tweaks to credentials API

    Clarifications in response to comments from Junio on the original
    series.

  [2/5]: credential-cache: fix expiration calculation corner cases

    This fixes the failures in t0300 on OS X.

  [3/5]: t0300: make askpass tests a little more robust
  [4/5]: t0300: make alternate username tests more robust

    These two just make the tests more rigorous so that patch 5/5
    can actually demonstrate the failure it's fixing.

  [5/5]: credential-store: use a better storage format

    This makes multiple usernames on the same host work with
    credential-store (they already work with credential-cache).

-Peff

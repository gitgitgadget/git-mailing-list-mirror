From: Jeff King <peff@peff.net>
Subject: [PATCH v2 0/4] peel-ref optimization fixes
Date: Sun, 17 Mar 2013 04:21:39 -0400
Message-ID: <20130317082139.GA29505@sigill.intra.peff.net>
References: <20130316090018.GA26708@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 17 09:22:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH8rG-0007yi-MT
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 09:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756038Ab3CQIVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 04:21:45 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54161 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756028Ab3CQIVl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 04:21:41 -0400
Received: (qmail 7680 invoked by uid 107); 17 Mar 2013 08:23:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Mar 2013 04:23:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Mar 2013 04:21:39 -0400
Content-Disposition: inline
In-Reply-To: <20130316090018.GA26708@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218345>

Here's a re-roll that takes into account the feedback from round 1:

  [1/4]: avoid segfaults on parse_object failure
  [2/4]: use parse_object_or_die instead of die("bad object")

These two patches are new; they are conceptually independent of the rest
of the series, but there's a textual dependency in later patches.

  [3/4]: pack-refs: write peeled entry for non-tags

Same as before, but rebased on patch 1, and s/``/$()/.

  [4/4]: pack-refs: add fully-peeled trait

Rewritten using Michael's approach, which is more readable.

-Peff

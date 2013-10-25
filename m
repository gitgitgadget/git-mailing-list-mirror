From: Jeff King <peff@peff.net>
Subject: [PATCHv2 0/19] pack bitmaps
Date: Fri, 25 Oct 2013 01:55:21 -0400
Message-ID: <20131025055521.GD11810@sigill.intra.peff.net>
References: <20131024175915.GA23398@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent Marti <vicent@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 25 07:55:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZaMr-00081O-ST
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 07:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192Ab3JYFzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 01:55:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:55277 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751066Ab3JYFzY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 01:55:24 -0400
Received: (qmail 2870 invoked by uid 102); 25 Oct 2013 05:55:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Oct 2013 00:55:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Oct 2013 01:55:21 -0400
Content-Disposition: inline
In-Reply-To: <20131024175915.GA23398@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236661>

On Thu, Oct 24, 2013 at 01:59:15PM -0400, Jeff King wrote:

> This series implements JGit-style pack bitmaps to speed up fetching and
> cloning.

Here is a re-roll fixing the comments so far. I know that nobody is
likely to have had a chance to read through it carefully yet, but given
the compiler warnings from the initial version, it makes sense to me to
get a clean baseline in front of people before they start reading the
old one. Given the size, I'll let this one collect more in-depth
comments for a bit before sending out another re-roll.

Besides the warning fixups, the ewah/* files have some style fixups to
better match git, and I added documentation for some config and
command-line options. I didn't add documentation for items I do not
expect people to actually use (e.g., "rev-list --test-bitmaps"), as they
clutter the documentation.

-Peff

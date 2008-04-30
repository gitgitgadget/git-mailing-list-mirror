From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] rename limit improvements
Date: Wed, 30 Apr 2008 13:21:37 -0400
Message-ID: <20080430172136.GA22601@sigill.intra.peff.net>
References: <20080426063209.5615dd5e.akpm@linux-foundation.org> <20080426135737.GA382@sigill.intra.peff.net> <20080426070656.e7a01d91.akpm@linux-foundation.org> <20080426145236.GA4367@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 19:22:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrG0h-0003Ev-EA
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 19:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757999AbYD3RVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 13:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757997AbYD3RVj
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 13:21:39 -0400
Received: from peff.net ([208.65.91.99]:4941 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757951AbYD3RVi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 13:21:38 -0400
Received: (qmail 27730 invoked by uid 111); 30 Apr 2008 17:21:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 30 Apr 2008 13:21:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Apr 2008 13:21:37 -0400
Content-Disposition: inline
In-Reply-To: <20080426145236.GA4367@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80852>

On Sat, Apr 26, 2008 at 10:52:36AM -0400, Jeff King wrote:

> > Perhaps the default should be bumped up a bit based on your measurements,
> > dunno.
> 
> Probably. I'll work up a patch for that, as well as suppressing the
> message on diffstat (where you really shouldn't care, and it serves only
> to scare users).

Here's a patch series trying to improve rename limits, based on my
discussion with Andrew and from some previous comments about the
settings[1].

Patch 1 allows separate renamelimit values for diff vs merge. Patch 2
bumps up the default values based on some measurements I did in
February. Patch 3 turns off the mostly cluttering warning message except
for merges.

[1]: http://permalink.gmane.org/gmane.comp.version-control.git/73470

-Peff

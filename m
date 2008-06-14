From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/.gitattributes: only ignore whitespace errors in
	test files
Date: Sat, 14 Jun 2008 02:48:57 -0400
Message-ID: <20080614064857.GA8930@sigill.intra.peff.net>
References: <1213310159-28049-1-git-send-email-LeWiemann@gmail.com> <20080613060629.GC26768@sigill.intra.peff.net> <7vod65wt6k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 08:50:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7Pag-0007QC-PM
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 08:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185AbYFNGtB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 02:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752075AbYFNGtB
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 02:49:01 -0400
Received: from peff.net ([208.65.91.99]:4151 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751962AbYFNGtA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 02:49:00 -0400
Received: (qmail 27717 invoked by uid 111); 14 Jun 2008 06:48:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 14 Jun 2008 02:48:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Jun 2008 02:48:57 -0400
Content-Disposition: inline
In-Reply-To: <7vod65wt6k.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84965>

On Fri, Jun 13, 2008 at 03:00:35AM -0700, Junio C Hamano wrote:

> Eventually we would want to make all of the t/*.sh not exempt from the
> whitespace rules.  Some currently do have trailing whitespaces as part of

This turned out to be a fairly easy change, as most of the places had
been caught already.

Four part patch series follows. The only one potentially not
maint-worthy is 3/4, because it actually changes git's output slightly.

  1/4: fix whitespace violations in test scripts
  2/4: mask necessary whitespace policy violations in test scripts
  3/4: avoid trailing whitespace in zero-change diffstat lines
  4/4: enable whitespace checking of test scripts

-Peff

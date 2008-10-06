From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] diff text conversion filter
Date: Mon, 6 Oct 2008 02:52:13 -0400
Message-ID: <20081006065212.GA19175@sigill.intra.peff.net>
References: <1222567618-22156-1-git-send-email-Matthieu.Moy@imag.fr> <20080928041040.GA24214@coredump.intra.peff.net> <vpqd4io1tla.fsf@bauges.imag.fr> <20080928161106.GA30199@coredump.intra.peff.net> <vpqk5ctfyp6.fsf@bauges.imag.fr> <20080930164545.GA20305@sigill.intra.peff.net> <20081005214114.GA21875@coredump.intra.peff.net> <48E9B036.6090805@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 06 08:55:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmk03-0004Rk-Ul
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 08:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769AbYJFGwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 02:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752714AbYJFGwR
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 02:52:17 -0400
Received: from peff.net ([208.65.91.99]:2371 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752628AbYJFGwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 02:52:16 -0400
Received: (qmail 21383 invoked by uid 111); 6 Oct 2008 06:52:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 06 Oct 2008 02:52:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Oct 2008 02:52:13 -0400
Content-Disposition: inline
In-Reply-To: <48E9B036.6090805@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97564>

On Mon, Oct 06, 2008 at 08:29:10AM +0200, Johannes Sixt wrote:

> Does the series in any way change whether plumbing and porcelain invoke
> the external diff drivers? I have this particular use-case, which I'd like
> that still works:

No, it tries to keep the behavior the same as it is now (in 2/4, note
how the diff driver config reading is split into porcelain and plumbing
sections). Let me know if you have a test case that doesn't work, or
that you would like me to try.

-Peff

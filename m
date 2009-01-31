From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/5] chain kill signals for cleanup functions
Date: Fri, 30 Jan 2009 20:44:20 -0500
Message-ID: <20090131014420.GA7696@sigill.intra.peff.net>
References: <20090122042643.GB31427@coredump.intra.peff.net> <20090122060235.GC30133@coredump.intra.peff.net> <20090130075552.GA27716@coredump.intra.peff.net> <4982B68C.2070207@viscovery.net> <20090130082101.GA28809@coredump.intra.peff.net> <7vd4e49v48.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 31 02:45:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT4ve-0003gy-7N
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 02:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496AbZAaBoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 20:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbZAaBoY
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 20:44:24 -0500
Received: from peff.net ([208.65.91.99]:58067 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992AbZAaBoY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 20:44:24 -0500
Received: (qmail 8975 invoked by uid 107); 31 Jan 2009 01:44:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 30 Jan 2009 20:44:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Jan 2009 20:44:20 -0500
Content-Disposition: inline
In-Reply-To: <7vd4e49v48.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107902>

On Fri, Jan 30, 2009 at 04:28:39PM -0800, Junio C Hamano wrote:

> > Hmm. Clever.
> >
> > Junio, can you apply this on top of the jk/signal-cleanup topic?
> 
> Will do, but I've been sick today, haven't caught up with the list
> traffic, and I do not think I'll be reading my mails for the rest of the
> day either.  It may take some time for it to appear in the public
> repositories.

No problem. It really is a fix for a false negative in the test, not any
actual git bug, so no rush.

Now I'm off to go make fun of you, buried deep in a thread where you
won't see it.

-Peff

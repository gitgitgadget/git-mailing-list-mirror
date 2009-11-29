From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] build dashless "test-bin" directory similar to
 installed bindir
Date: Sun, 29 Nov 2009 00:10:47 -0500
Message-ID: <20091129051047.GA6135@coredump.intra.peff.net>
References: <1259433537-3963-1-git-send-email-mmogilvi_git@miniinfo.net>
 <1259433537-3963-2-git-send-email-mmogilvi_git@miniinfo.net>
 <1259433537-3963-3-git-send-email-mmogilvi_git@miniinfo.net>
 <1259433537-3963-4-git-send-email-mmogilvi_git@miniinfo.net>
 <7vtywefn88.fsf@alter.siamese.dyndns.org>
 <20091128194910.GA17605@coredump.intra.peff.net>
 <7vaay6f4ce.fsf@alter.siamese.dyndns.org>
 <20091129034313.GA28379@coredump.intra.peff.net>
 <7vzl65ex6u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 29 06:10:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEc3f-0008KZ-L3
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 06:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbZK2FKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 00:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbZK2FKk
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 00:10:40 -0500
Received: from peff.net ([208.65.91.99]:41174 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082AbZK2FKj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 00:10:39 -0500
Received: (qmail 4117 invoked by uid 107); 29 Nov 2009 05:15:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 29 Nov 2009 00:15:12 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 29 Nov 2009 00:10:47 -0500
Content-Disposition: inline
In-Reply-To: <7vzl65ex6u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133992>

On Sat, Nov 28, 2009 at 09:07:05PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   make && cd t && make tXXXX-YYYY.sh
> >
> > to work correctly ...
> >
> > I also like to be able to simply run ./tXXXX-YYYY.sh.
> 
> I think both can be done by running "cd .. && make test-bin-stuff" from
> test-lib.sh if you wanted to.  Isn't it essentially what you do for
> valgrind?

Yes, except that the valgrind setup doesn't actually interact with the
Makefile; it just assumes that git-* is interesting. I would be happy
with a solution that is triggered from test-lib. It may even be possible
to refactor the valgrind stuff, but I'm not sure. What Dscho eventually
submitted doesn't bear much resemblence to my original attempt, and I've
forgotten all of the details.

-Peff

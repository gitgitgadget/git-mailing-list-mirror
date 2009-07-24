From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] SunOS grep does not understand -C<n>
Date: Fri, 24 Jul 2009 03:09:25 -0400
Message-ID: <20090724070925.GA2353@sigill.intra.peff.net>
References: <7vr5w6tzq8.fsf@alter.siamese.dyndns.org>
 <20090724054144.GC6563@sigill.intra.peff.net>
 <7vbpnasiiz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 09:10:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUEuQ-0002xp-Jr
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 09:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbZGXHJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 03:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbZGXHJ1
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 03:09:27 -0400
Received: from peff.net ([208.65.91.99]:55323 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751812AbZGXHJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 03:09:26 -0400
Received: (qmail 14383 invoked by uid 107); 24 Jul 2009 07:11:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 24 Jul 2009 03:11:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jul 2009 03:09:25 -0400
Content-Disposition: inline
In-Reply-To: <7vbpnasiiz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123907>

On Thu, Jul 23, 2009 at 11:27:00PM -0700, Junio C Hamano wrote:

> > Yes, I've been building with NO_EXTERNAL_GREP for my test box. The grep
> > from Solaris 8, at least, doesn't understand '-e' either, which causes
> > it to fail many other tests.
> 
> Thanks.
> 
> Just to double check, do we have "grep -e" (not "git grep -e") that makes
> Solaris fail?  I didn't notice.  Or do you mean "git grep -e" fails
> without NO_EXTERNAL_GREP?

I meant the latter; t7002 tests "git grep -e", which fails without
NO_EXTERNAL_GREP.

-Peff

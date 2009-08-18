From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] stash: reject stash name starting with a dash.
Date: Tue, 18 Aug 2009 19:54:46 -0400
Message-ID: <20090818235446.GA11153@sigill.intra.peff.net>
References: <7vbpmcc1sc.fsf@alter.siamese.dyndns.org>
 <1250631523-10524-1-git-send-email-Matthieu.Moy@imag.fr>
 <1250631523-10524-2-git-send-email-Matthieu.Moy@imag.fr>
 <1250631523-10524-3-git-send-email-Matthieu.Moy@imag.fr>
 <1250631523-10524-4-git-send-email-Matthieu.Moy@imag.fr>
 <20090818233535.GB6304@sigill.intra.peff.net>
 <7vocqc3cuz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 01:54:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdYVw-0002uY-3s
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 01:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbZHRXyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 19:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752199AbZHRXyr
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 19:54:47 -0400
Received: from peff.net ([208.65.91.99]:43420 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392AbZHRXyq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 19:54:46 -0400
Received: (qmail 16582 invoked by uid 107); 18 Aug 2009 23:54:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 18 Aug 2009 19:54:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Aug 2009 19:54:46 -0400
Content-Disposition: inline
In-Reply-To: <7vocqc3cuz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126487>

On Tue, Aug 18, 2009 at 04:45:40PM -0700, Junio C Hamano wrote:

> > Should this actually be "git stash save --invalid-option", since it is
> > really testing the actual save option parsing, and not the behavior to
> > automatically push options to "git stash save"?
> 
> It would be ideal if
> 
> 	git stash save --invalid-option
> 
> failed, while
> 
> 	git stash --invalid-option should be trapped
> 
> and/or
> 
> 	git stash "--invalid-option should be trapped"
> 
> are accepted as valid quickie ways to name a WIP stash before attending to
> an unrelated emergency.

I thought that was the exact DWIM that was rejected previously so that
you don't accidentally make commits with "git stash llist" or "git stash
--almost-a-valid-optio".

-Peff

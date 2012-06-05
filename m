From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] api-credentials.txt: add "see also" section
Date: Tue, 5 Jun 2012 11:35:12 -0400
Message-ID: <20120605153512.GA20148@sigill.intra.peff.net>
References: <1338739804-32167-1-git-send-email-Matthieu.Moy@imag.fr>
 <1338739804-32167-4-git-send-email-Matthieu.Moy@imag.fr>
 <7vsjecvxmc.fsf@alter.siamese.dyndns.org>
 <vpq1ulvuxd9.fsf@bauges.imag.fr>
 <20120604115630.GC27676@sigill.intra.peff.net>
 <vpqpq9en8ol.fsf@bauges.imag.fr>
 <20120605065955.GB25809@sigill.intra.peff.net>
 <20120605073403.GC25809@sigill.intra.peff.net>
 <7v1ultrdwi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 17:35:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbvnS-0007fJ-2V
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 17:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392Ab2FEPfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 11:35:15 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:43865
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752040Ab2FEPfP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 11:35:15 -0400
Received: (qmail 20424 invoked by uid 107); 5 Jun 2012 15:35:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Jun 2012 11:35:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jun 2012 11:35:12 -0400
Content-Disposition: inline
In-Reply-To: <7v1ultrdwi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199251>

On Tue, Jun 05, 2012 at 08:12:29AM -0700, Junio C Hamano wrote:

> > Here is a simple fix. The Makefile bits are more hacky than I would
> > like. It would be really nice if the asciidoc macro could convert "we
> > are working on X/Y/Z.html" into "we need ../../ to get to the relative
> > base", but I don't think it is that flexible.
> >
> > We could also replace asciidoc with a wrapper script that does the
> > conversion and sets the appropriate attribute. I don't know if it is
> > worth the trouble. It's not like we add documentation subdirectories
> > very often.
> 
> Sorry, but I am not sure what problem is this trying to solve.  An
> API documentation page should only refer to command documentaion
> pages, and never another API documentation page that is at the same
> level?

No, but it should not use linkgit to do so (and if we did ever grow
linkgit targets in a subdirectory, it should call them with the full
directory name from the documentation root, just as documents in the
root would do).

-Peff

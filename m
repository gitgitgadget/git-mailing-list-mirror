From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] update "make check-docs"
Date: Wed, 8 Aug 2012 16:10:14 -0400
Message-ID: <20120808201013.GA29528@sigill.intra.peff.net>
References: <1344412707-22356-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vmx25tj5y.fsf@alter.siamese.dyndns.org>
 <20120808183132.GA24550@sigill.intra.peff.net>
 <7v1ujhtcxk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 22:10:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzCaH-0001yc-Ql
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 22:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759216Ab2HHUKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 16:10:20 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57633 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759159Ab2HHUKT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 16:10:19 -0400
Received: (qmail 11273 invoked by uid 107); 8 Aug 2012 20:10:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Aug 2012 16:10:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Aug 2012 16:10:14 -0400
Content-Disposition: inline
In-Reply-To: <7v1ujhtcxk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203121>

On Wed, Aug 08, 2012 at 12:13:11PM -0700, Junio C Hamano wrote:

> > Hmm. We have a check-docs command? :)
> 
> Yes, and there also is a check-builtins target.  Perhaps the default
> build target should depend on them, as they are fairly lightweight?

I think they would want some refactoring. Right now the target does not
fail if there are errors. Any output it generates would typically scroll
by in the mass of other build data, so it would be easy to miss.

-Peff

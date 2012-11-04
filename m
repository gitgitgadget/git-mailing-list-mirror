From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] Simplify and document strbuf_split() functions
Date: Sun, 4 Nov 2012 06:50:44 -0500
Message-ID: <20121104115043.GB336@sigill.intra.peff.net>
References: <1352011614-29334-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Nov 04 12:51:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUyjE-0006IY-Bq
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 12:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465Ab2KDLuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 06:50:46 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56507 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751774Ab2KDLuq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2012 06:50:46 -0500
Received: (qmail 23111 invoked by uid 107); 4 Nov 2012 11:51:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 04 Nov 2012 06:51:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 04 Nov 2012 06:50:44 -0500
Content-Disposition: inline
In-Reply-To: <1352011614-29334-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209023>

On Sun, Nov 04, 2012 at 07:46:50AM +0100, Michael Haggerty wrote:

> The strbuf_split() family of functions was completely undocumented.
> Add documentation and also simplify the definition of
> strbuf_split_buf().

Thanks. Looks good overall, even with the comments I raised for patch 1
(I think it is not a big deal, and even if it does become a big deal,
the right fix is probably to make alloc_nr smarter about early growth).

-Peff

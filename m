From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] checkout/branch --quiet fixes
Date: Mon, 26 Mar 2012 19:49:44 -0400
Message-ID: <20120326234944.GA1901@sigill.intra.peff.net>
References: <86aa3k5ppk.fsf@red.stonehenge.com>
 <20120313200842.GA23664@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 01:49:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCJfd-0001B2-W4
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 01:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757862Ab2CZXtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 19:49:50 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60277
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757802Ab2CZXtt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 19:49:49 -0400
Received: (qmail 20055 invoked by uid 107); 26 Mar 2012 23:50:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Mar 2012 19:50:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2012 19:49:44 -0400
Content-Disposition: inline
In-Reply-To: <20120313200842.GA23664@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193989>

On Tue, Mar 13, 2012 at 04:08:43PM -0400, Jeff King wrote:

> > checkout without -q:
> > 
> >   Switched to a new branch 'projects/DUH-11'
> >   Branch projects/DUH-11 set up to track remote branch projects/DUH-11 from origin.
> > 
> > checkout with -q:
> > 
> >   Branch projects/DUH-11 set up to track remote branch projects/DUH-11 from origin.
> > 
> > Bug or feature?  If feature, how do I get it "more q'ey"?
> 
> Bug, I think. You'd need something like the patch below, except that:

Here it is cleaned up and with commit messages.

  [1/2]: checkout: suppress tracking message with "-q"
  [2/2]: teach "git branch" a --quiet option

Nobody commented on my "something like this" patch, but I think that is
largely because this topic is insanely boring.

-Peff

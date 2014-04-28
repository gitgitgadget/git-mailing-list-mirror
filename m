From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] PAGER_ENV: remove 'S' from $LESS by default
Date: Mon, 28 Apr 2014 12:24:39 -0400
Message-ID: <20140428162439.GA9844@sigill.intra.peff.net>
References: <20140425154722.GC11479@google.com>
 <1398674062-24288-1-git-send-email-Matthieu.Moy@imag.fr>
 <87vbtt6dyq.fsf@fencepost.gnu.org>
 <vpqsioxn82l.fsf@anie.imag.fr>
 <87k3a96cj9.fsf@fencepost.gnu.org>
 <vpq38gxlk3m.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org,
	gitster@pobox.com, jrnieder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 28 18:25:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeoMi-0001e8-Iu
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 18:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756465AbaD1QYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 12:24:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:40453 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756750AbaD1QYl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 12:24:41 -0400
Received: (qmail 749 invoked by uid 102); 28 Apr 2014 16:24:41 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Apr 2014 11:24:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Apr 2014 12:24:39 -0400
Content-Disposition: inline
In-Reply-To: <vpq38gxlk3m.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247374>

On Mon, Apr 28, 2014 at 02:22:21PM +0200, Matthieu Moy wrote:

> >> Not since f82c3ffd862c7 (Wed Feb 5 2014, move LESS/LV pager environment
> >> to Makefile).
> >
> > The only upstream branch containing this commit is pu.  So this patch
> > should likely not go anywhere else for now.
> 
> Oops, indeed, I made my patch on top of pu by mistake. Anyway, my patch
> can wait for the other series to be merged.
> 
> Jeff, you're the author of f82c3ffd862c7, topic jk/makefile in git.git,
> marked "expecting a reroll" by Junio. Any news from the series?

I am planning to revisit it eventually, but it's fairly low priority.
There is some pretty heavy refactoring in the series, and the PAGER_ENV
bits do not have to be held hostage to that refactoring (they are really
just demonstrating the refactoring).

I'd be OK with doing the moral equivalent for now (perhaps just taking
Junio's proposal[1]), and I can deal with the refactoring later when
re-rolling the Makefile series.

-Peff

[1] http://article.gmane.org/gmane.comp.version-control.git/240637

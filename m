From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/10] t4018: an infrastructure to test hunk headers
Date: Tue, 25 Mar 2014 17:42:33 -0400
Message-ID: <20140325214232.GA18217@sigill.intra.peff.net>
References: <53282741.5010609@web.de>
 <cover.1395433874.git.j6t@kdbg.org>
 <52505977c20a480941ae1f85f50ffb7a0bbffedb.1395433874.git.j6t@kdbg.org>
 <20140324213659.GF13728@sigill.intra.peff.net>
 <20140324213913.GA14890@sigill.intra.peff.net>
 <5331E1F6.1070506@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org,
	Thomas Rast <tr@thomasrast.ch>, l.s.r@web.de,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Mar 25 22:42:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSZ7J-0004kV-2L
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 22:42:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbaCYVmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 17:42:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:47158 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751380AbaCYVmf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 17:42:35 -0400
Received: (qmail 18711 invoked by uid 102); 25 Mar 2014 21:42:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 25 Mar 2014 16:42:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Mar 2014 17:42:33 -0400
Content-Disposition: inline
In-Reply-To: <5331E1F6.1070506@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245154>

On Tue, Mar 25, 2014 at 09:07:18PM +0100, Johannes Sixt wrote:

> Am 24.03.2014 22:39, schrieb Jeff King:
> > On Mon, Mar 24, 2014 at 05:36:59PM -0400, Jeff King wrote:
> > 
> >>> +How to write RIGHT test cases
> >>> +=============================
> >>> +
> >>> +Insert the word "ChangeMe" (exactly this form) at a distance of
> >>> +at least two lines from the line that must appear in the hunk header.
> >>
> >> The existing tests use -U1 to make writing cases simpler. Is there a
> >> reason not to continue that (or if you found that porting the existing
> >> cases was not a chore with -U3, I can buy that argument, too)?
> > 
> > I take it back. You did keep "-U1" in the result. Is this "two lines"
> > rule necessary, then?
> 
> When we have
> 
>    one
>    two
>    three
> 
> how would you describe the distance between "one" and "three"?

I read it as "two lines between". Though that would be appropriate for
-U2, so I think I probably had an off-by-one in my head, then, too.

So it is probably fine as-is, and this was mostly just me confusing
myself. Sorry for the noise.

-Peff

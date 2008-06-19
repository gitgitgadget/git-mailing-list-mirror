From: Jeff King <peff@peff.net>
Subject: Re: Including branch info in git format-patch
Date: Thu, 19 Jun 2008 17:08:05 -0400
Message-ID: <20080619210804.GA6700@sigill.intra.peff.net>
References: <20080619154251.GA16475@jurassic> <20080619202843.GA6207@sigill.intra.peff.net> <7vskv9rvrc.fsf@gitster.siamese.dyndns.org> <20080619210617.GC6529@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mukund Sivaraman <muks@banu.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 23:09:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9RNR-0002CG-UA
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 23:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbYFSVIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 17:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbYFSVIJ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 17:08:09 -0400
Received: from peff.net ([208.65.91.99]:4543 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032AbYFSVIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 17:08:09 -0400
Received: (qmail 21020 invoked by uid 111); 19 Jun 2008 21:08:08 -0000
Received: from c-24-98-46-248.hsd1.ga.comcast.net (HELO sigill.intra.peff.net) (24.98.46.248)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 19 Jun 2008 17:08:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jun 2008 17:08:05 -0400
Content-Disposition: inline
In-Reply-To: <20080619210617.GC6529@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85530>

On Thu, Jun 19, 2008 at 05:06:17PM -0400, Jeff King wrote:

> > the project's convention what to do with it.  The side branch the patch
> > was developed on may be named "quick-hack", which would not have any
> > relevance to the final location of where that patch wants to be in.
> 
> I suspect you would do better to look at branch.quick-hack.merge, so
> that you say "this was based on upstream's X", not "this is my
> quick-hack".
> 
> But there are so many ways this could go wrong, since the patches you're
> formatting might not even have anything to do with the branch you're on.

Side note: if you have a particular workflow, it might make sense,
rather than using format-patch directly, to codify that workflow in
another script which says "ok, this is how I grab a branch and send it
upstream". And in that case, you could look up "here's where I branched
from" and feed it into the patch via format-patch's --subject-prefix
option.

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Make test output coloring more intuitive
Date: Wed, 19 Sep 2012 16:13:26 -0400
Message-ID: <20120919201326.GA23016@sigill.intra.peff.net>
References: <1347882637-21766-1-git-send-email-git@adamspiers.org>
 <20120917201119.GB24888@sigill.intra.peff.net>
 <505A24EC.1000203@gmail.com>
 <20120919201201.GD19246@atlantic.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 22:13:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEQeP-0000ba-Ko
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 22:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602Ab2ISUN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 16:13:29 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49979 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751574Ab2ISUN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 16:13:28 -0400
Received: (qmail 5201 invoked by uid 107); 19 Sep 2012 20:13:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Sep 2012 16:13:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Sep 2012 16:13:26 -0400
Content-Disposition: inline
In-Reply-To: <20120919201201.GD19246@atlantic.linksys.moosehall>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205992>

On Wed, Sep 19, 2012 at 09:12:01PM +0100, Adam Spiers wrote:

> > > Sounds reasonable, and I think the new output looks nice. I notice that
> > > skipped tests are still in green. I wonder if they should be in yellow,
> > > too.
> > >
> > What about blue instead?   This would keep the colouring scheme more
> > consistent with the one used by prove:
> >   <http://search.cpan.org/~ovid/Test-Harness/bin/prove>
> > by autotest:
> >   <http://www.gnu.org/software/autoconf/manual/autoconf.html#Using-Autotest>
> > and by the Automake-generated test harness:
> >   <http://www.gnu.org/software/automake/manual/automake.html#Scripts_002dbased-Testsuites>
> 
> Sounds good to me!  Blue is the conventional color for informational
> signs, so seems like a natural fit for skipped tests.  Not sure
> whether it should be bold or not though?  I'll wait for a more solid
> group consensus before re-rolling yet another patch :-)

Blue would be fine with me. No strong opinion on bold or not (my gut is
that most things should not be bold unless there is a good reason, but
that is just a feeling).

-Peff

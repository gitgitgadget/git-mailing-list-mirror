From: Jeff King <peff@peff.net>
Subject: Re: Branch shuffling after 1.6.6 release plans
Date: Sat, 26 Dec 2009 03:01:24 -0500
Message-ID: <20091226080124.GA10337@sigill.intra.peff.net>
References: <7vpr65kwnt.fsf@alter.siamese.dyndns.org>
 <7vljgrgar9.fsf@alter.siamese.dyndns.org>
 <200912251230.48243.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Dec 26 09:03:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NORc3-0002pt-BC
	for gcvg-git-2@lo.gmane.org; Sat, 26 Dec 2009 09:02:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbZLZIB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Dec 2009 03:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbZLZIB1
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Dec 2009 03:01:27 -0500
Received: from peff.net ([208.65.91.99]:46587 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089AbZLZIB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2009 03:01:27 -0500
Received: (qmail 14509 invoked by uid 107); 26 Dec 2009 08:06:06 -0000
Received: from c-71-206-170-120.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.170.120)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 26 Dec 2009 03:06:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Dec 2009 03:01:24 -0500
Content-Disposition: inline
In-Reply-To: <200912251230.48243.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135685>

On Fri, Dec 25, 2009 at 12:30:34PM +0100, Thomas Rast wrote:

> >      * tr/reset-checkout-patch (2009-11-19) 1 commit
> >       - {checkout,reset} -p: make patch direction configurable
> > 
> >      I do not particularly like a configuration like this that changes the
> >      behaviour of a command in a drastic way---it will make helping others
> >      much harder.
> 
> I think it's not quite as drastic as you make it sound ;-)
> 
> But I don't need this feature, and Peff mentioned something about
> being happy except for the patch editing mode.  Unfortunately the
> above pretty much hits the limits of add--interactive's flexibility,
> so an interactive direction toggling feature would need some rewiring.

Let's drop it for now. I'm reasonably happy, and I don't want to waste
your time trying to do something more invasive. And I haven't seen any
evidence that anybody else is dissatisfied with what's in master.

-Peff

From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC/PATCH 5/6] Let transport_helper_init() decide if a remote
 helper program can be used
Date: Wed, 12 Aug 2009 12:21:40 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908121216570.27553@iabervon.org>
References: <alpine.LNX.2.00.0908101205120.27553@iabervon.org> <1249985426-13726-6-git-send-email-johan@herland.net> <alpine.LNX.2.00.0908111915100.27553@iabervon.org> <20090812074658.GE15152@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	gitster@pobox.com, benji@silverinsanity.com,
	Johannes.Schindelin@gmx.de
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 12 18:21:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbGaF-0006FW-0J
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 18:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754276AbZHLQVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 12:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754227AbZHLQVk
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 12:21:40 -0400
Received: from iabervon.org ([66.92.72.58]:33216 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754168AbZHLQVj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 12:21:39 -0400
Received: (qmail 678 invoked by uid 1000); 12 Aug 2009 16:21:40 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Aug 2009 16:21:40 -0000
In-Reply-To: <20090812074658.GE15152@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125715>

On Wed, 12 Aug 2009, Jeff King wrote:

> On Tue, Aug 11, 2009 at 07:28:19PM -0400, Daniel Barkalow wrote:
> 
> > of 'Could not find (...) "git remote-master.kernel.org" (...)'? That 
> > would be certain to upset some people. I think we can assume that people's 
> > scheme parts of their URLs that are actually URLs don't contain '.', and 
> > that people with:
> > 
> > 	url = master:something
> > 
> > will append their domains if the warning gets annoying.
> 
> Keep in mind that these URLs should be usable from the command-line,
> too. So it is not just appending the domain in the config, but appending
> it every time you want to do a one-off pull.

For that sort of thing, I think that url.*.insteadOf in your global config 
is the way to go. It applies before anything else, and can supply parts of 
the path as well as the hostname.

	-Daniel
*This .sig left intentionally blank*

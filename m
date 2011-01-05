From: Jeff King <peff@peff.net>
Subject: Re: Tracking branches and pulling on remote
Date: Wed, 5 Jan 2011 11:44:16 -0500
Message-ID: <20110105164416.GA4393@sigill.intra.peff.net>
References: <loom.20110105T013525-413@post.gmane.org>
 <20110105050108.GA5884@sigill.intra.peff.net>
 <4D249EFA.5050408@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Maaartin-1 <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Wed Jan 05 17:44:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaWTK-0002fl-UO
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 17:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763Ab1AEQoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 11:44:19 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:53052 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260Ab1AEQoT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 11:44:19 -0500
Received: (qmail 31915 invoked by uid 111); 5 Jan 2011 16:44:18 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 05 Jan 2011 16:44:18 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jan 2011 11:44:16 -0500
Content-Disposition: inline
In-Reply-To: <4D249EFA.5050408@seznam.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164572>

On Wed, Jan 05, 2011 at 05:40:26PM +0100, Maaartin-1 wrote:

> >   $ git config remote.origin.fetch
> >   +refs/heads/*:refs/remotes/origin/*
> > 
> > which is a superset of what you added. If you run the git config command
> > I did above, what do you see?
> 
> No, there had been just the single line
> 
> refs/heads/master:refs/remotes/origin/master

Ah, OK, then that is the culprit. And the config line you added was a
reasonable solution (though you may consider simply switching it to a
wildcard to cover any future branches, too).

> OK, I swapped origin and upstream and made aliases
> 	fetchboth = !"git fetch; git fetch upstream"
> 	fetup = fetch upstream
> which is about everything I need for now.

Cool. You can also use "git fetch --all" to do the equivalent of your
fetchboth.

-Peff

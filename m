From: Jeff King <peff@peff.net>
Subject: Re: git remote update -> rejected
Date: Tue, 22 Apr 2008 09:01:23 -0400
Message-ID: <20080422130122.GB27577@sigill.intra.peff.net>
References: <1208857733.4695.37.camel@marge.simson.net> <20080422103458.GA14751@sigio.intra.peff.net> <1208861703.18689.2.camel@marge.simson.net> <20080422111113.GB11238@sigill.intra.peff.net> <20080422124118.GA3098@mithlond.arda.local> <alpine.DEB.1.00.0804221354180.4460@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Teemu Likonen <tlikonen@iki.fi>, Mike Galbraith <efault@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 22 15:02:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoI8W-0004az-NO
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 15:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758935AbYDVNB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 09:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758911AbYDVNBZ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 09:01:25 -0400
Received: from peff.net ([208.65.91.99]:2210 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758829AbYDVNBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 09:01:25 -0400
Received: (qmail 19954 invoked by uid 111); 22 Apr 2008 13:01:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 22 Apr 2008 09:01:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Apr 2008 09:01:23 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0804221354180.4460@eeepc-johanness>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80112>

On Tue, Apr 22, 2008 at 01:56:36PM +0100, Johannes Schindelin wrote:

> With the --mirror mode, you can no longer discern clearly between local 
> and remote branches.  This is basically what we had in the beginning, 
> before the "separate remotes layout".
> 
> So your point is not valid, an update will interfer with "local" branches.
> 
> And when those branches are deleted via "git fetch", you will not be able 
> to reconstruct them easily, because the reflogs are deleted, too.

I think I'm a little confused. Is it possible to delete branches on a
fetch? It looks like remote's --mirror option just specifies "don't use
separate remote layout". So again, there is no way to blow away reflogs
through a fetch.

OTOH, if you are using non-separate-remote layout, I think it makes
sense to _not_ have the "+". OTOOH, when you call the option --mirror,
it makes me think of "push --mirror" which implies "+".

-Peff

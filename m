From: Jeff King <peff@peff.net>
Subject: Re: git remote update -> rejected
Date: Tue, 22 Apr 2008 09:09:18 -0400
Message-ID: <20080422130918.GB27878@sigill.intra.peff.net>
References: <1208857733.4695.37.camel@marge.simson.net> <20080422103458.GA14751@sigio.intra.peff.net> <1208861703.18689.2.camel@marge.simson.net> <20080422111113.GB11238@sigill.intra.peff.net> <alpine.DEB.1.00.0804221250010.4460@eeepc-johanness> <20080422125618.GA27577@sigill.intra.peff.net> <alpine.DEB.1.00.0804221357420.4460@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Galbraith <efault@gmx.de>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 22 15:14:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoIJI-0000DS-SY
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 15:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760212AbYDVNJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 09:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754345AbYDVNJV
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 09:09:21 -0400
Received: from peff.net ([208.65.91.99]:2635 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754659AbYDVNJU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 09:09:20 -0400
Received: (qmail 20557 invoked by uid 111); 22 Apr 2008 13:09:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 22 Apr 2008 09:09:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Apr 2008 09:09:18 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0804221357420.4460@eeepc-johanness>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80115>

On Tue, Apr 22, 2008 at 02:03:43PM +0100, Johannes Schindelin wrote:

> Oh, that's right: only "git remote prune" will delete stale refs only.
> 
> But my other point about possibly interfering with local branches still 
> holds true.

In that case, I think that the '+' should come only without --mirror,
and my complaint is then that "--mirror" is a horrible name for that
option. Though when I saw it, I really expected it to do something about
the _push_ line, since that is the only other place we have a --mirror
option. It would make sense to me for it to set up remote.$x.mirror
(which is newly added in next). But then, git-remote doesn't seem to be
geared towards pushing at all.

-Peff

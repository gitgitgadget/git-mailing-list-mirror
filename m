From: Jeff King <peff@peff.net>
Subject: Re: theirs/ours was Re: [PATCH 6/6] Add a new test for using a
	custom merge strategy
Date: Tue, 29 Jul 2008 00:31:17 -0400
Message-ID: <20080729043117.GB26997@sigill.intra.peff.net>
References: <bd6139dc0807280754x76b6ffedg6bf756dfce23f1e3@mail.gmail.com> <20080728185604.GA26322@sigill.intra.peff.net> <alpine.DEB.1.00.0807282008470.8986@racer> <20080728192651.GA26677@sigill.intra.peff.net> <alpine.DEB.1.00.0807290123300.2725@eeepc-johanness> <bd6139dc0807281709u43218e97p8ba239f3e520e10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailinglist <git@vger.kernel.org>,
	Miklos Vajna <vmiklos@frugalware.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Tue Jul 29 06:32:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNgsm-00036g-JT
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 06:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbYG2EbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 00:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbYG2EbU
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 00:31:20 -0400
Received: from peff.net ([208.65.91.99]:1384 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751238AbYG2EbT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 00:31:19 -0400
Received: (qmail 5646 invoked by uid 111); 29 Jul 2008 04:31:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 29 Jul 2008 00:31:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jul 2008 00:31:17 -0400
Content-Disposition: inline
In-Reply-To: <bd6139dc0807281709u43218e97p8ba239f3e520e10@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90561>

On Tue, Jul 29, 2008 at 02:09:18AM +0200, Sverre Rabbelier wrote:

> > If the result should become the state of 'x', too, I would then just
> > 'git push origin y:x'.
> 
> But this means that everybody doing a 'git pull' on that repo will get
> complaints when pulling, right? Should they just send out a message to
> all their users that they'll need to rebase all their changes now?
> (Not being sarcastic, am trying to work out what the recommended
> workflow is here.)

I think you are missing the fact that he is doing this push _after_
having merged the history into master via "-s ours". So it is a
fast-forward to push at that point.

-Peff

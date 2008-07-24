From: Jeff King <peff@peff.net>
Subject: Re: sparse fetch, was Re: [PATCH 08/12] git-clone: support --path
	to do sparse clone
Date: Thu, 24 Jul 2008 14:28:13 -0400
Message-ID: <20080724182813.GA21186@sigill.intra.peff.net>
References: <20080723145718.GA29134@laptop> <20080724171952.GB21043@sigill.intra.peff.net> <alpine.DEB.1.00.0807241837441.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 24 20:29:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM5ZD-00056n-Dg
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 20:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbYGXS2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 14:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbYGXS2P
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 14:28:15 -0400
Received: from peff.net ([208.65.91.99]:1692 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751329AbYGXS2P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 14:28:15 -0400
Received: (qmail 26853 invoked by uid 111); 24 Jul 2008 18:28:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 24 Jul 2008 14:28:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jul 2008 14:28:13 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807241837441.8986@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89931>

On Thu, Jul 24, 2008 at 06:41:03PM +0100, Johannes Schindelin wrote:

> > As a user, I would expect "sparse clone" to also be sparse on the 
> > fetching. That is, to not even bother fetching tree objects that we are 
> > not going to check out. But that is a whole other can of worms from 
> > local sparseness, so I think it is worth saving for a different series.
> 
> I think this is not even worth of a series.  Sure, it would have benefits 
> for those who want sparse checkouts.  But it comes for a high price on 
> everyone else:

I agree there are a lot of issues. I am just thinking of the person who
said they had a >100G repository. But I am also not volunteering to do
it, so I will let somebody who really cares about it try to defend the
idea.

-Peff

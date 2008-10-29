From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Implement git-staged, an alias for 'git diff --cached'.
Date: Tue, 28 Oct 2008 20:58:14 -0400
Message-ID: <20081029005814.GA8686@sigill.intra.peff.net>
References: <20081029003931.GA7291@sigill.intra.peff.net> <1225241048-99267-1-git-send-email-dsymonds@gmail.com> <alpine.DEB.1.00.0810290201400.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 29 01:59:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuzPO-00052G-Fk
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 01:59:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431AbYJ2A6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 20:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753403AbYJ2A6X
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 20:58:23 -0400
Received: from peff.net ([208.65.91.99]:3989 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753404AbYJ2A6W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 20:58:22 -0400
Received: (qmail 24904 invoked by uid 111); 29 Oct 2008 00:58:22 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.19)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 28 Oct 2008 20:58:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Oct 2008 20:58:14 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0810290201400.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99341>

On Wed, Oct 29, 2008 at 02:02:29AM +0100, Johannes Schindelin wrote:

> > +git-staged
> 
> Would it not be better to teach "git show --staged" to do that, and to add 
> a command pair "git stage <file>" and "git unstage <file>" to do the 
> obvious?

Yes, I think half of the discussion went on IRC. But I don't think "git
staged" is a good idea. I think a "--staged" alias for "--cached" in
"git diff" makes a lot more sense.

-Peff

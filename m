From: Jeff King <peff@peff.net>
Subject: Re: Git Notes - Track rebase/etc + reverse-lookup for bugs ideas
Date: Mon, 10 Nov 2008 14:51:20 -0500
Message-ID: <20081110195120.GA3688@sigill.intra.peff.net>
References: <6A0F154C-B9FE-4770-BF70-82A5BEBF907C@gmail.com> <20081110191134.GA3329@sigill.intra.peff.net> <alpine.DEB.1.00.0811102049460.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Harning <harningt@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 10 20:52:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzcoP-0006o6-26
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 20:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbYKJTvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 14:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbYKJTvW
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 14:51:22 -0500
Received: from peff.net ([208.65.91.99]:4739 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401AbYKJTvW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 14:51:22 -0500
Received: (qmail 28788 invoked by uid 111); 10 Nov 2008 19:51:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 10 Nov 2008 14:51:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Nov 2008 14:51:20 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0811102049460.30769@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100554>

On Mon, Nov 10, 2008 at 08:51:50PM +0100, Johannes Schindelin wrote:

> > Not that I know of, but then again, I'm not sure exactly what you mean 
> > by "track rebases".
> 
> I guess he means that you could have something like this
> 
> 	rebased from <SHA-1>
> 
> in the notes for any given commit, so that _if_ you have the commit, e.g. 
> gitk could show that connection (maybe dashed in the graphical history 
> display, and as a "Rebased from:" link).

You don't really need "notes" for that, though, since you can put that
information into the commit message (or headers) if you choose. I guess
it has the advantage of not polluting the commit for others.

-Peff

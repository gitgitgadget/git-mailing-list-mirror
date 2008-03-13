From: Jeff King <peff@peff.net>
Subject: Re: [Q] Encrypted GIT?
Date: Thu, 13 Mar 2008 12:01:54 -0400
Message-ID: <20080313160154.GC30847@coredump.intra.peff.net>
References: <c6c947f60803130148w7981a3f0r718c0801343c7b78@mail.gmail.com> <20080313114738.GC2414@genesis.frugalware.org> <alpine.LSU.1.00.0803131254580.1656@racer.site> <20080313121644.GD2414@genesis.frugalware.org> <20080313125853.GA12927@mit.edu> <20080313155322.GA30847@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 13 17:03:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZptg-0001FG-Ex
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 17:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725AbYCMQB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 12:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752203AbYCMQB5
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 12:01:57 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4335 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752000AbYCMQB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 12:01:57 -0400
Received: (qmail 10085 invoked by uid 111); 13 Mar 2008 16:01:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 13 Mar 2008 12:01:55 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Mar 2008 12:01:54 -0400
Content-Disposition: inline
In-Reply-To: <20080313155322.GA30847@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77099>

On Thu, Mar 13, 2008 at 11:53:22AM -0400, Jeff King wrote:

> You could probably do something totally external to git using bundles as
> the primitive. Store an encrypted index on the remote that says "here
> are the packs I have, and the objects they contain." Whenever you push,
> pull the index (which is of course more network-intensive than regular
> git protocol, but not as bad as pulling all the data) and calculate a
> thin-pack bundle yourself. Encrypt the bundle and store remotely.

Oh, and a scheme like this generalizes well from "there is one key" to
"N asymmetric keyholders".

> I don't know if a formal thread analysis is necessary. I think most

That should of course be "threa_t_ analysis". I of course want to
formally analyze this thread. ;)

-Peff

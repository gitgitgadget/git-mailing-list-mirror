From: Jeff King <peff@peff.net>
Subject: Re: [PATCH ugit] Allow user to choose history browser tool
Date: Thu, 3 Jan 2008 17:39:21 -0500
Message-ID: <20080103223920.GA17530@coredump.intra.peff.net>
References: <e5bfff550801030408w1512e458x136f6be0371c13c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: davvid@gmail.com, Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 23:39:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAYj9-0003Tp-Ew
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 23:39:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050AbYACWjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2008 17:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753126AbYACWjY
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 17:39:24 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4374 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752877AbYACWjX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 17:39:23 -0500
Received: (qmail 12309 invoked by uid 111); 3 Jan 2008 22:39:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 03 Jan 2008 17:39:22 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jan 2008 17:39:21 -0500
Content-Disposition: inline
In-Reply-To: <e5bfff550801030408w1512e458x136f6be0371c13c2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69542>

On Thu, Jan 03, 2008 at 01:08:17PM +0100, Marco Costalba wrote:

>  Instead of hard linking gitk let the user set
>  the preferred history visualization tool in settings dialog.

This is the exact situation that the 'git view' builtin alias was
designed for. If every porcelain which spawned a viewer used 'git view',
then the user would only need to configure one place (but note that 'git
view' has never even made it out of next, so I am not recommending it
instead of your patch, but just making a note).

-Peff

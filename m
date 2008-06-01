From: Jeff King <peff@peff.net>
Subject: Re: unable to push
Date: Sun, 1 Jun 2008 14:25:30 -0400
Message-ID: <20080601182530.GA783@sigill.intra.peff.net>
References: <alpine.DEB.1.10.0805310759540.15294@asgard.lang.hm> <20080531155036.GA27397@sigill.intra.peff.net> <alpine.DEB.1.10.0805310855000.15294@asgard.lang.hm> <20080601182205.GA742@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sun Jun 01 20:26:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2sGM-0004Qx-Ce
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 20:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbYFASZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 14:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbYFASZd
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 14:25:33 -0400
Received: from peff.net ([208.65.91.99]:2988 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751624AbYFASZd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 14:25:33 -0400
Received: (qmail 32713 invoked by uid 111); 1 Jun 2008 18:25:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 01 Jun 2008 14:25:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 01 Jun 2008 14:25:30 -0400
Content-Disposition: inline
In-Reply-To: <20080601182205.GA742@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83458>

On Sun, Jun 01, 2008 at 02:22:05PM -0400, Jeff King wrote:

> I'm not understanding that, either. You not only created localmaster,
> but you deleted master. Did you maybe do a "git branch -m"?

Having just read Adam's message, I see that I read your "ls-remote"s
backwards.

So it's not that you created localmaster and deleted master, but rather
that somehow the master on your "public" repo got deleted (or never
existed in the first place?).

-Peff

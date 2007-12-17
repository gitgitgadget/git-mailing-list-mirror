From: Jeff King <peff@peff.net>
Subject: Re: Solaris install error: didn't get git-init link was [Fwd: Re:
	The Reposithon!  Take 2]
Date: Mon, 17 Dec 2007 11:07:17 -0500
Message-ID: <20071217160717.GA28303@coredump.intra.peff.net>
References: <47668ABB.9000504@vilain.net> <20071217151829.GP32704@skl-net.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, Git Mailing List <git@vger.kernel.org>
To: Andre Noll <maan@systemlinux.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 17:12:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4IVM-00013Y-Hq
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 17:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759854AbXLQQHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 11:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbXLQQHV
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 11:07:21 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4105 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758987AbXLQQHU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 11:07:20 -0500
Received: (qmail 9872 invoked by uid 111); 17 Dec 2007 16:07:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 17 Dec 2007 11:07:18 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Dec 2007 11:07:17 -0500
Content-Disposition: inline
In-Reply-To: <20071217151829.GP32704@skl-net.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68574>

On Mon, Dec 17, 2007 at 04:18:29PM +0100, Andre Noll wrote:

> > Refer attached ... 1.5.3.6 install, didn't get git-init link to git.
> > Ring any bells?
> 
> /usr/sbin/install does not accept all options that git's "make install"
> is using?

/usr/sbin/install doesn't seem to work at all on Solaris. Using
/usr/ucb/install does correctly create the hardlinks.

-Peff

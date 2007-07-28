From: Jeff King <peff@peff.net>
Subject: Re: suggestion for git rebase -i
Date: Sat, 28 Jul 2007 04:45:51 -0400
Message-ID: <20070728084550.GA13993@sigill.intra.peff.net>
References: <m26445t98z.fsf@ziti.fhcrc.org> <Pine.LNX.4.64.0707280941380.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Seth Falcon <sfalcon@fhcrc.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 28 10:45:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEhvw-0001um-7n
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 10:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934657AbXG1Ipx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 04:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934335AbXG1Ipx
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 04:45:53 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3618 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932331AbXG1Ipw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 04:45:52 -0400
Received: (qmail 12961 invoked from network); 28 Jul 2007 08:45:53 -0000
Received: from unknown (HELO sigill.intra.peff.net) (10.0.0.7)
  by peff.net with (DHE-RSA-AES256-SHA encrypted) SMTP; 28 Jul 2007 08:45:53 -0000
Received: (qmail 14005 invoked by uid 1000); 28 Jul 2007 08:45:51 -0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707280941380.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54009>

On Sat, Jul 28, 2007 at 09:43:15AM +0100, Johannes Schindelin wrote:

> > a file in a pre-existing editor session.  I realize this is a small
> > nit, but how about renaming the file to "git-rebase-todo"?
> 
> Why?  This is an implementation detail, and should not concern the user.

Because if you want to setup macros or syntax highlighting specific to
editing git-rebase tempfiles, then you have to figure out somehow that
you are editing one. Using a more informative name for the tempfile
means that you can guess based on the filename.

-Peff

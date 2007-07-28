From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Don't rely on unspecified behavior
Date: Sat, 28 Jul 2007 21:17:22 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707282116390.14781@racer.site>
References: <20070728173948.GD23337@cip.informatik.uni-erlangen.de>
 <11856471952272-git-send-email-tschwinge@gnu.org> <Pine.LNX.4.64.0707282028130.14781@racer.site>
 <20070728194306.GA32203@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Thomas Schwinge <tschwinge@gnu.org>
X-From: git-owner@vger.kernel.org Sat Jul 28 22:17:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEsjN-0003a8-AP
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 22:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755168AbXG1URj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 16:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755115AbXG1URi
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 16:17:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:46759 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755138AbXG1URi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 16:17:38 -0400
Received: (qmail invoked by alias); 28 Jul 2007 20:17:36 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 28 Jul 2007 22:17:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/1kadWv9/17ZULWFL2loyWmjhVLTRkbA0Rn9iWbh
	qlOPnLLsfqPhbF
X-X-Sender: gene099@racer.site
In-Reply-To: <20070728194306.GA32203@fencepost.gnu.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54060>

Hi,

On Sat, 28 Jul 2007, Thomas Schwinge wrote:

> On Sat, Jul 28, 2007 at 08:30:07PM +0100, Johannes Schindelin wrote:
> > On Sat, 28 Jul 2007, Thomas Schwinge wrote:
> > > Calling access(p, m) with p == NULL is not specified, so don't do that.  On
> > > GNU/Hurd systems doing so will result in a SIGSEGV.
> > > 
> > > Signed-off-by: Thomas Schwinge <tschwinge@gnu.org>
> > > ---
> > 
> > Isn't this the same patch as you sent before?
> 
> As I wrote in <20070728182542.GA22651@fencepost.gnu.org>: ``I noticed
> that the patch I sent was prepared for an old version of the file.  I'll
> send an updated patch that applies to the current revision.''

Ah.

> > > +		if (excludes_file != NULL && !access(excludes_file, R_OK))
> > 
> > We usually omit the "!= NULL"; see the other source code in git.git.
> 
> Okay, so I should sent a thusly modified version to get it applied?

I don't think that is necessary; a small change like this is usually fixed 
by Junio with --amend.

Ciao,
Dscho

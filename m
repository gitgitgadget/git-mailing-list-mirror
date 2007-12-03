From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow ':/<oneline-prefix>' syntax to work with
 save_commit_buffer == 0
Date: Mon, 3 Dec 2007 22:52:21 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712032249260.27959@racer.site>
References: <20071203043258.GA16658@coredump.intra.peff.net>
 <Pine.LNX.4.64.0712031052410.27959@racer.site> <20071203173022.GA19219@coredump.intra.peff.net>
 <Pine.LNX.4.64.0712031841520.27959@racer.site> <7vhcizh38y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 23:53:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzKA3-0002AZ-3D
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 23:53:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbXLCWws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 17:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbXLCWws
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 17:52:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:46538 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751462AbXLCWwr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 17:52:47 -0500
Received: (qmail invoked by alias); 03 Dec 2007 22:52:45 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp011) with SMTP; 03 Dec 2007 23:52:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX198jlV9gKF8bhosbly1glcdDuAstGDaFSm9iRxt69
	zPfq3YKsoAeGCR
X-X-Sender: gene099@racer.site
In-Reply-To: <7vhcizh38y.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66970>

Hi,

On Mon, 3 Dec 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >
> > 	On Mon, 3 Dec 2007, Jeff King wrote:
> >
> > 	> On Mon, Dec 03, 2007 at 10:55:15AM +0000, Johannes Schindelin wrote:
> > 	> 
> > 	> > But then, my patch also works when save_commit_buffer == 0.  
> > 	> > But I can refactor this into its own patch, since it really is 
> > 	> > a separate issue.
> > 	> 
> > 	> Agreed.
> >
> > 	Here we go.
> 
> The log message is a bit lacking.  I would have expected "git-show
> command can take ':/prefix' as an argument to name a commit whose
> subject begins with the prefix, but git-foobar command didn't and
> instead errored out.  This fixes it so that ':/prefix' syntax can be
> used for any command that wants to take a commit object name".

Sorry.  Can I ask you to amend the commit message with this?

-- snip --
Earlier, ':/<oneline-prefix>' would not work (i.e. die) with commands that 
set save_commit_buffer = 0, such as blame, describe, pack-objects, reflog 
and bundle.

Fix this.
-- snap --

Thanks,
Dscho

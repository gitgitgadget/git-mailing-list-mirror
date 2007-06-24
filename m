From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Teach rebase an interactive mode
Date: Sun, 24 Jun 2007 11:12:33 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706241109410.4059@racer.site>
References: <Pine.LNX.4.64.0706240001150.4059@racer.site>
 <31A266F6-775E-41AE-B757-BF0DDAC6CAA5@silverinsanity.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 12:12:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2P5D-0002PO-Dw
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 12:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523AbXFXKMi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 06:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752643AbXFXKMi
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 06:12:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:53302 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752411AbXFXKMh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 06:12:37 -0400
Received: (qmail invoked by alias); 24 Jun 2007 10:12:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp048) with SMTP; 24 Jun 2007 12:12:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+wSr0wzuKwtvV4qTWG3SCvjNfwPEJoRQx87xZfxp
	HJJKvLdQvAgZuS
X-X-Sender: gene099@racer.site
In-Reply-To: <31A266F6-775E-41AE-B757-BF0DDAC6CAA5@silverinsanity.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50786>

Hi,

On Sat, 23 Jun 2007, Brian Gernhardt wrote:

> On Jun 23, 2007, at 7:01 PM, Johannes Schindelin wrote:
> 
> > With "--interactive", git-rebase now lets you edit the list of patches
> > to be reapplied, so that you can reorder and/or delete patches.
> > 
> > Such a list will typically look like this:
> > 
> > 	pick deadbee The oneline of this commit
> > 	pick fa1afe1 The oneline of the next commit
> > 	...
> > 
> 
> It's not at all obvious from your commit message or the documentation 
> where this list comes from.

Oh, okay. I thought that this being just a mode for git-rebase, it would 
be obvious where that list comes from... Any idea how to state that more 
clearly?

> Is there a way to say "Oops, that's the wrong list.  Don't do 
> anything."?

It is not at all documented, but yes. Just delete the complete list.

> Perhaps starting the list with a header like the following would make it 
> more user-friendly (Obviously requires s/#.*$//):

All lines with "#" are ignored, yes.

> # Rebasing $from..$to onto $commit
> #
> # Commands:
> #  pick = use commit
> #  squash = meld commit into previous
> # <<More useful information here>>

That's a very good idea! (I completely suck at descriptive texts.) Will 
fix.

Ciao,
Dscho

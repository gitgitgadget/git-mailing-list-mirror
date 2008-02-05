From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-rebase.sh: Use POSIX/Susv command substitution
 instead of backticks
Date: Tue, 5 Feb 2008 23:06:48 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802052305080.8543@racer.site>
References: <lk5zxdix.fsf@blue.sea.net> <alpine.LSU.1.00.0802052226340.8543@racer.site> <abmfxbg3.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Wed Feb 06 00:08:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMWtW-00018b-Sz
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 00:08:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754487AbYBEXHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 18:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753546AbYBEXHa
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 18:07:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:35532 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753230AbYBEXH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 18:07:29 -0500
Received: (qmail invoked by alias); 05 Feb 2008 23:07:27 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp051) with SMTP; 06 Feb 2008 00:07:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Y3ddjGqnYMfXtRI/D3v1K/6FdZV8bo5J0Ik5Y9n
	4DmZL4xpCYQr9O
X-X-Sender: gene099@racer.site
In-Reply-To: <abmfxbg3.fsf@blue.sea.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72720>

Hi,

On Wed, 6 Feb 2008, Jari Aalto wrote:

> * Tue 2008-02-05 Johannes Schindelin <Johannes.Schindelin@gmx.de>
> * Message-Id: alpine.LSU.1.00.0802052226340.8543@racer.site
>
> > On Wed, 6 Feb 2008, Jari Aalto wrote:
> >
> >> Use redable $(<command>) syntax instead of backtics in code.  See The 
> >> Open Group Base Specifications Issue 6, IEEE Std 1003.1, 2004 Edition
> >
> > Sorry, I am not quite sure if this patch is worth it: either you want 
> > to clean this up in _all_ of our shell scripts, or you leave it.
> 
> Yes, that's the plan. This is just a start.

Again, you failed to address me.  FYI my email address is 
johannes.schindelin@gmx.de.  Thank you very much.

"This is just a start" is not good enough.  First, you have to defend why 
this is a good change.  It does not really fix anything.

And then you have to do it for all scripts in one go.  Mind you, it is not 
really complicated: just one call to perl.

Hth,
Dscho

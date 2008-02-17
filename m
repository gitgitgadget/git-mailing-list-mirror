From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Issues around C rebase--interactive
Date: Sun, 17 Feb 2008 19:34:28 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802171932470.30505@racer.site>
References: <alpine.LNX.1.00.0802171347060.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Feb 17 20:35:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQpI9-0005rp-Tn
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 20:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbYBQTej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 14:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbYBQTej
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 14:34:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:33006 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751258AbYBQTej (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 14:34:39 -0500
Received: (qmail invoked by alias); 17 Feb 2008 19:34:36 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp058) with SMTP; 17 Feb 2008 20:34:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+jLLwxmymjZA49R+t455aTxpWK8hD5BNS0YUuKoS
	Try1QG6DLMGupU
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802171347060.5816@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74171>

Hi,

On Sun, 17 Feb 2008, Daniel Barkalow wrote:

> There's a lot of stuff stored presently in ways that are convenient for 
> shell scripts and inconvenient for C.

We could have both, actually.  There could be a ".git/state" to tell git 
abort/resume what the current actions are, and in addition the files that 
used to be there, too.

> Is anything else depending on the contents or location of 
> ".git/.dotest-merge"?

This has been discussed recently.  I offered the opinion that some 
people's scripts might rely on the location, but was all but shot down.  I 
guess we'll have to change it to find out.

Ciao,
Dscho

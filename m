From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Any tricks for speeding up cvsps?
Date: Fri, 8 Feb 2008 12:23:27 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802081222400.11591@racer.site>
References: <47AC1FDC.9000502@glidos.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Paul Gardiner <osronline@glidos.net>
X-From: git-owner@vger.kernel.org Fri Feb 08 13:24:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNSHB-0007dl-CZ
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 13:24:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763251AbYBHMXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 07:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763247AbYBHMXW
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 07:23:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:36123 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763251AbYBHMXV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 07:23:21 -0500
Received: (qmail invoked by alias); 08 Feb 2008 12:23:18 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp021) with SMTP; 08 Feb 2008 13:23:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/TJ1w5je3T18DFdeQrGLsmZkEu8ZxNufrdFzQXHC
	WuL1rQyeEFLAwm
X-X-Sender: gene099@racer.site
In-Reply-To: <47AC1FDC.9000502@glidos.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73082>

Hi,

On Fri, 8 Feb 2008, Paul Gardiner wrote:

> I'm trying to convert a huge cvs repository. I've left cvsps running for 
> days. First attempt, stderr filled my disc with warnings about tags that 
> couldn't be associated with any one commit, without producing anything 
> from stdout. I'm now redirecting stderr to /dev/null, but it still just 
> sits there producing nothing.  Is git-cvsimport infeasible for large 
> repositories, or are there tricks I might use?

The obvious thing is to have the CVS repository locally.  And then on a 
ramdisk.

Hth,
Dscho

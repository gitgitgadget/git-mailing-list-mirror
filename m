From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Reduce the number of connects when fetching
Date: Sat, 26 Jan 2008 17:36:22 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801261734360.23907@racer.site>
References: <alpine.LNX.1.00.0801251326260.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Jan 26 18:37:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIoxw-0004zy-Mg
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 18:37:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900AbYAZRgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 12:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752841AbYAZRgj
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 12:36:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:38431 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751233AbYAZRgi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 12:36:38 -0500
Received: (qmail invoked by alias); 26 Jan 2008 17:36:36 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp052) with SMTP; 26 Jan 2008 18:36:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/6NKZg04b68Hjdk4IodjWHyPNHbiguMjXjTxjQ5q
	amVBn6StTRWkjd
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0801251326260.13593@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71783>

Hi,

On Fri, 25 Jan 2008, Daniel Barkalow wrote:

> This shares the connection between getting the remote ref list and 
> getting objects in the first batch. (A second connection is still used 
> to follow tags)

I applied this locally, and now I get a few "fatal: The remote end hung up 
unexpectedly" errors; when I started "git fetch" in a gdb session, it did 
not stop at die_builtin(), which leads me to believe that the error comes 
from upload-pack.

Any ideas?

Ciao,
Dscho

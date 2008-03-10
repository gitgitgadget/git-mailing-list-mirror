From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6] autoconf: Test FREAD_READS_DIRECTORIES
Date: Mon, 10 Mar 2008 16:46:54 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803101645090.3975@racer.site>
References: <200803092144.04440.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT <git@vger.kernel.org>
To: Michal Rokos <michal.rokos@nextsoft.cz>
X-From: git-owner@vger.kernel.org Mon Mar 10 16:48:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYkEE-0003Mm-BZ
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 16:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbYCJPqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 11:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbYCJPqv
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 11:46:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:41778 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750921AbYCJPqu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 11:46:50 -0400
Received: (qmail invoked by alias); 10 Mar 2008 15:46:48 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 10 Mar 2008 16:46:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+xOfhA566xCRWI3H4OuGfcomnte5PWhBkIb2C6aN
	R1tI357f2XX5cm
X-X-Sender: gene099@racer.site
In-Reply-To: <200803092144.04440.michal.rokos@nextsoft.cz>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76738>

Hi,

On Sun, 9 Mar 2008, Michal Rokos wrote:

> Add test for FREAD_READS_DIRECTORIES to detect when fread() reads fopen'ed 
> directory.
> 
> Signed-off-by: Michal Rokos <michal.rokos@nextsoft.cz>
> Tested-by: Mike Ralphson <mike@abacus.co.uk>

Okay, I just forced the stupid "socket in -lc" test to succeed, and now 
your patch does exactly what it is supposed to on MinGW (it says that 
fopen()ed directories cannot be read).

Of course, the building blocks are not in place, so I cannot compile on 
MinGW, but that is another issue.

So, you can readd my Tested-by: ;-)

Thanks,
Dscho

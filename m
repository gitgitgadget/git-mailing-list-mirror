From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Funny: git -p submodule summary
Date: Thu, 8 Jan 2009 16:07:08 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901081601240.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 08 16:08:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKwUI-0008BD-Og
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 16:07:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756202AbZAHPGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 10:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752272AbZAHPGb
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 10:06:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:39427 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751081AbZAHPGa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 10:06:30 -0500
Received: (qmail invoked by alias); 08 Jan 2009 15:06:28 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 08 Jan 2009 16:06:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Tl3ZQ4zdTez9ICztiObPrY7YQmb9180NwM607hI
	xwoGuNxteLlZ0n
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104923>

Hi list,

Just try this with a submodule that has more changes than fit on a screen:

	$ git -p submodule summary

In my tests, it consistently fscks up my console.  I wonder if this is 
related to ea27a18(spawn pager via run_command interface).

*reverts that commit* Yep, that fixes it.

Ciao,
Dscho

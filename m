From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/2] rsync support
Date: Fri, 28 Sep 2007 06:06:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709280602580.28395@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, Daniel Barkalow <barkalow@iabervon.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 07:07:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib84l-0003T7-8M
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 07:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756041AbXI1FHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 01:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754992AbXI1FHh
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 01:07:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:48968 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754826AbXI1FHg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 01:07:36 -0400
Received: (qmail invoked by alias); 28 Sep 2007 05:07:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 28 Sep 2007 07:07:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18xia4zbVsxtRlsXw9v/RGGHXM6hIWaI8ut+0R6S3
	mziWkWxKru91DF
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59362>

Hi,

I worked too long on this... So here it is, a 2-patch series to readd the 
rsync support.

One thing I did not do: fetch alternates.  My rationale is this: just as 
with HTTP, the rsync protocol does allow for having a different root than 
the file system root.  So, just as with HTTP, the alternates are likely to 
break.

But hey, if somebody feels like it, there is a NEEDSWORK pointer from 
which to start.

Ciao,
Dscho

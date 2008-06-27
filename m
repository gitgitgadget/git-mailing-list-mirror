From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: octopus limit
Date: Fri, 27 Jun 2008 13:00:56 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806271259440.9925@racer>
References: <alpine.LFD.1.10.0806262243130.2988@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Len Brown <lenb@kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 27 14:04:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCCgT-00086l-F5
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 14:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759853AbYF0MC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 08:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759835AbYF0MC5
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 08:02:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:43588 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758943AbYF0MC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 08:02:56 -0400
Received: (qmail invoked by alias); 27 Jun 2008 12:02:54 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp040) with SMTP; 27 Jun 2008 14:02:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19cfgRoJeZc1kRApuf0U90Py3QYNPqehIWCuyQ8BI
	qmEDNgvBvdFaJJ
X-X-Sender: gene099@racer
In-Reply-To: <alpine.LFD.1.10.0806262243130.2988@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86541>

Hi,

On Thu, 26 Jun 2008, Len Brown wrote:

> it would be nice if a merge of more than 16 branches failed right at the 
> start, rather than chunking along doing merges and then giving up, 
> leaving my repo in an intermediate state.

FWIW I think the rewrite of git-merge as a builtin, which is currently in 
the works, lifts the limit.  However, this is only true if you do not use 
a custom script which calls commit-tree.

Ciao,
Dscho

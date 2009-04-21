From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH v2] graph API: Use horizontal lines for more compact
 graphs
Date: Tue, 21 Apr 2009 15:17:59 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904211517201.6559@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0904211010410.10279@pacific.mpi-cbg.de> <20090421124701.GA25982@linux.vnet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Allan Caffee <allan.caffee@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 15:19:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwFsy-0007HZ-9D
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 15:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269AbZDUNSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 09:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbZDUNSD
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 09:18:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:42763 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752807AbZDUNSB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 09:18:01 -0400
Received: (qmail invoked by alias); 21 Apr 2009 13:17:59 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp026) with SMTP; 21 Apr 2009 15:17:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+UYzdnUl6Ud7JkChbcKJEsOK6X6iFeC7b0xiHxDR
	tsAxUZBU0U/bIG
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090421124701.GA25982@linux.vnet>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117129>

Hi,

> Everything else look good?

No objection from my side.

> Actually now that I look at it, it might be a good idea to put an assert
> statement in that for loop like `assert(graph->new_mapping[j] < 0)' to
> make sure we don't clobber any existing lines.  But that seems like
> overkill since we're already assured to be the first collapsing edge at
> that point, which would imply that all previous odd indeces are empty.
> WDYT?

Yep, sounds like overkill to me, too.

Thanks!
Dscho

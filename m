From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: receive.denyCurrentBranch
Date: Mon, 9 Feb 2009 00:41:42 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902090038550.10279@pacific.mpi-cbg.de>
References: <20090208042910.19079.qmail@science.horizon.com>  <alpine.DEB.1.00.0902081128420.10279@pacific.mpi-cbg.de>  <76718490902080950r798ca02es4e560da35e499046@mail.gmail.com>  <alpine.DEB.1.00.0902082149380.10279@pacific.mpi-cbg.de>
 <76718490902081451xd953e84y33de64cc82c1da42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: George Spelvin <linux@horizon.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 00:42:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWJID-0008BH-S8
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 00:42:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbZBHXlD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 18:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbZBHXlB
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 18:41:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:44421 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751319AbZBHXlB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 18:41:01 -0500
Received: (qmail invoked by alias); 08 Feb 2009 23:40:59 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp063) with SMTP; 09 Feb 2009 00:40:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+9Lk4fJq+9+ucaalbjZWAqGtAYVi3PG9ZOylVjfm
	eVBe9ShQ/tBepk
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <76718490902081451xd953e84y33de64cc82c1da42@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109026>

Hi,

On Sun, 8 Feb 2009, Jay Soffian wrote:

> If you had paid attention, you would have noticed that Mercurial did not 
> attempt to merge. Rather, it created a new branch head in the remote 
> repository.

So this is the "detached HEAD" idea.  Which contradicts the law of the 
least surprise.

> Clearly users are confused about pushing into a checked-out branch. 
> Maybe making that impossible by default will be enough.

It should be clear that the equivalent of a central repository is a bare 
repository.  And hopefully Junio's strategy will make that clearer, so I 
think this is the superior approach.

Ciao,
Dscho

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [JGIT PATCH] Create a debugging tool "jgit
 rebuild-commitgraph"
Date: Fri, 13 Mar 2009 15:49:42 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903131549200.6288@intel-tinevez-2-302>
References: <1236954901-30990-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 13 15:51:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li8jD-000384-SK
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 15:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755494AbZCMOtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 10:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755492AbZCMOtr
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 10:49:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:34776 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755096AbZCMOtq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 10:49:46 -0400
Received: (qmail invoked by alias); 13 Mar 2009 14:49:43 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp071) with SMTP; 13 Mar 2009 15:49:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/doyZrUkXdH+QCpyoVRSz0ZmWU7WV5yCGRqsTzML
	a1sIjVjruHk9qe
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1236954901-30990-1-git-send-email-spearce@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113193>

Hi,

On Fri, 13 Mar 2009, Shawn O. Pearce wrote:

> This is a command line tool which can be used to import only
> the commit graph of another Git repository, to help debug a
> topology related bug, without actually needing a clone of the
> problematic repository.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
> 
>  I used this yesterday to obtain a DAG from someone's private
>  repository and recreate the same structure on my own system,
>  to debug why RevWalk was busted in their case.

Heh:

http://repo.or.cz/w/git/dscho.git?a=blob;f=my-fake-history.sh;h=e108ce99a5ebd75230c3cfc56b88d9769fec8bc1;hb=master

Ciao,
Dscho

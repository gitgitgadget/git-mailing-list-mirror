From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-gui: make "Git GUI Here" Explorer extension more
 robust
Date: Mon, 30 Mar 2009 02:43:35 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0903300243050.6454@intel-tinevez-2-302>
References: <200903300030.03733.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 30 02:45:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo5ck-0000AI-Jk
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 02:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755039AbZC3Ank (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 20:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754842AbZC3Ank
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 20:43:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:40055 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754749AbZC3Anj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 20:43:39 -0400
Received: (qmail invoked by alias); 30 Mar 2009 00:43:36 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp009) with SMTP; 30 Mar 2009 02:43:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/u1XYI96LuQXIvzVBdk8MYHLTkoPDaf/kDAqOiFH
	inkm1GvVetOMWQ
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <200903300030.03733.markus.heidelberg@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115051>

Hi,

On Mon, 30 Mar 2009, Markus Heidelberg wrote:

> Starting git-gui via Windows Explorer shell extension caused problems 
> when not started from the project directory, but from a directory within 
> the project: starting the Explorer from the git-gui menu "Explore 
> Working Copy" didn't work then.
> 
> Starting git-gui via Explorer shell extension from the .git directory 
> didn't work at all.
> 
> To make these things possible, "cd .." until we see .git/

How does this interact with GIT_WORK_TREE?  And with bare repositories?

Ciao,
Dscho

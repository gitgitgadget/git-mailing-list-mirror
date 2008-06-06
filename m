From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git mv + git pull issue
Date: Fri, 6 Jun 2008 16:40:28 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806061639390.1783@racer>
References: <4848EDDF.7090906@melosgmbh.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Christoph Duelli <duelli@melosgmbh.de>
X-From: git-owner@vger.kernel.org Fri Jun 06 17:43:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4e5e-0006BM-14
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 17:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952AbYFFPmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 11:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752741AbYFFPl7
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 11:41:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:47591 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751954AbYFFPl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 11:41:59 -0400
Received: (qmail invoked by alias); 06 Jun 2008 15:41:56 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp023) with SMTP; 06 Jun 2008 17:41:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX189U7oHc0Q9853cGEP/4vXgOaVhKhUfV8Orpi688O
	RgmEj0Unzg+g6H
X-X-Sender: gene099@racer
In-Reply-To: <4848EDDF.7090906@melosgmbh.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84081>

Hi,

On Fri, 6 Jun 2008, Christoph Duelli wrote:

> cd ../gitmv
> git mv afile newname
> # do not commit
> # now: afile is not in the directory anymore
> # oh, I need those changes my colleague made...
> git pull ../gitmv-clone/
> # now: both(!) afile and newname are in the directory

What is so surprising there?  We _always_ recommend to commit before 
pulling.

Ciao,
Dscho

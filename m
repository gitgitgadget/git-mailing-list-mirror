From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Possible eGit bug...
Date: Tue, 9 Jun 2009 13:42:18 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906091341480.5580@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0906091337390.5580@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 13:42:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDzim-0000tl-9N
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 13:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757789AbZFILmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 07:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756530AbZFILmS
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 07:42:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:33827 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755485AbZFILmS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 07:42:18 -0400
Received: (qmail invoked by alias); 09 Jun 2009 11:42:19 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp001) with SMTP; 09 Jun 2009 13:42:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX183Pjd1drs3Bsf+NCgG/q2Y5nD8X0sbI0X2+GKLl5
	c/4FSPfe7xj0yc
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.DEB.1.00.0906091337390.5580@intel-tinevez-2-302>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121169>

Hi,

On Tue, 9 Jun 2009, Johannes Schindelin wrote:

> one of my users managed to create 4b825dc trees.  In case you do not know 
> what that is: it is a completely empty tree:
> 
> 	$ git hash-object -t tree --stdin < /dev/null
> 
> The way he managed to create those trees was by using "git rm --cached" to 
> remove all tracked files from a subdirectory and then committing using 
> eGit.

Possibly valuable piece of information: Git is at version 1.5.4.3 there.

Ciao,
Dscho

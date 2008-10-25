From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Problem with git filter-branch
Date: Sat, 25 Oct 2008 22:36:26 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810252235040.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <4902E7D8.6050401@obry.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git list <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Sat Oct 25 22:30:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ktpmf-0003XY-W4
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 22:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbYJYU3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 16:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbYJYU3U
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 16:29:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:46023 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751037AbYJYU3U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 16:29:20 -0400
Received: (qmail invoked by alias); 25 Oct 2008 20:29:17 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp026) with SMTP; 25 Oct 2008 22:29:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Xe6ZG4BdXo64DHOxO0h8MmXMQ8NjYPPvqWbiLLh
	TbKSaZPekeU3lf
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <4902E7D8.6050401@obry.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99125>

Hi,

On Sat, 25 Oct 2008, Pascal Obry wrote:

> Anyway, I used to run the following command:
> 
> $ git filter-branch --tag-name-filter cat --parent-filter "sed -e
> 's/^$/-p c96d4da294667de1800687d25340551683153002/'" svn-release_2_6
> 
> without problem, I now get this:
> 
> Namespace refs/original/ not empty
> rm: cannot remove directory
> `/home/obry/dev/repositories/git/proj/.git-rewrite': Directory not empty

It is a (maybe ill-conceived) feature.  When branches are rewritten, their 
original versions are stored in the refs/original/ namespace.  You can 
force overwriting with "-f".

I wonder if people would like to have this feature removed; reflogs should 
be enough.

Thoughts?

Ciao,
Dscho

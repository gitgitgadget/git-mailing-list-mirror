From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Not pushing all branches?
Date: Fri, 13 Mar 2009 11:49:08 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903131148250.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.2.00.0903130846410.17450@perkele.intern.softwolves.pp.se> <7bfdc29a0903130112w17d40473s14a895d518dbf8ae@mail.gmail.com> <alpine.DEB.2.00.0903131043510.17450@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Imran M Yousuf <imyousuf@gmail.com>, git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Mar 13 11:49:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li4wq-0007Tk-3i
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 11:49:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754959AbZCMKr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 06:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754384AbZCMKr1
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 06:47:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:45124 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754162AbZCMKr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 06:47:26 -0400
Received: (qmail invoked by alias); 13 Mar 2009 10:47:23 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp036) with SMTP; 13 Mar 2009 11:47:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19jOjk4Fk1jOmwUUXSaiUgtAqCVNSQJCr9GbQHqAh
	u5TSGGJqbogGk2
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.2.00.0903131043510.17450@perkele.intern.softwolves.pp.se>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113167>

Hi,

On Fri, 13 Mar 2009, Peter Krefting wrote:

> Imran M Yousuf:
> 
> > Just try -
> > git push remote branch :)
> 
> That is what I do. Unfortunately, the times I forged to name the branch, 
> it pushes my master branch, which is different from the remote's, and I 
> have to go to the other repository and reset it manually...

You can set

$ git config remote.<remote>.push invalid-branch-name

so that

$ git push <remote>

will give you an error.

Ciao,
Dscho

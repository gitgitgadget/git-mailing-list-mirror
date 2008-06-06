From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Q] Changing the current branch (HEAD) in a bare repository -
 how?
Date: Fri, 6 Jun 2008 16:47:04 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806061646280.1783@racer>
References: <a537dd660806060843p4e92932x4e0f5464c5fd1da1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Brian Foster <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 17:49:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4eCL-0000Le-EF
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 17:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761468AbYFFPsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 11:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761443AbYFFPs3
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 11:48:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:49264 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759768AbYFFPs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 11:48:28 -0400
Received: (qmail invoked by alias); 06 Jun 2008 15:48:26 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp067) with SMTP; 06 Jun 2008 17:48:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/KLnlJMcDKspE8Esm8P6pwjebDTesI6mXgI/ZjVj
	KOWc8TpxK3eEcn
X-X-Sender: gene099@racer
In-Reply-To: <a537dd660806060843p4e92932x4e0f5464c5fd1da1@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84084>

Hi,

On Fri, 6 Jun 2008, Brian Foster wrote:

>  Using git 1.5.2.5 (Kubuntu 7.10) and a bare repository,
>  I started with (the commands and output below are typed
>  in by hand, mostly from memory):
> 
>     $ git branch -a
>     * master
>       foo
>     $
> 
>  and then changed the branch names:
> 
>     $ git branch -m master old-master
>     $ git branch -m foo master
> 
>  and got this:
> 
>     $ git branch -a
>       master
>     * old-master
>     $
> 
>  Now, how do I change the current branch to the (new)
>  `master'?

vi HEAD

Ciao,
Dscho

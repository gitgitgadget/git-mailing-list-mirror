From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Rebasing local patches
Date: Wed, 18 Mar 2009 16:48:15 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903181647540.10279@pacific.mpi-cbg.de>
References: <49B237E2.3080606@morey-chaisemartin.com> <alpine.DEB.1.00.0903071229220.10279@pacific.mpi-cbg.de> <49BA0DBB.7000700@morey-chaisemartin.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Nicolas Morey-Chaisemartin <devel@morey-chaisemartin.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 16:48:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljxzw-0001VZ-AK
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 16:48:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423AbZCRPqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 11:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbZCRPqX
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 11:46:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:47948 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751172AbZCRPqX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 11:46:23 -0400
Received: (qmail invoked by alias); 18 Mar 2009 15:46:20 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 18 Mar 2009 16:46:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/BqYhRm3DB+RYXEnugFIIsakT5liomwhsPOY8Beo
	HXSaObCycto/n6
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <49BA0DBB.7000700@morey-chaisemartin.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113621>

Hi,

On Fri, 13 Mar 2009, Nicolas Morey-Chaisemartin wrote:

> >> I noticed that when the branch was rebased on the centralized and 
> >> repo and origin/our_patches is up-to-date in mine.
> >>
> >> If I checkout another branch and then ckecout our_branches, I got a 
> >> message telling my our_patches and the one from the server have 
> >> diverged (or you are two commits behind...).
> >>
> >> How can you get this info directly without leaving/rejoining your 
> >> branch?
> > 
> > It is also part of "git status"' output.
> 
> Is there some option to just get the status of HEAD against tracked 
> branch and not the index status? I guess I could do an alias but an 
> option would be nicer ;)

Just try "git checkout".

Ciao,
Dscho

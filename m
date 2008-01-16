From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git and binary files
Date: Wed, 16 Jan 2008 13:42:57 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801161341430.17650@racer.site>
References: <alpine.DEB.1.00.0801161222150.3889@bender.nucleusys.com> <ee77f5c20801160254u53e07773qb4125ffd90cf7619@mail.gmail.com> <alpine.DEB.1.00.0801161517260.5260@bender.nucleusys.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Symonds <dsymonds@gmail.com>, git@vger.kernel.org
To: Petko Manolov <petkan@nucleusys.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 14:43:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF8YG-00030f-OS
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 14:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417AbYAPNnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 08:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752348AbYAPNnD
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 08:43:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:36508 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751710AbYAPNnB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 08:43:01 -0500
Received: (qmail invoked by alias); 16 Jan 2008 13:42:59 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp018) with SMTP; 16 Jan 2008 14:42:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+K2fpwXtmK4ZzRbgfKYkoGd7AcpJY2JWv96ethFM
	ylOPo+yVXYAvin
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.DEB.1.00.0801161517260.5260@bender.nucleusys.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70670>

Hi,

On Wed, 16 Jan 2008, Petko Manolov wrote:

> On Wed, 16 Jan 2008, David Symonds wrote:
> 
> > If you don't care about versioning those files, why would you use a 
> > version control system? Just store them somewhere else, and use 
> > symlinks.
> 
> That is certainly a way of doing it.  However, it will be much simpler 
> and fast to be able to "git clone" and then "git pull" every once in a 
> while. The alternative involves "cp -a" or most likely "scp -r" the 
> binaries along with the repository and you can never be sure that both 
> are in sync.

I think that you're missing the point of version control.  It's not only 
about having an up-to-date source tree, but also about being able to go 
back to a certain revision.

What you want is most likely covered by "rsync -au".

Hth,
Dscho

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How it was at GitTogether'08 ?
Date: Mon, 10 Nov 2008 10:58:05 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811101055020.30769@pacific.mpi-cbg.de>
References: <200811080254.53202.jnareb@gmail.com> <200811091636.55343.kai@samba.org> <200811091731.48694.jnareb@gmail.com> <200811091955.19304.kai@samba.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	Tim Ansell <mithro@mithis.com>
To: Kai Blin <kai@samba.org>
X-From: git-owner@vger.kernel.org Mon Nov 10 10:51:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzTR2-0006Yg-PX
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 10:51:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753831AbYKJJue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 04:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753784AbYKJJue
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 04:50:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:38522 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753487AbYKJJud (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 04:50:33 -0500
Received: (qmail invoked by alias); 10 Nov 2008 09:50:31 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp026) with SMTP; 10 Nov 2008 10:50:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+n80xBMo6nXwFP+hugqs+E7at5/lTbvBx5LTcI2j
	o2aAlafXVCptaS
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200811091955.19304.kai@samba.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100504>

Hi,

On Sun, 9 Nov 2008, Kai Blin wrote:

> On Sunday 09 November 2008 17:31:47 Jakub Narebski wrote:
> 
> > The workaround is to put all large files for example in 'media/' 
> > folder, and make this folder be submodule. Each clone of repository 
> > can have this 'media' submodule either present (both in object 
> > database, although usually separate from main project object 
> > database), or not present (not cloned and not checked out).
> 
> Tim was talking about that media/ folder and managing that in git. If 
> you want to work on the media, you might end up getting hundreds of 
> gigabytes of data to get that folder, even if you only need to change 
> one single file.
> 
> That's the issue we're running into, and I don't thing submodules solve 
> this at all.

You'd have to have a single repository for each and every media file, and 
you'd need to use shallow clones and shallow fetches.

However, a push-conflict will probably be beyond any non-programmer 
skillz.

I'd rather propose to have a different interface, like through a web 
server, where the user can say "I have some cool new graphics, in this 
.zip file" together with a commit message.

Kind of a git-gui via browser.

Ciao,
Dscho

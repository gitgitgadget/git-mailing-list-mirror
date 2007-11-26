From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [WIP PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Mon, 26 Nov 2007 16:47:30 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711261646170.27959@racer.site>
References: <Pine.LNX.4.64.0711210336210.27959@racer.site> <fi5743$32p$1@ger.gmane.org>
 <Pine.LNX.4.64.0711230050270.27959@racer.site>
 <f329bf540711221723g2754ce03r4da6d429c45668c@mail.gmail.com>
 <Pine.LNX.4.64.0711230149430.27959@racer.site> <20071123205958.GC14735@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: hanwen@xs4all.nl, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 17:53:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwhCF-0007Pw-9q
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 17:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758055AbXKZQrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 11:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758042AbXKZQrf
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 11:47:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:48469 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758029AbXKZQre (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 11:47:34 -0500
Received: (qmail invoked by alias); 26 Nov 2007 16:47:31 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp021) with SMTP; 26 Nov 2007 17:47:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX180UfE7Hqc0BZik/HHQKQrKMb45eEbqzMHm2gyLfq
	XiOMNyZSercllH
X-X-Sender: gene099@racer.site
In-Reply-To: <20071123205958.GC14735@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66081>

Hi,

On Fri, 23 Nov 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Thu, 22 Nov 2007, Han-Wen Nienhuys wrote:
> > 
> > > > Maybe you want to specify if all blobs should be output first, and 
> > > > then the commits?  Or files should be used?  But all of these things 
> > > > seem to be useless to me.
> > > 
> > > No, I want the program to wait for me to tell it what 
> > > blobs/commits/trees I want. The commit I want to see secondly may depend 
> > > on the output I read in the first request blob. Right now, for each data 
> > > dependency I have to start a new git process.
> > 
> > It does not seem like you want a mirror of fast-import, but rather a 
> > driver.  You might be happy to hear that you can do that already.  Today.
> > However, you probably want to query different programs about certain 
> > states of the repository.  This will not change.
> > 
> > > > > Besides being a nuisance, I actually run git on NFS, and every git 
> > > > > process has to go to NFS a couple times to retrieve the same 
> > > > > information. This has a noticeable performance impact.
> 
> I have been considering creating a "git-gui daemon" process that links 
> to libgit.a and can be driven bidirectionally through its stdin/stdout.  
> Based on git-fast-export, sorta.  But I haven't even started it...
> 
> But the idea is sort of what Han-Wen wants.  Why should I fork rev-parse 
> to get a ref value?  Or update-ref to change one?

I was thinking about this a little bit more.  But I cannot think of a 
really versatile way of enhancing fast-export enough to be of use there.  
Well, if not doing something with SWIG, that is ;-)

Ciao,
Dscho

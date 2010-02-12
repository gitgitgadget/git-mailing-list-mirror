From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GSoC 2010
Date: Fri, 12 Feb 2010 10:35:49 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002121034320.20986@pacific.mpi-cbg.de>
References: <fabb9a1e1002101223o6a00f7eavb84567c1119c8ebc@mail.gmail.com> <20100212080620.GA31719@dcvr.yhbt.net> <alpine.DEB.1.00.1002121000290.20986@pacific.mpi-cbg.de> <fabb9a1e1002120103j3f37d417ka5b7b7ca3ae8edd@mail.gmail.com>
 <20100212091635.GA22942@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Feb 12 10:29:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfrqE-0002Bb-QW
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 10:29:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070Ab0BLJ3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 04:29:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:51809 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751871Ab0BLJ3T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 04:29:19 -0500
Received: (qmail invoked by alias); 12 Feb 2010 09:29:17 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp009) with SMTP; 12 Feb 2010 10:29:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18gHPM78Gsg3HI3MHybc3sHnfJW0ETMV/XFdLAnVl
	29eLOgIe+zMexS
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20100212091635.GA22942@glandium.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66000000000000003
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139670>

Hi,

On Fri, 12 Feb 2010, Mike Hommey wrote:

> On Fri, Feb 12, 2010 at 10:03:43AM +0100, Sverre Rabbelier wrote:
> 
> > On Fri, Feb 12, 2010 at 10:02, Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > > Would it not make sense to implement git-remote-svn as a C program? 
> > > That should help matters especially on Windows, where git-svn is 
> > > very slow due to its using MSys (which is a stripped-down Cygwin, as 
> > > you know, jumping through hoops to bring some POSIX-iness to 
> > > Windows).
> > 
> > It would very much be sense to do so, perhaps we should update the 
> > wiki to say that implementing it in C is strongly preferred?
> 
> It is already mentioned on the wiki that this would probably be a 
> problem, license-wise. (the svn library is Apache license, which is 
> incompatible with GPLv2)

So git-remote-svn would have to be under an Apache-compatible license, so 
what? It is not as if git-remote-svn was a derivative work of Git, just 
because it abides by a very simple command-line interface that happens to 
be defined in Git, but would work anywhere else, too.

Ciao,
Dscho

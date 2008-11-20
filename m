From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git and mtime
Date: Thu, 20 Nov 2008 11:35:45 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811201134570.30769@pacific.mpi-cbg.de>
References: <20081119113752.GA13611@ravenclaw.codelibre.net> <46d6db660811190818r3aa2a392pda9106ac4a579cf0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Roger Leigh <rleigh@codelibre.net>, git@vger.kernel.org
To: Christian MICHON <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 11:29:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L36mt-0003Ot-TG
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 11:29:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754628AbYKTK1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 05:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753660AbYKTK1t
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 05:27:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:54434 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753566AbYKTK1s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 05:27:48 -0500
Received: (qmail invoked by alias); 20 Nov 2008 10:27:46 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 20 Nov 2008 11:27:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX188EBplaUk81LdtkmC1WFGA3EBMHGQ08JkroJgT/4
	e2+cFUjFLhb4Fv
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <46d6db660811190818r3aa2a392pda9106ac4a579cf0@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101402>

Hi,

On Wed, 19 Nov 2008, Christian MICHON wrote:

> On Wed, Nov 19, 2008 at 12:37 PM, Roger Leigh <rleigh@codelibre.net> wrote:
> > Would it be possible for git to store the mtime of files in the tree?
> >
> > This would make it possible to do this type of work in git, since it's 
> > currently a bit random as to whether it works or not.  This only 
> > started when I upgraded to an amd64 architecture from powerpc32, I 
> > guess it's maybe using high-resolution timestamps.
> >
> 
> beside the obvious answer it comes back often as a request, it is 
> possible in theory to create a shell script which, for each file present 
> in the sandbox in the current branch, would find the mtime of the last 
> commit on that file (quite an expensive operation) and apply it.
> 
> I had a need for this once, then lost interest since using git as it is 
> is so much better than trying to mimic behaviour of old scm tools and 
> makefiles.

I had a need like this, too, and solved it by teaching the build process 
to fall back to generated files if the tool to generate them was not 
available.

Ciao,
Dscho

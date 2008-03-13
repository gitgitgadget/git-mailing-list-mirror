From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Q] Encrypted GIT?
Date: Thu, 13 Mar 2008 16:21:44 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803131620270.1656@racer.site>
References: <c6c947f60803130148w7981a3f0r718c0801343c7b78@mail.gmail.com> <20080313114738.GC2414@genesis.frugalware.org> <alpine.LSU.1.00.0803131254580.1656@racer.site> <20080313121644.GD2414@genesis.frugalware.org> <20080313125853.GA12927@mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 13 16:23:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZpG6-00085M-JB
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 16:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbYCMPVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 11:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752690AbYCMPVk
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 11:21:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:56229 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752536AbYCMPVj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 11:21:39 -0400
Received: (qmail invoked by alias); 13 Mar 2008 15:21:37 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp004) with SMTP; 13 Mar 2008 16:21:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19mFEA8FL1m8ONUSknNqZXB/FOwFEgLTEGje5xbmo
	NNVVA/uJcoIMg5
X-X-Sender: gene099@racer.site
In-Reply-To: <20080313125853.GA12927@mit.edu>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77096>

Hi,

On Thu, 13 Mar 2008, Theodore Tso wrote:

> On Thu, Mar 13, 2008 at 01:16:44PM +0100, Miklos Vajna wrote:
> > On Thu, Mar 13, 2008 at 12:55:11PM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > The latter can be remedied (somewhat) by encrypting each object 
> > > individually.  In that case, .gitattributes can help (you should be 
> > > able to find a mail to that extent, which I sent no more than 2 
> > > weeks ago).  However, you must make sure that the encryption is 
> > > repeatable, i.e. two different encryption runs _must_ result in 
> > > _identical_ output.
> > 
> > afaik, this is not the case for gpg.
> 
> No, and you wouldn't want to use gpg because of the overhead it adds
> around an encrypted message.

To the contrary: if your files are small (which they are most likely), you 
_want_ the overhead, in order to make the encryption harder to crack.

AFAICT gpg is a good all-round encryption tool, and reinventing the wheel 
just for encrypting things in a git repository just does not cut it.

Ciao,
Dscho

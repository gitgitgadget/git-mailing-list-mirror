From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Pay attention to GIT_DIR when searching the git
 directory
Date: Mon, 5 May 2008 17:33:27 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805051731350.30431@racer>
References: <1209946178-29398-1-git-send-email-joerg@alea.gnuu.de> <alpine.DEB.1.00.0805051234260.30431@racer> <20080505125302.GA11523@alea.gnuu.de> <m3r6cg6dur.fsf@localhost.localdomain> <20080505153029.GA12733@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-812054333-1210005208=:30431"
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Mon May 05 18:34:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt3e7-00053g-CD
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 18:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755585AbYEEQdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 12:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755907AbYEEQdc
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 12:33:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:56396 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754973AbYEEQdb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 12:33:31 -0400
Received: (qmail invoked by alias); 05 May 2008 16:33:29 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp015) with SMTP; 05 May 2008 18:33:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19S6WtNTEtS2X+0lMMs1z0jJo6ry2E+o1Zo51bioD
	GreF3uQ6D/haPC
X-X-Sender: gene099@racer
In-Reply-To: <20080505153029.GA12733@alea.gnuu.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81295>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-812054333-1210005208=:30431
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 5 May 2008, Jörg Sommer wrote:

> Hi Jakub,
> 
> Jakub Narebski schrieb am Mon 05. May, 07:10 (-0700):
> > Jörg Sommer <joerg@alea.gnuu.de> writes:
> > > Johannes Schindelin schrieb am Mon 05. May, 12:36 (+0100):
> > 
> > > > If you do not say _what_ is affected by the change, you only 
> > > > confuse the readers.
> > > 
> > > Do you want something like “initialization: Pay attention to GIT_DIR 
> > > when searching the git directory”?
> > 
> > I think the idea was to use
> >   "contrib/hooks/setgitperms: Use GIT_DIR if set"
> > or something like that.
> 
> Well, if this is the prefered form, I'll use it. But I don't like it,
> because the affected file is a piece of information that's already in the
> commit object.

Well, I don't like that you thereby waste the time of those who look at 
the commit message.  By your reasoning, one might think that commit 
messages are superfluous, because you can always read the patch, or go 
back to the mailing list thread.

Ciao,
Dscho
> > There are a few unwritten conventions.
> 
> Are there any plans to write them down?

Actually, they are written down implicitly.  You can look at them with the 
command "git log".

Ciao,
Dscho

--8323329-812054333-1210005208=:30431--

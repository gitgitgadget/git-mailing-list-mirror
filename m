From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: how to backup git
Date: Mon, 12 May 2008 19:21:02 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805121920120.30431@racer>
References: <4827DEF6.1050005@gmail.com> <87ej87is50.fsf@offby1.atm01.sea.blarg.net> <alpine.DEB.1.00.0805121428310.30431@racer> <48285087.3090402@gmail.com> <alpine.DEB.1.00.0805121606010.30431@racer> <20080512152731.GM31039@zakalwe.fi>
 <alpine.DEB.1.00.0805121804500.30431@racer> <20080512180720.GN31039@zakalwe.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: bill lam <cbill.lam@gmail.com>, git@vger.kernel.org
To: Heikki Orsila <shdl@zakalwe.fi>
X-From: git-owner@vger.kernel.org Mon May 12 20:22:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvcer-0006mW-Cm
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 20:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbYELSVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 14:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753720AbYELSVH
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 14:21:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:51586 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752777AbYELSVG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 14:21:06 -0400
Received: (qmail invoked by alias); 12 May 2008 18:21:03 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp029) with SMTP; 12 May 2008 20:21:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19CUUFR+iJCmf6ViT4DxdC6MEAlRUvMGM7tOKCk0o
	SlaHozbeVxPeHD
X-X-Sender: gene099@racer
In-Reply-To: <20080512180720.GN31039@zakalwe.fi>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81895>

Hi,

On Mon, 12 May 2008, Heikki Orsila wrote:

> On Mon, May 12, 2008 at 06:07:28PM +0100, Johannes Schindelin wrote:
> 
> > On Mon, 12 May 2008, Heikki Orsila wrote:
> > 
> > > On Mon, May 12, 2008 at 04:08:21PM +0100, Johannes Schindelin wrote:
> > > > No, rsync is particularly dumb in that respect.  The safest thing 
> > > > would be to back up the reflogs first (e.g. with rsync), then 
> > > > repack and then clone (the clone will transmit the objects 
> > > > referenced by the reflogs, too).  Note: the same holds _not_ true 
> > > > for a simple fetch.
> > > > 
> > > > But then, you usually do not want to back up reflogs anyway, since 
> > > > they are purely local and not visible to anybody else.
> > > 
> > > Is there a simple and efficient mechanism for incremental backups?
> > 
> > Umm.  "git fetch"?
> > 
> > Like I said, it does not get the reflogs, but if you want to back up a 
> > repository, the safest is to clone once, and fetch later.  Or you 
> > could set up a remote with the --mirror option, if you want to 
> > preserve the refs' namespaces.
> 
> Preferably some solution that does not require too much understanding of 
> Git internals so that admins will actually use it, instead of hacking 
> their own inefficient backup scripts.
> 
> Could someone please write a "git-backup" script?-)

Heikki, why don't you just go with the "git fetch" approach I described?  
We do not need "git backup" when "git fetch" does already what you want.

Ciao,
Dscho

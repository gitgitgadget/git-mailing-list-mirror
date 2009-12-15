From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git-reflog 70 minutes at 100% cpu and counting
Date: Mon, 14 Dec 2009 19:26:33 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912141924030.23173@xanadu.home>
References: <1260822484.9379.53.camel@localhost>
 <20091214211142.GC9364@coredump.intra.peff.net>
 <1260825629.9379.56.camel@localhost>
 <20091214212343.GA11131@coredump.intra.peff.net>
 <1260827790.9379.59.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Eric Paris <eparis@redhat.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 01:26:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKLFV-0007KN-7Q
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 01:26:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758891AbZLOA0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 19:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758845AbZLOA0k
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 19:26:40 -0500
Received: from relais.videotron.ca ([24.201.245.36]:64447 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752325AbZLOA0j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 19:26:39 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KUO005UX3W9LXM0@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 14 Dec 2009 19:26:33 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <1260827790.9379.59.camel@localhost>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135256>

On Mon, 14 Dec 2009, Eric Paris wrote:

> On Mon, 2009-12-14 at 16:23 -0500, Jeff King wrote:
> > On Mon, Dec 14, 2009 at 04:20:29PM -0500, Eric Paris wrote:
> > 
> > > Updated to git-1.6.5.3-1 from Fedora rawhide and still git reflog ran
> > > for >5 minutes at 100% cpu (I killed it, it didn't finish)
> > > 
> > > I'm pushing a copy of the whole repo (all 1.9G after bzip compression)
> > > to
> > > 
> > > http://people.redhat.com/~eparis/git-tar/
> > 
> > Wowzers, that's big. Can you send just what's in .git?
> 
> So I zipped up just .git   1.2G.  I did a make clean and zipped up the
> whole repo  1.3G.
> 
> Just started pushing the 1.3G file.
> 
> Maybe having a .git directory that large is the problem?

Shouldn't be, unless your repo is really badly packed.

What's the output of 'git count-objects -v' ?


Nicolas

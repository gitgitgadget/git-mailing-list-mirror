From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git-reflog 70 minutes at 100% cpu and counting
Date: Mon, 14 Dec 2009 22:50:01 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912142245240.23173@xanadu.home>
References: <1260822484.9379.53.camel@localhost>
 <20091214211142.GC9364@coredump.intra.peff.net>
 <1260825629.9379.56.camel@localhost>
 <20091215023918.GA14689@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Eric Paris <eparis@redhat.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 15 04:50:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKOQN-0002Qf-4f
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 04:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755907AbZLODuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 22:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755505AbZLODuE
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 22:50:04 -0500
Received: from relais.videotron.ca ([24.201.245.36]:33351 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755399AbZLODuC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 22:50:02 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KUO00LRPDBDRKC0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 14 Dec 2009 22:50:01 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20091215023918.GA14689@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135266>

On Mon, 14 Dec 2009, Jeff King wrote:

> On Mon, Dec 14, 2009 at 04:20:29PM -0500, Eric Paris wrote:
> 
> > I'm pushing a copy of the whole repo (all 1.9G after bzip compression)
> > to
> > 
> > http://people.redhat.com/~eparis/git-tar/
> > 
> > But it's going to take a couple hours.
> 
> Holy cow. Almost 150 packs, and that's not even everything. The tarball
> is missing a bunch of objects, because it points to your kernel-1 as an
> alternate. So I suspect we would need that, as well, to recreate.

Hmmm... Rebasing repositories mixed with alternates...  I wonder if the 
infinite loop might not actually be due to a delta cycle, especially if 
the alternate is also rebasing.

So having the alternate, too, would certainly be interesting.


Nicolas

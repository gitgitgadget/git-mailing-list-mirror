From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git-reflog 70 minutes at 100% cpu and counting
Date: Mon, 14 Dec 2009 22:58:02 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912142255530.23173@xanadu.home>
References: <1260822484.9379.53.camel@localhost>
 <20091214211142.GC9364@coredump.intra.peff.net>
 <1260825629.9379.56.camel@localhost>
 <20091214212343.GA11131@coredump.intra.peff.net>
 <1260827790.9379.59.camel@localhost>
 <alpine.LFD.2.00.0912141924030.23173@xanadu.home>
 <7vk4wpax99.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Eric Paris <eparis@redhat.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 04:58:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKOYB-0004Ik-2z
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 04:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758497AbZLOD6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 22:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758459AbZLOD6J
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 22:58:09 -0500
Received: from relais.videotron.ca ([24.201.245.36]:56242 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758154AbZLOD6D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 22:58:03 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KUO00FUYDOQ0TD1@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 14 Dec 2009 22:58:02 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vk4wpax99.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135268>

On Mon, 14 Dec 2009, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > On Mon, 14 Dec 2009, Eric Paris wrote:
> >
> >> On Mon, 2009-12-14 at 16:23 -0500, Jeff King wrote:
> >> > On Mon, Dec 14, 2009 at 04:20:29PM -0500, Eric Paris wrote:
> >> > 
> >> > > Updated to git-1.6.5.3-1 from Fedora rawhide and still git reflog ran
> >> > > for >5 minutes at 100% cpu (I killed it, it didn't finish)
> >> > > 
> >> > > I'm pushing a copy of the whole repo (all 1.9G after bzip compression)
> >> > > to
> >> > > 
> >> > > http://people.redhat.com/~eparis/git-tar/
> >> > 
> >> > Wowzers, that's big. Can you send just what's in .git?
> >> 
> >> So I zipped up just .git   1.2G.  I did a make clean and zipped up the
> >> whole repo  1.3G.
> >> 
> >> Just started pushing the 1.3G file.
> >> 
> >> Maybe having a .git directory that large is the problem?
> >
> > Shouldn't be, unless your repo is really badly packed.
> >
> > What's the output of 'git count-objects -v' ?
> 
> Didn't somebody say that the trace hints an infinite loop not "slow
> because of bad packing"?

Maybe.  But I was curious about the size too, which turns out to be 
really bad packing.  Of course bad packing shouldn't affect the 
correctness of the repository.


Nicolas

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 0/4] Honor core.deltaBaseCacheLimit during index-pack
Date: Thu, 17 Jul 2008 21:35:50 +0000
Message-ID: <20080717213550.GA2798@spearce.org>
References: <20080714031242.GA14542@spearce.org> <alpine.LSU.1.00.0807141216390.32392@wbgn129.biozentrum.uni-wuerzburg.de> <m31w1wu1hc.fsf@localhost.localdomain> <487B439F.8040902@op5.se> <alpine.DEB.1.00.0807141322140.8950@racer> <487B4BD8.5030208@op5.se> <alpine.LFD.1.10.0807142203530.12484@xanadu.home> <20080715024741.GB1700@spearce.org> <487F6E04.9050106@arcor.de> <alpine.LFD.1.10.0807171215020.3110@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stephan Hennig <mailing_list@arcor.de>,
	Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Jul 17 23:36:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJb9f-0000ms-Fv
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 23:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932615AbYGQVfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 17:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758965AbYGQVfw
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 17:35:52 -0400
Received: from george.spearce.org ([209.20.77.23]:33373 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759031AbYGQVfv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 17:35:51 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2A74F382A4; Thu, 17 Jul 2008 21:35:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0807171215020.3110@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88923>

Nicolas Pitre <nico@cam.org> wrote:
> On Thu, 17 Jul 2008, Stephan Hennig wrote:
> > Even though Git now makes some efforts to substitute runtime
> > for memory to be able to operate with low(er) memory, I think it would
> > still be informative for a user that repository and hardware, resp.
> > core.deltaBaseCacheLimit, are, say, incompatible.  If valuable objects
> > have to be discarded due to memory restrictions a warning could be
> > issued to make the user aware of this fact, e.g.,
> > 
> >   Warning! Low memory. Git might be slowing down.
> 
> Well, I disagree.  First we don't know how slow git would effectively be 
> since all (my) concerns so far were totally theoretical.  It will still 
> work better than, say, 'git verify-pack' nevertheless. And git should 
> just do its best regardless and avoid being needlessly verbose.

Actually, this warning may be a good idea.  I'll post an RFC patch
for it in a few minutes.  If people hate the idea, that's what an
RFC is for.  :)

-- 
Shawn.

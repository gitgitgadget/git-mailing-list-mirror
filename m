From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Thu, 02 Sep 2010 20:36:31 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009022033520.19366@xanadu.home>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
 <AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
 <AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
 <4C7FC3DC.3060907@gmail.com>
 <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
 <20100902155810.GB14508@sigill.intra.peff.net>
 <alpine.LFD.2.00.1009021233190.19366@xanadu.home> <4C7FDA32.5050009@gmail.com>
 <alpine.LFD.2.00.1009021326290.19366@xanadu.home>
 <AANLkTi=Q7EfeUDB6PuSa88PDtaBZSMMuaMqh8hU25ECb@mail.gmail.com>
 <20100902192910.GJ32601@spearce.org>
 <AANLkTimDi=KYZ7Bs4C+WEGoP8y-yzjynddWpkxohWoix@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_38X+vNymuB+sOWKg4HkhSw)"
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 03 02:37:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrKHE-0006ML-Bv
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 02:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756192Ab0ICAgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 20:36:45 -0400
Received: from relais.videotron.ca ([24.201.245.36]:45212 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444Ab0ICAgh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 20:36:37 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L85005PUB0SQ522@VL-MR-MRZ20.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 02 Sep 2010 20:36:29 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <AANLkTimDi=KYZ7Bs4C+WEGoP8y-yzjynddWpkxohWoix@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155230>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_38X+vNymuB+sOWKg4HkhSw)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Thu, 2 Sep 2010, Luke Kenneth Casson Leighton wrote:

> On Thu, Sep 2, 2010 at 8:29 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> > Luke Kenneth Casson Leighton <luke.leighton@gmail.com> wrote:
> >>
> >>  * based on what you kindly mentioned about "git repack -f", would a
> >> (well-written!) patch to git pack-objects to add a
> >> "--single-thread-only" option be acceptable?
> >
> > Probably not.  I can't think of a good reason to limit the number
> > of threads that get used.
> 
>  i can - so that git pack-objects, after "git repack -f", returns a
> canonical pack! :)

But did you try it?  The -f means "don't reuse any existing pack data 
and recompute every delta from scratch to find the best matches".  This 
is a very very costly operation that most people happily live without.


Nicolas

--Boundary_(ID_38X+vNymuB+sOWKg4HkhSw)--

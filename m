From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Thu, 02 Sep 2010 13:31:39 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009021326290.19366@xanadu.home>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
 <AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
 <AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
 <4C7FC3DC.3060907@gmail.com>
 <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
 <20100902155810.GB14508@sigill.intra.peff.net>
 <alpine.LFD.2.00.1009021233190.19366@xanadu.home> <4C7FDA32.5050009@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>,
	Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 19:31:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrDdb-0007xH-41
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 19:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966Ab0IBRbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 13:31:40 -0400
Received: from relais.videotron.ca ([24.201.245.36]:12432 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893Ab0IBRbk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 13:31:40 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L840044DRCPDM61@VL-MR-MRZ20.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 02 Sep 2010 13:31:37 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4C7FDA32.5050009@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155153>

On Thu, 2 Sep 2010, A Large Angry SCM wrote:

> On 09/02/2010 12:41 PM, Nicolas Pitre wrote:
> 
> > For example, right now you already can't rely on having the exact same
> > pack output even on the same machine using the same arguments and the
> > same inputs simply by using threads.  As soon as you're using more than
> > one thread (most people do these days) then your pack output becomes non
> > deterministic.
> 
> Finally, the real pack expert weighs in!

BTW I just have a little time to quickly scan through my git mailing 
list backlog these days, and stumbled on this by luck.  So if people 
want my opinion on such matters it is safer to CC me directly.


Nicolas

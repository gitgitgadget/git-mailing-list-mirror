From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 16:47:55 -0400
Message-ID: <20061018204755.GB19194@spearce.org>
References: <4535590C.4000004@utoronto.ca> <200610180057.25411.jnareb@gmail.com> <Pine.LNX.4.64.0610171610270.3962@g5.osdl.org> <20061018053647.GA3507@coredump.intra.peff.net> <Pine.LNX.4.64.0610180739230.3962@g5.osdl.org> <20061018185225.GU20017@pasky.or.cz> <20061018185907.GV20017@pasky.or.cz> <7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610181510510.1971@xanadu.home> <7vr6x51ks3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 22:48:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaIKy-0000KD-Na
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 22:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422956AbWJRUsE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 16:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422949AbWJRUsE
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 16:48:04 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:63129 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1422956AbWJRUsB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 16:48:01 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GaIKR-0006FK-Te; Wed, 18 Oct 2006 16:47:55 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B71CE20E42A; Wed, 18 Oct 2006 16:47:55 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr6x51ks3.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29264>

Junio C Hamano <junkio@cox.net> wrote:
> Nicolas Pitre <nico@cam.org> writes:
> 
> > Ah true.  I missed the "thin" pack.
> >
> > Any idea why we should still prevent this?  It is not like it was a 
> > technical limitation.
> 
> It is a technical limitation.  We have never assumed that the
> virtual address space is big enough to hold more than one whole
> pack mmapped at the same time.

Even though its not big enough for some larger packs on a 32
bit system.
 
> Lifting this needs the piecemeal mmap() change somebody was
> talking about.
> 
> I might bite the bullet and do that myself but I've been hoping
> to get an appliable patch from somewhere else ;-).

I might be able to do it this weekend.  I'll try to spend some time
on it.  You'll either see a patch series, or you won't.  ;-)

-- 
Shawn.

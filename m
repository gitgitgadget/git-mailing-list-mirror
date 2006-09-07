From: Shawn Pearce <spearce@spearce.org>
Subject: Re: A look at some alternative PACK file encodings
Date: Thu, 7 Sep 2006 01:46:51 -0400
Message-ID: <20060907054651.GD31580@spearce.org>
References: <44FF41F4.1090906@gmail.com> <9e4733910609061623k73086dbey4a600ecf2852c024@mail.gmail.com> <Pine.LNX.4.64.0609062037560.18635@xanadu.home> <20060907043300.GA31376@spearce.org> <7vslj4455z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 08:08:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLD3I-00018C-Mp
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 08:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbWIGGHb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 02:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751942AbWIGGHb
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 02:07:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:16591 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751941AbWIGGH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 02:07:29 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GLD2t-0001TJ-8Q; Thu, 07 Sep 2006 02:07:27 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AEF3120E42C; Thu,  7 Sep 2006 01:46:51 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vslj4455z.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26595>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > And I'm half-way done with the 64 bit mmap sliding window.  You,
> > Junio and I are all hacking on the same tiny bit of core code for
> > different reasons.  :-)
> 
> Which makes me quite nervous, actually.

What order do you want the patches in then?

I'm willing to go before or after Nico's offset changes, and before
or after your 64 bit index changes.

Either way two of us are going to have to redo our work on top of
the others.  I'm finding that I'm basically rewriting the sliding
window code onto your 64 bit version - there's no easy merge here.
And Nico's got the same problem, he's in unpack_delta_entry too.

-- 
Shawn.

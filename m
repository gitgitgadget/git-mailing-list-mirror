From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Mozilla .git tree
Date: Sat, 2 Sep 2006 23:54:09 -0400
Message-ID: <20060903035409.GA29756@spearce.org>
References: <20060830015122.GE22935@spearce.org> <9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com> <20060830031029.GA23967@spearce.org> <Pine.LNX.4.64.0608300124550.9796@xanadu.home> <7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net> <7vr6yw58xp.fsf@assigned-by-dhcp.cox.net> <20060902020426.GF24234@spearce.org> <7v3bba1qg5.fsf@assigned-by-dhcp.cox.net> <20060902175125.GC27826@spearce.org> <7vejuuyon7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 03 11:27:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJoGf-0005cu-1s
	for gcvg-git@gmane.org; Sun, 03 Sep 2006 11:27:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWICJ1r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Sep 2006 05:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbWICJ1r
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Sep 2006 05:27:47 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37041 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1752085AbWICGfG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Sep 2006 02:35:06 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GJlYe-0001X8-17; Sun, 03 Sep 2006 02:35:02 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5080020FB7C; Sat,  2 Sep 2006 23:54:09 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vejuuyon7.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26367>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> >> > Sure the scheme you outlined allows a 64 bit difference but
> >> > uncompressed objects already can't be larger than 2**32-1...
> >> 
> >> Where do we have that limitation?
> >
> > sha1_file.c uses "unsigned long" a lot to deal with size of an
> > object, deflated.  iirc unsigned long is only 32 bits even in many
> > 64 bit architectures.  Or am I wrong?
> 
> Of course 4G .idx (\377tOc) patch would update them to u64.
> What is the problem?

None then.  I must have missed that.

Besides this issue is moot as you are removing it from the .idx.

Sorry for the noise.  :-)

-- 
Shawn.

-- 
VGER BF report: S 0.999999

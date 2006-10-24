From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Make git-branch a builtin
Date: Tue, 24 Oct 2006 02:55:48 -0400
Message-ID: <20061024065548.GB9947@spearce.org>
References: <11616396262982-git-send-email-hjemli@gmail.com> <20061023215506.GB8344@spearce.org> <7vfydewqbb.fsf@assigned-by-dhcp.cox.net> <20061024054408.GA9724@spearce.org> <7vy7r6qkmg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 08:56:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcGCo-0005Oj-Tb
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 08:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWJXGzz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 02:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWJXGzz
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 02:55:55 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47328 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932392AbWJXGzy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 02:55:54 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GcGCU-00031f-Ih; Tue, 24 Oct 2006 02:55:50 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D12CE21269E; Tue, 24 Oct 2006 02:55:48 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy7r6qkmg.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29938>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> >> > Wouldn't it make more sense to just include the full SHA1 of the
> >> > file we are deleting rather than the entire 131 line negative diff?
> >> 
> >> How would you do "git apply -R" on something like that?
> >
> > Uh, you have the full SHA1 in the index line.  So you just have to
> > reattach that blob to the named path...  pretty simple actually.
> 
> Bzzzt; wrong answer.
> 
> Think of a future when you can shallowly clone near the tip of
> git repository that does not have shell-script git-branch.sh
> anymore.  You cannot expect to already have the preimage of the
> patch in such a case.  You would still want to be able to revert
> the change with "git apply -R".

Yet another valid argument for having the data needed for the
preimage available.

I've already agreed with Petr that having the data there is probably
better than not.  Now I'm also agreeing with you.  There is little
need to beat a dead horse.  :-)

-- 
Shawn.

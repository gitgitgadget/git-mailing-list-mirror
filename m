From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [ANNOUNCE] Git wiki
Date: Wed, 3 May 2006 10:29:58 -0400
Message-ID: <20060503142957.GA9056@spearce.org>
References: <20060502232553.GL27689@pasky.or.cz> <7virooj92i.fsf@assigned-by-dhcp.cox.net> <4d8e3fd30605030139k33c5a404k54861fdd02c87134@mail.gmail.com> <20060503090007.GM27689@pasky.or.cz> <4d8e3fd30605030213r625ce87fw5cbee554f1c20fbd@mail.gmail.com> <Pine.LNX.4.64.0605030934220.28543@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 16:30:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbIMs-0002mX-Mb
	for gcvg-git@gmane.org; Wed, 03 May 2006 16:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965199AbWECOaP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 10:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965202AbWECOaP
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 10:30:15 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43486 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S965199AbWECOaN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 May 2006 10:30:13 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FbIMV-0005al-8d; Wed, 03 May 2006 10:29:55 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 25E1F2303C8; Wed,  3 May 2006 10:29:58 -0400 (EDT)
To: Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605030934220.28543@localhost.localdomain>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19484>

Nicolas Pitre <nico@cam.org> wrote:
> On Wed, 3 May 2006, Paolo Ciarrocchi wrote:
> > On 5/3/06, Petr Baudis <pasky@suse.cz> wrote:
> > > Dear diary, on Wed, May 03, 2006 at 10:39:07AM CEST, I got a letter
> > > where Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> said that...
> > > > On 5/3/06, Junio C Hamano <junkio@cox.net> wrote:
> > > > 
> > > > BTW, do you know why GIT has not been selected as SCM for OpenSolaris?
> > > > (they choose Mercurial).
> > > 
> > > I think it's explained somewhere in their forums (or mailing lists or
> > > whatever they actually _are_).
> > 
> > I only found the announcement, not the rationales.
> 
> http://mail.opensolaris.org/pipermail/tools-discuss/2006-April/000366.html
> 
> Looks like they didn't buy the argument about the uselessness of 
> recording file renames.

The final evaluations are available from here (at the very bottom
of the page):

  http://opensolaris.org/os/community/tools/scm/

It looks like Mercurial doesn't support renames either, but a lot
of users are asking for it to be supported.  So I don't think that's
the reason.  It looks more like they didn't enjoy porting GIT 1.2.2
(as 1.2.4 was found to not work in all cases) to Solaris and the
tester ran into some problems with the conflict resolution support.

My own reading of the two final evaluations for GIT and Mercurial
leaves me feeling like GIT is a more mature tool which is faster
and more stable then Mercurial.  GIT seemed to be more reliable
during testing then Mercurial was, despite the cloning issue.
Which makes me surprised that OpenSolaris selected Mercurial instead.


-- 
Shawn.

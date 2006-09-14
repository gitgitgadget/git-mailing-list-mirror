From: Shawn Pearce <spearce@spearce.org>
Subject: Re: cvs import
Date: Thu, 14 Sep 2006 12:18:09 -0400
Message-ID: <20060914161809.GA9885@spearce.org>
References: <45084400.1090906@bluegap.ch> <9e4733910609131201q7f583029r72dac66cd0dd098f@mail.gmail.com> <46a038f90609131341se42b2dcne73c017cf757d13a@mail.gmail.com> <450872AE.5050409@bluegap.ch> <9e4733910609131438n686b6d72u4d5799533c7473d7@mail.gmail.com> <4508EA78.5030001@alum.mit.edu> <20060914155003.GB9657@spearce.org> <eebuih$u32$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, monotone-devel@nongnu.org,
	dev@rapidsvn.tigris.org
X-From: git-owner@vger.kernel.org Thu Sep 14 18:18:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNtut-0003CZ-HA
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 18:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWINQSP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 12:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbWINQSP
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 12:18:15 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:40602 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750968AbWINQSN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 12:18:13 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GNtue-0000zj-VM; Thu, 14 Sep 2006 12:18:05 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7CCCC20FB1F; Thu, 14 Sep 2006 12:18:09 -0400 (EDT)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eebuih$u32$1@sea.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27008>

Jakub Narebski <jnareb@gmail.com> wrote:
> Shawn Pearce wrote:
> 
> > Originally I wanted Jon Smirl to modify the cvs2svn (...)
> 
> By the way, will cvs2git (modified cvs2svn) and git-fast-import publicly
> available?

Yes.  I want to submit git-fast-import to the main Git project and
ask Junio to bring it in.

However right now I feel like the code isn't up-to-snuff and won't
pass peer review on the Git mailing list.  So I wanted to spend a
little bit of time cleaning it up before asking Junio to carry it
in the main distribution.  My pack mmap window code is actually
part of that cleanup.

I think the goal of this thread is to try and merge the ideas
behind Jon's modified cvs2svn into the core cvs2svn, possibly
causing cvs2svn to be renamed to cvs2notcvs (or some such) and
having a slightly more modular output format so Git, Monotone and
Subversion can all benefit from the difficult-to-do-right changeset
generation logic.

-- 
Shawn.

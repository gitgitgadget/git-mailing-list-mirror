From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] Merge strategy 'applyreject'
Date: Wed, 13 Sep 2006 18:26:08 -0400
Message-ID: <20060913222608.GG30782@spearce.org>
References: <20060913210817.GA30782@spearce.org> <20060913211617.GJ23891@pasky.or.cz> <7v1wqf789j.fsf@assigned-by-dhcp.cox.net> <20060913215043.GE30782@spearce.org> <ee9ult$mtn$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 14 00:26:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNdBP-00078D-Ic
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 00:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWIMW0N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 18:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWIMW0N
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 18:26:13 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36235 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751227AbWIMW0M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 18:26:12 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GNdBB-0002yA-Dp; Wed, 13 Sep 2006 18:26:01 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CDAF320E49A; Wed, 13 Sep 2006 18:26:08 -0400 (EDT)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <ee9ult$mtn$1@sea.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26960>

Jakub Narebski <jnareb@gmail.com> wrote:
> Shawn Pearce wrote:
> 
> > But I don't really want this as a merge strategy in its own right.
> > I want it as part of merge-recur (...)
> 
> Wouldn't it be better to have pluggable way to deal with conflicts,
> be it diff3/merge with conflict markers, .rej files, or invoking
> graphical merge tool (vimdiff, Emacs Emerge, xxdiff, Meld, KDiff3)?

Yes.  :-)

Right now I think the user could just "plug in" their own "merge"
program earlier in PATH than the real one.  :-)

It would be nice to get the speed of being able to just run the
xdiff code and the Git apply code directly on the file blobs in
memory, without forking, but I think pluggable file content merging
programs is a very good idea, for lots of different reasons.

-- 
Shawn.

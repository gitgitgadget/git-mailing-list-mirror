From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] Merge strategy 'applyreject'
Date: Wed, 13 Sep 2006 17:46:54 -0400
Message-ID: <20060913214654.GD30782@spearce.org>
References: <20060913210817.GA30782@spearce.org> <20060913211617.GJ23891@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 13 23:47:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNcZR-0007P3-4b
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 23:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWIMVq6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 17:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWIMVq6
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 17:46:58 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:19333 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751117AbWIMVq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 17:46:57 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GNcZD-0007ma-16; Wed, 13 Sep 2006 17:46:47 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 150A420E49A; Wed, 13 Sep 2006 17:46:54 -0400 (EDT)
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20060913211617.GJ23891@pasky.or.cz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26956>

Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Wed, Sep 13, 2006 at 11:08:17PM CEST, I got a letter
> where Shawn Pearce <spearce@spearce.org> said that...
> > Create merge strategy 'applyreject'.
> > 
> > The applyreject merge strategy is a two head merge strategy which performs
> > the merge by obtaining the diff between the common base and the branch
> > being merged and applies it to the current branch using git-apply --reject.
> > Consequently any failures are written to .rej files, rather than using
> > the RCS <<<<<<< ======= >>>>>>> format.
> 
> So, it's essentially the same as the classic resolve strategy, just
> handling rejects differently? I think that should be more obvious from
> its name, perhaps resolve-rej?

Unfortunately.  More ideally it would be a configurable feature
of merge-recur that gets used rather than invoking the RCS merge.
This is just a quick and dirty 3 line shell script to propose
the concept.

> .rej files, what a nuisance to handle those... :)

A matter of opinion. :)

-- 
Shawn.

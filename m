From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Regulator updates for 3.3
Date: Tue, 10 Jan 2012 23:17:03 +0000
Message-ID: <20120110231700.GA14242@opensource.wolfsonmicro.com>
References: <20120109073727.GF22134@opensource.wolfsonmicro.com> <CA+55aFyhoh0rT_ujuE1w3RpuR7kqivYFwPpm66VC-xtq1PiGUQ@mail.gmail.com> <20120110184530.GE7164@opensource.wolfsonmicro.com> <CA+55aFxXb7wqfrpozS6iH0k25y-+Uy8_Tavv59JXMhaWrjXLaw@mail.gmail.com> <20120110222711.GK7164@opensource.wolfsonmicro.com> <CA+55aFxvQF=Bm4ae6euB_UO8otMCuN9Lv37Zn3TpE-L7JH3Kzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 11 00:17:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkkwd-0004Wj-08
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 00:17:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757213Ab2AJXRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 18:17:09 -0500
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:55854 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757174Ab2AJXRF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2012 18:17:05 -0500
Received: by opensource.wolfsonmicro.com (Postfix, from userid 1001)
	id 6876F750062; Tue, 10 Jan 2012 23:17:03 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CA+55aFxvQF=Bm4ae6euB_UO8otMCuN9Lv37Zn3TpE-L7JH3Kzw@mail.gmail.com>
X-Cookie: Today is what happened to yesterday.
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188303>

On Tue, Jan 10, 2012 at 02:54:27PM -0800, Linus Torvalds wrote:
> On Tue, Jan 10, 2012 at 2:27 PM, Mark Brown

> > Especially in the cases where the lack of the bug fix breaks the new
> > code it sems sensible enough to want to do the merges so that the
> > history includes things that actually work.

> So I don't mind merges if they have a lear reason for existing.

OK, good - I figured that was the case but wanted to make sure as you
were stating things rather more strongly than that.

Just to warn you there's also a whole stack of similar merges going to
come in via the sound tree too due to the same workflow, I *could* try
to rebuild the history and ask Takashi to redo his tree using that but
there's a lot of history there and it'd be hard to figure out which of
the merges was actually important.  Is it OK to leave things as they are
for this release?

> So right now "git merge" (and "git pull") make it too easy to make
> those meaningless merge commits. If instead of seven pointless merges
> you had (say) had two merges that had messages about *why* they
> weren't pointless, I'd be perfectly happy.

> Addid junio and git to the cc just to bring up this issue of bad UI
> once again. I realize it could break old scripts to start up an editor
> window, but still..

I'd use a configuration option that popped up an editor by default, even
if I did have to manually enable it.

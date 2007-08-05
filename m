From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-diff new files (without using index)
Date: Sun, 5 Aug 2007 00:08:41 -0400
Message-ID: <20070805040841.GG9527@spearce.org>
References: <87wswalkad.fsf@catnip.gol.com> <20070805035245.GE9527@spearce.org> <87r6miljfr.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 06:09:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHXQN-0006SG-Fz
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 06:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbXHEEIs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 00:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbXHEEIs
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 00:08:48 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45390 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbXHEEIs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 00:08:48 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IHXPs-0004Nf-OW; Sun, 05 Aug 2007 00:08:32 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DB6F120FBAE; Sun,  5 Aug 2007 00:08:41 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <87r6miljfr.fsf@catnip.gol.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54933>

Miles Bader <miles@gnu.org> wrote:
> Thanks for the tip (I guess I can roll my own "git-diff-uncached"
> script)!

Indeed, Git is quite scriptable.  ;-)
 
> The above sort of quirkiness does seem kind of a wart though; in my
> (admittedly limited, using git) experience this sort of thing really
> reduces the utility of the index, and I often end up feeling like it's
> just getting in the way as a result.  Does adding something like a
> "git-diff -N" option seem a _bad_ idea?

I'm not interested in such an option.  Typically if I want a
diff on a new untracked file I actually want that file in my next
commit anyway.  So I'm usually staging it into the index along with
everything else that I have modified.  In which case this quirkiness
isn't really a quirk at all.  Its just not an issue to me.

If you want to try adding it, go right ahead.  The source for git
is stored in git and available from many places.  :-)

-- 
Shawn.

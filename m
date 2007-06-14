From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-p4import.py robustness changes
Date: Thu, 14 Jun 2007 01:35:38 -0400
Message-ID: <20070614053538.GA6073@spearce.org>
References: <4ACE2ABC-8D73-4097-87AC-F3B27EDA97DE@slamb.org> <200706031511.31157.simon@lst.de> <20070604055600.GE4507@spearce.org> <200706122347.00696.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Thu Jun 14 07:35:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hyhzp-0006fU-7I
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 07:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbXFNFfq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 01:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbXFNFfq
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 01:35:46 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55438 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbXFNFfp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 01:35:45 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1Hyhzg-0003hv-K6; Thu, 14 Jun 2007 01:35:41 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EBF6620FBAE; Thu, 14 Jun 2007 01:35:38 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200706122347.00696.simon@lst.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50168>

Simon Hausmann <simon@lst.de> wrote:
> I've used git-filter-branch to rewrite the history in fast-export to include 
> only changes relevant to git-p4 and at the same time move all files into 
> contrib/fast-import. The result is available as separate branch at
> 
> 	git://repo.or.cz/fast-export.git git-p4
> 
> and technically merges fine into git.git's contrib/fast-import directory with 
> three files (git-p4, git-p4.txt and git-p4.bat for windows convenience).
> 
> Please let me know if there's anything missing or if you prefer a different 
> format or so. I also realized that I haven't really used the 'Signed-off-by' 
> tags in the past but I'd be happy to adopt it for git inclusion if you prefer 
> that :)

Yes.  The SBO line is your assertion that you own the rights to the
code and can release it under the license you are offering it under.
One of the issues I have with this git-p4 history you have built
is the lack of the SBO line on all 255 commits.

Of course an SBO line doesn't carry that much weight, its just a line
after all, but according to Git's project standards it should be there
if you are agreeing to release it.  See Documentation/SubmittingPatches
for details.

My other problem with this history is a commit like b79112 "a
little bit more convenience" (and there are many such commits).
This message is insanely short, doesn't really talk at all about
what a little bit is, how it is more convenient, or who it is more
convenient for.

Think about how that oneline (and the others) would look in Junio's
"What's new in git.git" emails, or in gitweb.  There is not enough
detail here to be of any value to the reader.  Expanding out to the
full message offers nothing additional either, because that is all
there is in the entire commit message body.

I do appreciate you taking the time to use filter-branch to try to
cleanup this history a bit.  I really had originally planned on
pulling your tree through to my fastimport tree and then talking
Junio into merging with me.  But after reading through this history I
don't want do that, because of the oneline summaries I just pointed
out above, and because of the missing SBO.
 
-- 
Shawn.

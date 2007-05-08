From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Call changes "Staged" and "Unstaged" in file list titles.
Date: Tue, 8 May 2007 10:38:59 -0400
Message-ID: <20070508143859.GO11311@spearce.org>
References: <46405FF2.1B600CBE@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue May 08 16:39:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlQqM-0008VG-Bv
	for gcvg-git@gmane.org; Tue, 08 May 2007 16:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968092AbXEHOjF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 10:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968099AbXEHOjF
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 10:39:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38495 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968092AbXEHOjE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 10:39:04 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HlQq7-0006iP-Se; Tue, 08 May 2007 10:38:55 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5899520FBAE; Tue,  8 May 2007 10:38:59 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <46405FF2.1B600CBE@eudaptics.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46580>

Johannes Sixt <J.Sixt@eudaptics.com> wrote:
> From: Johannes Sixt <johannes.sixt@telecom.at>
> 
> All menu entries talk about "staging" and "unstaging" changes, but the
> titles of the file lists use different wording, which may confuse
> newcomers.
> 
> Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
> ---
> I hope the patch went through without my MUA's "improvements".

Yes.  But...
 
>  git-gui/git-gui.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

That's the wrong path.  Clearly you made this patch in git.git and
not the git-gui.git repository itself.  Fortunately for me I added
-3 to git-am out of habit:

  $ git am -3 -s gg
  Applying 'git-gui: Call changes "Staged" and "Unstaged" in file list titles.'
  
  error: git-gui/git-gui.sh: does not exist in index
  Using index info to reconstruct a base tree...
  Falling back to patching base and 3-way merge...
  Renamed git-gui/git-gui.sh => git-gui.sh
  Wrote tree 8e034a94d9533af707279766e174b78ddf3874cc
  Committed: a1a4975824e8f9f88a8c96ae908c488a2c6047c5

Yay Git!  Go go gadget rename detection!  ;-)

I didn't even realize the git-gui/ prefix on the path in the patch
until after I saw the rename detection message.

-- 
Shawn.

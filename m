From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Update bash completion to ignore some more plumbing commands
Date: Mon, 21 May 2007 02:12:28 -0400
Message-ID: <20070521061228.GJ3141@spearce.org>
References: <20070519213521.GA32221@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Mon May 21 08:12:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq18L-0004T1-2q
	for gcvg-git@gmane.org; Mon, 21 May 2007 08:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754339AbXEUGMf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 02:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754375AbXEUGMf
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 02:12:35 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56636 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754335AbXEUGMf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 02:12:35 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hq18A-0005Qd-5u; Mon, 21 May 2007 02:12:30 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B70E020FBAE; Mon, 21 May 2007 02:12:28 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070519213521.GA32221@diku.dk>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47967>

Jonas Fonseca <fonseca@diku.dk> wrote:
> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
> ---
>  contrib/completion/git-completion.bash |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)

OK, sorry this missed 1.5.2.  I've applied it into my fastimport
master branch, I guess it will be in the next 1.5.2 based release.
;-)
 
>  I am not sure if it is OK to exclude checkout-index as it is
>  the only method of exporting the source as a directory. Also,

It might make sense to exclude checkout-index as plumbing, but I
use it myself so often (and tab complete it too) that I want to
keep it in.  So I deleted that one line out of your patch when I
applied it.

>  I don't understand why git-diff-* is not excluded.

Because I personally also use git diff-tree a lot.  The others
(diff-files, diff-index) I *never* use directly so I'm thinking
maybe they should get flagged as plumbing and get removed from
the completion.

-- 
Shawn.

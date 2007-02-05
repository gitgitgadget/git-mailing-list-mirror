From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: replacing a bad commit
Date: Mon, 5 Feb 2007 15:02:36 -0500
Message-ID: <20070205200236.GB8623@spearce.org>
References: <20070205153949.GT14499@daga.cl> <eq7mf0$lb0$1@sea.gmane.org> <20070205195332.GW14499@daga.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Blu Corater <blu@daga.cl>
X-From: git-owner@vger.kernel.org Mon Feb 05 21:02:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEA39-0005IV-M7
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 21:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933040AbXBEUCs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 15:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933063AbXBEUCs
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 15:02:48 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34392 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933040AbXBEUCr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 15:02:47 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HEA2u-0004ve-PS; Mon, 05 Feb 2007 15:02:37 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9040D20FBAE; Mon,  5 Feb 2007 15:02:36 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070205195332.GW14499@daga.cl>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38777>

Blu Corater <blu@daga.cl> wrote:
> I've got confused by the wording of the git-rebase man page. It says:
> 
>        <upstream>
>           Upstream branch to compare against

Hmm.  Yes, that manpage can be somewhat confusing.
 
> Which suggests to me that <upstream> must be a branch tip, and not a
> random commit, as seems to be the case (well, not random, but reachable
> from <branch> if I understand well). Also, the man page doesn't give any
> example of rebasing using a random commit as <upstream>, they all use
> branch tips which reinforced my wrong assumption.

The faster you abandon the idea of branch tip as argument, the
faster you will pickup the more advanced operations in Git.

Anytime we talk about a branch as input to a command, it can really
be any commit.  And anytime we talk about a commit or an object,
it can be expressed by using any of the operators discussed in
git-rev-parse's man page, which would include using a branch name
or an abbreviated (or full) SHA-1.

There are a limited number of commands which expect a branch name
(and only a branch name), as they modify that branch to contain a
new value.  Examples of these are relatively rare, but include:

  git-branch: the first argument is the name of the branch to create.
  git-checkout -b: again, the name of the branch to create.
  git-fetch: it can be asked to update local tracking branches.

-- 
Shawn.

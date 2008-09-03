From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [JGIT PATCH 2/2] Move pathOf to RepositoryTestCase and use it
	for locating test files
Date: Thu, 4 Sep 2008 01:57:11 +0200
Message-ID: <20080903235711.GA18666@diku.dk>
References: <20080903091022.GC23406@diku.dk> <20080903170904.GB28315@spearce.org> <20080903214818.GB6316@diku.dk> <20080903230216.GI28315@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Imran M Yousuf <imyousuf@smartitengineering.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 04 01:58:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb2Ew-0000uk-Ki
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 01:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbYICX5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 19:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbYICX5O
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 19:57:14 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:35826 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751732AbYICX5O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 19:57:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id BAB1952C3CB;
	Thu,  4 Sep 2008 01:57:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dJruglche4AR; Thu,  4 Sep 2008 01:57:11 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 6A05852C3CA;
	Thu,  4 Sep 2008 01:57:11 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id AB4366DF845; Thu,  4 Sep 2008 01:57:10 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 402B01DE5E2; Thu,  4 Sep 2008 01:57:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080903230216.GI28315@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94873>

Shawn O. Pearce <spearce@spearce.org> wrote Wed, Sep 03, 2008:
> Jonas Fonseca <fonseca@diku.dk> wrote:
> > I think the patch is a nice cleanup, even if it is a workaround.
>
> Its going to cause a merge conflict with Imran's work.  So I was
> hoping to avoid that and just take his stuff.  But if we can't wait
> then yea, it is a nice cleanup patch and is worthwhile bringing in.
> 
> I'll hold onto it for about a day and see if Imran has any comment,
> and merge yours if I don't hear anything tomorrow-ish.

OK, no hurry.

BTW, I have started a JGit tutorial on the EGit wiki. For now it 
mostly consists of stub sections, but I hope to put more work into
it in the days to follow. "Best viewed" via:

 - http://code.google.com/docreader/#p=egit&t=JGitTutorial

Ideas and improvements for the topics and general structure are very
welcome. The structure is given in the TableOfContents page.

 - http://code.google.com/p/egit/wiki/TableOfContents

-- 
Jonas Fonseca

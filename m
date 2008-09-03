From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [JGIT PATCH 2/2] Move pathOf to RepositoryTestCase and use it
	for locating test files
Date: Wed, 3 Sep 2008 23:48:18 +0200
Message-ID: <20080903214818.GB6316@diku.dk>
References: <20080903091022.GC23406@diku.dk> <20080903170904.GB28315@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Imran M Yousuf <imyousuf@smartitengineering.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 03 23:50:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb0Eb-0007we-6y
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 23:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756552AbYICVsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 17:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756520AbYICVsX
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 17:48:23 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:34818 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756508AbYICVsW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 17:48:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 4E3DF19BBC5;
	Wed,  3 Sep 2008 23:48:21 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 09762-06; Wed,  3 Sep 2008 23:48:19 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 0B8E719BBB4;
	Wed,  3 Sep 2008 23:48:19 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 7EB776DF84F; Wed,  3 Sep 2008 23:48:18 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id E62751DE5DE; Wed,  3 Sep 2008 23:48:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080903170904.GB28315@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94858>

Shawn O. Pearce <spearce@spearce.org> wrote Wed, Sep 03, 2008:
> Jonas Fonseca <fonseca@diku.dk> wrote:
> >  This is a workaround patch disguised as a cleanup patch. For NetBeans I
> >  am not yet sure how to setup JGit as a project where everythng works.
> >  For now I need to be able to override the path to files used by the
> >  tests and this patch reduces that change to one single place.
> 
> I wonder if we shouldn't just prod Imran to finish the Maven stuff.
> He has some patches in there that are specifically for this same
> issue under Maven.
> 
>   http://repo.or.cz/w/egit/imyousuf.git?a=shortlog;h=refs/heads/mavenize-jgit

I think the patch is a nice cleanup, even if it is a workaround. But
anything that will help to make the build system more shell friendly is
greatly appreciated.

-- 
Jonas Fonseca

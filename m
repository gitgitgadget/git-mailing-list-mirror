From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 2/2] Move pathOf to RepositoryTestCase and use it
	for locating test files
Date: Wed, 3 Sep 2008 16:02:16 -0700
Message-ID: <20080903230216.GI28315@spearce.org>
References: <20080903091022.GC23406@diku.dk> <20080903170904.GB28315@spearce.org> <20080903214818.GB6316@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Imran M Yousuf <imyousuf@smartitengineering.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Thu Sep 04 01:04:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb1OZ-0004cG-7e
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 01:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783AbYICXCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 19:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752563AbYICXCR
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 19:02:17 -0400
Received: from george.spearce.org ([209.20.77.23]:46638 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639AbYICXCR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 19:02:17 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6B38B38375; Wed,  3 Sep 2008 23:02:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080903214818.GB6316@diku.dk>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94870>

Jonas Fonseca <fonseca@diku.dk> wrote:
> Shawn O. Pearce <spearce@spearce.org> wrote Wed, Sep 03, 2008:
> > Jonas Fonseca <fonseca@diku.dk> wrote:
> > >  This is a workaround patch disguised as a cleanup patch. For NetBeans I
> > >  am not yet sure how to setup JGit as a project where everythng works.
> > >  For now I need to be able to override the path to files used by the
> > >  tests and this patch reduces that change to one single place.
> > 
> > I wonder if we shouldn't just prod Imran to finish the Maven stuff.
> > He has some patches in there that are specifically for this same
> > issue under Maven.
> > 
> >   http://repo.or.cz/w/egit/imyousuf.git?a=shortlog;h=refs/heads/mavenize-jgit
> 
> I think the patch is a nice cleanup, even if it is a workaround. But
> anything that will help to make the build system more shell friendly is
> greatly appreciated.

Its going to cause a merge conflict with Imran's work.  So I was
hoping to avoid that and just take his stuff.  But if we can't wait
then yea, it is a nice cleanup patch and is worthwhile bringing in.

I'll hold onto it for about a day and see if Imran has any comment,
and merge yours if I don't hear anything tomorrow-ish.

-- 
Shawn.

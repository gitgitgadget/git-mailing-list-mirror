From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 2/2] Move pathOf to RepositoryTestCase and use it
	for locating test files
Date: Wed, 3 Sep 2008 20:21:18 -0700
Message-ID: <20080904032118.GA3262@spearce.org>
References: <20080903091022.GC23406@diku.dk> <20080903170904.GB28315@spearce.org> <9e85b2570809031847r34a760ecwea365930327eb205@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonas Fonseca <fonseca@diku.dk>,
	Imran M Yousuf <imyousuf@smartitengineering.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	git@vger.kernel.org
To: Imran M Yousuf <imran@smartitengineering.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 05:22:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb5QQ-0003ds-GP
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 05:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537AbYIDDVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 23:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753528AbYIDDVU
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 23:21:20 -0400
Received: from george.spearce.org ([209.20.77.23]:34645 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498AbYIDDVT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 23:21:19 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id EF98838375; Thu,  4 Sep 2008 03:21:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <9e85b2570809031847r34a760ecwea365930327eb205@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94882>

Imran M Yousuf <imran@smartitengineering.com> wrote:
> On Wed, Sep 3, 2008 at 11:09 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> > Jonas Fonseca <fonseca@diku.dk> wrote:
> >>  This is a workaround patch disguised as a cleanup patch. For NetBeans I
> >>  am not yet sure how to setup JGit as a project where everythng works.
> >>  For now I need to be able to override the path to files used by the
> >>  tests and this patch reduces that change to one single place.
> >
> > I wonder if we shouldn't just prod Imran to finish the Maven stuff.
> > He has some patches in there that are specifically for this same
> > issue under Maven.
> >
> 
> Almighty willing, I will submit my patches this weekend (on Saturday).
> I develop in NetBeans so that would make it easier for sure.

Awesome.  Then I'll hold off on Jonas' patch for now.

-- 
Shawn.

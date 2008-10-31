From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 14:50:41 -0700
Message-ID: <20081031215041.GY14786@spearce.org>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <alpine.LFD.2.00.0810311558540.13034@xanadu.home> <alpine.DEB.1.10.0810311325490.5851@asgard.lang.hm> <alpine.LFD.2.00.0810311651451.13034@xanadu.home> <20081031214356.GX14786@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: david@lang.hm, Pierre Habouzit <madcoder@debian.org>,
	git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 22:51:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw1uO-0003zp-0B
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 22:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbYJaVun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 17:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbYJaVum
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 17:50:42 -0400
Received: from george.spearce.org ([209.20.77.23]:46569 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbYJaVum (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 17:50:42 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A62173835F; Fri, 31 Oct 2008 21:50:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081031214356.GX14786@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99652>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> That said, I think the license choice that makes the most sense
> here is probably LGPL or GPL+gcc exception, like you note below.
> BSD and MIT are probably not serious contenders.

I should clarify that I said the above paragraph...
 
> That said, I think many authors of git.git code would be more
> comfortable with a GPL->LGPL change, where they wouldn't be OK with
> a GPL->BSD/MIT change.  There may be some folks though who still
> wouldn't accept a GPL->LGPL move.

because of this paragraph.

Like Pierre I also prefer a BSD style license, and JGit is under
that, as it offers quite a bit of freedom for the consumer of
the code.

I'm also not too worried about not getting changes back.  If someone
forks away from the base project and doesn't contribute back,
that's their problem.  So long as the base project has sufficient
momentum under it making changes and improving things, everyone
else will want to pull and either face merge-hell once in a while,
or send changes back upstream to avoid merge-hell.

But I doubt Git regulars share our views on this, and I think most
of the major contributors to git.git have stated multiple times
that they prefer a GPL style license on their code.  I want those
people to contribute to libgit2 (assuming the project moves past the
pie-in-the-sky theory stage), so I want the license to be something
they will be comfortable with.
 
-- 
Shawn.

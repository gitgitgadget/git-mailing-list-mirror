From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: blameview and file contents
Date: Tue, 30 Jan 2007 02:29:10 -0500
Message-ID: <20070130072910.GB32640@spearce.org>
References: <cc723f590701292246v282408d0o27a0d8320c027743@mail.gmail.com> <20070130065417.GA32640@spearce.org> <cc723f590701292322q7365f99bg3b7c76834f6fbad8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Aneesh Kumar <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 08:29:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBnQd-0002kK-Gh
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 08:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965398AbXA3H3P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 02:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965412AbXA3H3P
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 02:29:15 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43466 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965398AbXA3H3O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 02:29:14 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HBnQW-00022A-BS; Tue, 30 Jan 2007 02:29:12 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BFB8E20FBAE; Tue, 30 Jan 2007 02:29:10 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <cc723f590701292322q7365f99bg3b7c76834f6fbad8@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38128>

Aneesh Kumar <aneesh.kumar@gmail.com> wrote:
> See i said that there should be a simple way. Can we get this
> documented in git-cat-file man page

Well, this isn't the git-cat-file man page, but we do suggest people
use `git show HEAD:foo.c` to get foo.c from HEAD in an interactive
setting.  The git-show manpage refers people to git-rev-parse,
which has the following:

	* A suffix ':' followed by a path; this names the blob or tree
	  at the given path in the tree-ish object named by the part
	  before the colon.

In a non-interactive case, well, that's what git-cat-file is for.
And <object> typically is meant to mean what git-rev-parse will
parse... 

But if you submit a documentation update to git-cat-file's manpage
that points off to the same section of git-rev-parse, folks may
appreciate it.  :-)

-- 
Shawn.

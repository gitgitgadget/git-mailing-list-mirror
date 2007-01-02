From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Draft v1.5.0 release notes
Date: Tue, 2 Jan 2007 03:23:06 -0500
Message-ID: <20070102082306.GE27690@spearce.org>
References: <7vlkkm47eg.fsf@assigned-by-dhcp.cox.net> <87vejp7v0m.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jan 02 09:23:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1evT-0008KN-Fx
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 09:23:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932977AbXABIXM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 03:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932976AbXABIXM
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 03:23:12 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:51440 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932977AbXABIXM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 03:23:12 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H1evL-0000G2-BI; Tue, 02 Jan 2007 03:23:07 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A0E2620FB65; Tue,  2 Jan 2007 03:23:06 -0500 (EST)
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
Content-Disposition: inline
In-Reply-To: <87vejp7v0m.fsf@morpheus.local>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35780>

David K?gedal <davidk@lysator.liu.se> wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> > * Foreign SCM interfaces
> > 
> >   - git-svn now requires the Perl SVN:: libraries, the
> >     command-line backend was too slow and limited.
> > 
> >   - the 'commit' command has been renamed to 'set-tree', and
> >     'dcommit' is the recommended replacement for day-to-day
> >     work.
> 
> The second item in this list is misleading.  It states that the
> "comit" subcommand has been renamed.  But I don't believe it's the
> "commit" subcommand of the "git" command.  So what is it a subcommand
> to?

git-svn.  As in `git svn commit` is now `git svn set-tree`.

I agree with your point though.  My early readings of the above
quoted section just assumed git-svn, as I knew that was what Junio
was talking about.  Now that I read it again, I have to agree that
it is not quite as clear as I had originally thought.

-- 
Shawn.

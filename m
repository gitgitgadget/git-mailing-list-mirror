From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Mon, 1 Jan 2007 18:17:13 -0800 (PST)
Message-ID: <199618.57093.qm@web31811.mail.mud.yahoo.com>
References: <20070102010816.GB4253@thunk.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue Jan 02 03:17:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1ZDT-0006qM-28
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 03:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804AbXABCRO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 21:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754803AbXABCRO
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 21:17:14 -0500
Received: from web31811.mail.mud.yahoo.com ([68.142.207.74]:34991 "HELO
	web31811.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754804AbXABCRN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jan 2007 21:17:13 -0500
Received: (qmail 59142 invoked by uid 60001); 2 Jan 2007 02:17:13 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=OtlUwPOgiygT248Wgmyyf2P9gTBJCBPjtCB/sYLRR2tg/yEcr4zmXI5+GX/TY8Bvu58oNeoxKwpI7pPAZuCCBEKf7/vu+JPn52oPtKDlL7ndp5WFA1UFpKeYtmeL5nz2NvuQCoWnOh1G42+iV6vQ//yljtN19VXXm14Lp/mW38A=;
X-YMail-OSG: G5A88XwVM1m_z.5y_Kjhx8q5NVREIuqWFFc5RT2G4sTw85fWwGqW8DcKl7ft7_gquRw60bKeP6TT.vYpvP9vykSi4eVf8zO1LfzCPQsD0bWA4gxhMfMCCTSqAWck_Sc3Lgi_D5WctldDvEbg4iumUu_FZzwrqEam5ntM_MxKOc4yIwmdwlypEQxE
Received: from [71.84.31.238] by web31811.mail.mud.yahoo.com via HTTP; Mon, 01 Jan 2007 18:17:13 PST
To: Theodore Tso <tytso@mit.edu>
In-Reply-To: <20070102010816.GB4253@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35763>

--- Theodore Tso <tytso@mit.edu> wrote:
> Well, yes; since git-pull is implemented in terms of git-fetch
> followed by a git-merge, that's why I talked about git-fetch.  It is
> git-fetch which uses remote.<non-URL>.{url,fetch}, not git-merge or
> git-pull (since it just passes those arguments over to git-fetch).
> 
> > More specifically,
> > branch.<branch-match>.<symbolic-ref match>.{fetch,merge}.
> 
> What do you mean by <branch-match> and <symbolic-ref match>?
> 
> Are you assuming some kind of glob match?  If so, what are the
> specific rules of the match that you are proposing?

Yes. I've outlined them at least twice in this thread
already as well as in that same email of mine which you're replying
to, which I'm replying to.

> > branch.<branch-match>..{fetch,merge} is allowed and defalts
> > to already implemented "git-pull".
> 
> What do you mean by ".." here?   

I mean "git-pull", as opposed to "git-pull <symbolic-ref>".

I.e. "branch.<branch-match>..{fetch,merge}" matches no symbolic
ref given, exactly what it defines.

> > Think of "git-pull", not just of "git-fetch".  As well as think
> > of a setup where there are more than one branch implementing
> > software dependency, resolving to a software product.
> 
> git-pull is implemented in terms of git-fetch.  So if we make the
> change to git-fetch, the changes naturally follow to git-pull.  Or are
> you proposing to change that?

No, not at all.

Please see my last email to Junio in this thread.  Depending on
how this new functionlity is implemented for git 1.5, the concept
of "branch spec" can be had by using a "dummy" [remote] spec,
used only as a command line match, and specifying the merge
dependency in the [branch] spec, refering to "remote" and
identifying what to merge.  See that email please.

    Luben

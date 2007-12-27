From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Force new line at end of commit message
Date: Wed, 26 Dec 2007 23:19:02 -0500
Message-ID: <20071227041902.GR14735@spearce.org>
References: <87ve6ub3u7.fsf@gollum.intra.norang.ca> <8763yof9lg.fsf@gollum.intra.norang.ca> <Pine.LNX.4.64.0712241835210.14355@wbgn129.biozentrum.uni-wuerzburg.de> <20071225044202.GO14735@spearce.org> <87myrxqrev.fsf@gollum.intra.norang.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bernt Hansen <bernt@alumni.uwaterloo.ca>
X-From: git-owner@vger.kernel.org Thu Dec 27 05:19:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J7kDb-0004Gy-7o
	for gcvg-git-2@gmane.org; Thu, 27 Dec 2007 05:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbXL0ETK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2007 23:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbXL0ETJ
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Dec 2007 23:19:09 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56332 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbXL0ETI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2007 23:19:08 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1J7kD0-0004Tw-02; Wed, 26 Dec 2007 23:19:02 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D37A920FBAE; Wed, 26 Dec 2007 23:19:02 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <87myrxqrev.fsf@gollum.intra.norang.ca>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69257>

Bernt Hansen <bernt@alumni.uwaterloo.ca> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> >
> > its clear in both the email and in the commit log that the change is
> > a git-gui change.  Remember, git-gui's logs show up in the core Git
> > logs (as its merged with -s subtree) so having that git-gui: prefix
> > does help people to localize the change within the overall suite.
> 
> This is my first attempt at creating a patch for git (even if it is
> mostly trivial in this case) and I wasn't aware of the git-gui.gitk repo
> and conventions regarding the commit message.  I just tried to follow
> what was in Documentation/SubmittingPatches.  I'll try to do better next
> time :)

Its a good first attempt.  I also just sent a patch to Junio to try
and make this "special case" of directing git-gui changes to me more
clear for new folk.
 
> Forcing a LF on the end of the commit message feels wrong to me too.

I think Junio just convinced me otherwise.

We probably should change git-gui to always end the last line of
the message with an LF.  To be honest I'm not really sure why it
doesn't do that now.  ;-)
 
> The patch as it stands should probably not be applied.

But I think that is now only because the commit message could be
clarified to state that its for git-gui (e.g. start with "git-gui:")
and probably shouldn't be so specific to rebase -i's breakage but
instead talk about how its good to be strict in what you create,
and lenient in what you accept, and since we're creating here,
we should always try to Do The Right Thing(tm).

If you respin the patch with a more descriptive message I'll put
it into 0.9.1.

-- 
Shawn.

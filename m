From: Joseph Wakeling <joseph.wakeling@webdrake.net>
Subject: Re: Effectively tracing project contributions with git
Date: Sun, 13 Sep 2009 02:03:33 +0200
Message-ID: <4AAC36D5.1040901@webdrake.net>
References: <4AAB9459.3070809@webdrake.net> <20090912185940.GA21277@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 13 02:05:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmcbG-0004Ff-Sv
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 02:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbZIMADb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 20:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbZIMADa
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 20:03:30 -0400
Received: from up.nbi.dk ([130.225.212.6]:54106 "EHLO mail2.nbi.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751393AbZIMAD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 20:03:29 -0400
Received: from [192.168.0.4] (zux221-207-155.adsl.green.ch [81.221.207.155])
	by mail2.nbi.dk (Postfix) with ESMTP id DFCE93C930;
	Sun, 13 Sep 2009 02:03:31 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <20090912185940.GA21277@coredump.intra.peff.net>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128316>

Jeff King wrote:
> We can probably help you with the git side of things, but defining "who
> contributed what" is kind of a hairy problem. You will need to define
> exactly how you want to count contributions.

Yes, that's pretty much what I'm looking for.  My thoughts on
contribution run along much the same lines as yours -- there's a need to
distinguish between meaningful additions and mere tweaks.

My general rule is that stuff like whitespace changes, changing the name
of variables, typo corrections etc. is not a meaningful contribution
although if someone had really done a lot of it I might see things
differently.  Substantial additions -- extending the code, comments or
documentation -- are what I'm after.  Ultimately this has to be decided
by me actually looking at things rather than metrics.

What I'm doing right now is to run a git shortlog on a file to get a
rough idea of the contributors and who are likely to be the main
authors, then using gitk to browse the commits for that file.  It's
time-consuming but works -- once I've identified at least one major
commit from someone I can ignore everything else by them and concentrate
on the remaining contributors.

What would help is some way to speed up the process of getting someone's
commits: 'give me all the diffs for file X by author Y'.  I'm not too
good at shell scripting so grep-y things don't spring easily to mind.

An alternative useful tool would be 'give me all the commits to this
file that change more than N lines'.

With those two -- particularly the first -- I think I'd be able to get a
fair way.  It won't work for the files where there has been a lot of
moving of content or renames, but that's mostly in the docs -- the code,
which is the really important thing, doesn't seem so bad (so far).

Thanks very much for the advice and careful thoughts,

Best wishes,

    -- Joe

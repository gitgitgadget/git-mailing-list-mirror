X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: linux@horizon.com
Subject: Re: [DRAFT] Branching and merging with git
Date: 17 Nov 2006 19:13:55 -0500
Message-ID: <20061118001355.23488.qmail@science.horizon.com>
References: <20061117182157.GC11882@fieldses.org>
NNTP-Posting-Date: Sat, 18 Nov 2006 00:14:35 +0000 (UTC)
Cc: git@vger.kernel.org, linux@horizon.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061117182157.GC11882@fieldses.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31740>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlDqo-0008N4-3s for gcvg-git@gmane.org; Sat, 18 Nov
 2006 01:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756088AbWKRAN6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 19:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756089AbWKRAN6
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 19:13:58 -0500
Received: from science.horizon.com ([192.35.100.1]:36423 "HELO
 science.horizon.com") by vger.kernel.org with SMTP id S1756088AbWKRAN5 (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 19:13:57 -0500
Received: (qmail 23489 invoked by uid 1000); 17 Nov 2006 19:13:55 -0500
To: bfields@fieldses.org, tytso@mit.edu
Sender: git-owner@vger.kernel.org

I'm working on incorporating all of the comments I've received, so
thank you all!

(BTW, the reason I didn't document git-describe is that I didn't
know about it!  You fixed the latter, so I'll fix the former.)


I'm glad if others like it, but I was really scratching my own
itch.  I'm still wrapping my head around how to work with git, and
writing this was my own learning experience.

Even writing it out in full rather than as rougher notes wasn't
an entirely unselfish act; it ensures:
1) I don't leave some important assumption unstated; that's the
   type most likely to be wrong, and
2) If I can get it good enough to post publicly, I'll get all the
   experts to fact-check it for me.


As for the target audience, it's basically someone who's read git(1)
and knows what a VCS is supposed to do, but has a CVS/SVN mindset.
The emphasis is on branching and merging because that's the big
"mental mode" difference in the way that git works.


For anyone else documenting git, I recommend describing "what if I
make a mistake" early.  It was a bit of a revelation to realize
that there's not much point to "git pull --no-commit" because
it's so easy to undo.


Just a couple of questions:

We seem to have developed a consensus on the desirability of allowing
HEAD to point outside refs/heads, postponing the check until
commit/merge time.  (At least, junkio and Linus seemed to like it.)

I proposed it, so I get to write it, but you notice I have a whole
section on how to work around the lack of that feature, so if someone
feels like picking up the baton while I'm still writing docs, it would
simplify things.


I'd like to learn more about the zillion options to git-log.
If people feel like sharing useful incantations, it would be
be very helpful to give a concrete example of its usefulness,
preferably within the git history itself.

(Are there any octopus merges in git's history?  If not, could I ask

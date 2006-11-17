X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: linux@horizon.com
Subject: Re: multi-project repos (was Re: Cleaning up git user-interface
Date: 17 Nov 2006 00:11:57 -0500
Message-ID: <20061117051157.27896.qmail@science.horizon.com>
NNTP-Posting-Date: Fri, 17 Nov 2006 05:12:08 +0000 (UTC)
Cc: git@vger.kernel.org, linux@horizon.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31664>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkw1E-0005EO-6m for gcvg-git@gmane.org; Fri, 17 Nov
 2006 06:12:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031209AbWKQFL7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 00:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031210AbWKQFL7
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 00:11:59 -0500
Received: from science.horizon.com ([192.35.100.1]:57412 "HELO
 science.horizon.com") by vger.kernel.org with SMTP id S1031209AbWKQFL6 (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 00:11:58 -0500
Received: (qmail 27897 invoked by uid 1000); 17 Nov 2006 00:11:57 -0500
To: hanwen@xs4all.nl
Sender: git-owner@vger.kernel.org

>> A lot of the complaints seem to not be about the interfaces, but about 
>> people not _understanding_ and knowing what the interfaces do. If you were 

> From the point of view of a user, there is not really a difference
> between the two.  As a user, you form a mental model of how things
> work by looking at the interface.  If the interface is bad, the user
> creates a faulty model in his head, and starts doing things that
> are perfectly logical in the faulty model, but stupid and silly when
> you consider the actual internals.

"The only intuitive user interface is the nipple; all else is learned."

As Linus is explaining, the fundamental *problem* is the mental model.
Once you know how to break your goals apart into the right kind of pieces,
little things like terminology are truly little.

I'm not sure that git is sufficiently like anything else that a few
well-chosen command names can bring a good analogy to mind.  There just
isn't a simple analogy that won't lead you astray; you have to understand
the thing on its own terms.

How do you explain the point of an electric screwdriver to someone who's
never seen a screw?  He'll think it's a silly way to wind up yarn.


I'll be the first to explain that the git docs have some major problems.
"git show" is a really useful command.  It has a zillion options to do
cool things.  Have you read the man page?

Didn't take long, did it?  "git log" is even more powerful, and almost
as bad.  The information is all available, it's just on the plumbing
man pages.

And I even understand *why* it's there.  Because writing the plumbing is
when the coders were thinking about the problem.  And writing good docs
is very simple: when you learn something, write it down.  Not later,
or next week, but right now, when you still remember how confused you
were before and what led you to the revelation.

The only problem, for a person looking at it top-down, is that git was
written bottom-up, so the bottom is very well documented, and once you
understand that, the top is pretty obvious and trivial.

But if you want to improve the situation for someone like yourself,
the solution is the same: when you learn something non-trivial, write
it down.  Not later, after you've finished learning, but right now when
you still remember the process of learning.

Now, when you show people what you wrote, one of two things will
happen:
1) They'll say "thank you, that's a good way of looking at it", or
2) They'll say, "that's not quite right; the truth is actually...".
   The second case means that you have a bit more to learn.
   But by taking the first step, you've given the learning process
   some momentum.  It gets easier after that.

I hope my recent postings ([DRAFT] Branching and merging with git)
form a reasonable example of that.


There are a few key concepts in the git tools.  I don't care if
"git-rev-list" is an ugly name; the name isn't learly as important as
realizing that *every* command that works on a list of commits uses
the same primitive, and what you learn about one command in that family

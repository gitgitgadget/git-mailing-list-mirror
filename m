From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: What is missing from Git v2.0
Date: Fri, 25 Apr 2014 10:40:54 -0400
Message-ID: <20140425144054.GA6230@thunk.org>
References: <5358bae8ab550_1f7b143d31037@nysa.notmuch>
 <877g6fb2h6.fsf@fencepost.gnu.org>
 <5358ca1a55a69_1f7b143d3101c@nysa.notmuch>
 <20140424134106.GA27035@thunk.org>
 <20140424195559.GA1336@luc-arch>
 <CALZVapn0gEHc7t2fjk7YGd2o0yfpGLu0JCgUtdREvROC8_mqXg@mail.gmail.com>
 <5359c9d612298_771c15f72f02a@nysa.notmuch>
 <CAGK7Mr6dss7BF-srQ3SqeZe2hAe9nS07fGe--ka1rvC5hXvbSA@mail.gmail.com>
 <20140425133520.GC11124@thunk.org>
 <CAGK7Mr4g3j80R4P_wpfNip9vxvaDg4q_3Utq9KVvKtbdhVutfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Javier Domingo Cansino <javierdo1@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 16:41:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdhJH-0004yB-TI
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 16:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbaDYOk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 10:40:58 -0400
Received: from imap.thunk.org ([74.207.234.97]:32863 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750844AbaDYOk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 10:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=TGkgvQiBh60SsOmxRoRzhxQKfc6piftDfwcTtK9sjNM=;
	b=mNNMmTVT8SoAxC018oT49wh5PuqRkvD3asgNfNVwYvLJ9xztUGzbngwKv1VZVIFWGgI6NKo7E2MIXFk9JjOrQU/lH4/BZZ1YdmvOcOKfUXe/A/u5UALlpSzFglwAnSXXnppFGVCJzRjgNQ4JitBboVMvBUrF8xPoQdwX0EUpAGA=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.80)
	(envelope-from <tytso@thunk.org>)
	id 1WdhJ9-0003dD-Hj; Fri, 25 Apr 2014 14:40:55 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 910C25804B7; Fri, 25 Apr 2014 10:40:54 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAGK7Mr4g3j80R4P_wpfNip9vxvaDg4q_3Utq9KVvKtbdhVutfQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247042>

On Fri, Apr 25, 2014 at 04:23:43PM +0200, Philippe Vaucher wrote:
> 
> I agree, but I think it's better than "index" tho. That one is heavily
> overloaded and easily confused with other meaning in other softwares.

There is a big difference between being used in a difference sense
than other software --- there is a one-time learning curve after which
point people can generally understand that a term in a given context
has a single meaning --- and when we have two very easily confused
terms (i.e., "stage versus staged") or a single identical term,
overloaded within a single context.  So I'm much more worried about
the git documentation using the same term or two closely related terms
in an overloaded fashion, much more than I am with "index" meaning one
thing for databases, and another thing for book publishers, and yet
another for compilers.

> Yes, of course there should be a list of both positive and negative
> tradeoffs. But I think the "overloaded" argument can be easily solved
> by renaming one of the overloads.

And renaming one of a term also has costs, especially if it is one
that is in use in large amounts of documentation, both in the git man
pages, and in web pages across the web.

And my plea for data extends even here.  For example, things like
this:

www.google.com/trends/explore#q=git%20staging%20area%2C%20git%20index&cmpt=q

> Unfortunately yes, I see many people being silly in order to win
> arguments, both in the pro-changes and against-changes side of the
> discussion. I'd be much simpler to simply gather arguments on some
> wiki and eventually do a vote when the list is complete about the
> proposed change.

Voting is not a good way to do software development.  That way lies
people wanting to whip up clueless folks using rhetoric (exhibit one:
Fox News) to "vote" and so it's not necessarily the best way to make
thoughtful decisions.  Using hard data, including possibly formal UX
experiments, is a much better way to make such decisions.

Cheers,

						- Ted

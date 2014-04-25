From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: What is missing from Git v2.0
Date: Fri, 25 Apr 2014 09:35:20 -0400
Message-ID: <20140425133520.GC11124@thunk.org>
References: <53588f448d817_59ed83d3084e@nysa.notmuch>
 <CAHYYfeFKW93GH+6-ssR5L_uoo3OL2-LFAsj-4+8uEmL0BhT3ow@mail.gmail.com>
 <5358bae8ab550_1f7b143d31037@nysa.notmuch>
 <877g6fb2h6.fsf@fencepost.gnu.org>
 <5358ca1a55a69_1f7b143d3101c@nysa.notmuch>
 <20140424134106.GA27035@thunk.org>
 <20140424195559.GA1336@luc-arch>
 <CALZVapn0gEHc7t2fjk7YGd2o0yfpGLu0JCgUtdREvROC8_mqXg@mail.gmail.com>
 <5359c9d612298_771c15f72f02a@nysa.notmuch>
 <CAGK7Mr6dss7BF-srQ3SqeZe2hAe9nS07fGe--ka1rvC5hXvbSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Javier Domingo Cansino <javierdo1@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 15:35:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdgHv-0006Gf-8y
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 15:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbaDYNf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 09:35:26 -0400
Received: from imap.thunk.org ([74.207.234.97]:60915 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbaDYNfX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 09:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=S8/zFbhWdyVtTNL7ACl+6tGMuxlJqPm/GpsyA/8hFFI=;
	b=lyK8jVqRjBj8Q+JwcjSs7pMz4VVWs7brcLNkMDGB9hqJ6ZTSYE76gIIZewNUrkOH86m4N3k8FuY/+W90oZeL5/FJyXskCRDwM5QPYzMn2vLe1o6CybP6BRc6QePB2n0kZsSxp8Bo6FMNpH18TK3NAYfqn/hHPuCi2Sx9ovx9ECA=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.80)
	(envelope-from <tytso@thunk.org>)
	id 1WdgHh-00037r-SB; Fri, 25 Apr 2014 13:35:21 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 0FE215804B7; Fri, 25 Apr 2014 09:35:21 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAGK7Mr6dss7BF-srQ3SqeZe2hAe9nS07fGe--ka1rvC5hXvbSA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247040>

On Fri, Apr 25, 2014 at 09:48:53AM +0200, Philippe Vaucher wrote:
> 
> I agree. The "stage area" is a very important concept in git, why not
> talk git commands that refers to it? Then we could add flags like
> --new-files or --deleted-files for better granularity than the current
> --all flag.

One caution: The term "stage/staged" is already a little overloaded.
We generally use the word "staged" to refer to changes that are in the
index, but the term "stage" as a noun generally refers to referencing
the different versions of a file during a merge operation (cf "git
ls-files --stage").

> I think starting by documenting the issues is a good idea, maybe on a
> wiki, and start some draft of a proposed solution that would improve
> in an iterative process.

And it would be nice if the issues were discussed in a way that
acknowledged that all changes have tradeoffs, both positive and
negative, and to clearly articulate whether the concern is just
someone going "uh, 'index' is a wierd term", but once they learn it,
it's pretty clear, versus a case where there is continuous confusion
due to overloaded meanings, or for people for whom English might not
be the first language.

And most importantly, to avoid rheteroic.  In fact, given that strong
use of rhetoric is often used to disguise a weakness of a position
that can't be defended using logic and data, someone who tries to win
arguments using the "last post wins" style of discourse, and a heavy
use of rhetoric, may find that people just simply decide that it's a
better use of their time not to engage and to just kill the entire
thread.

Regards,

						- Ted

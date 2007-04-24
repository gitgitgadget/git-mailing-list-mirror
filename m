From: Junio C Hamano <junkio@cox.net>
Subject: Re: git todo-list ?
Date: Tue, 24 Apr 2007 03:33:37 -0700
Message-ID: <7virbm6ozi.fsf@assigned-by-dhcp.cox.net>
References: <f36b08ee0704231544r53d1bfbej7ddee0c66d894f3c@mail.gmail.com>
	<7vlkgid7x4.fsf@assigned-by-dhcp.cox.net>
	<7vslaqbnhq.fsf@assigned-by-dhcp.cox.net>
	<200704240823.00515.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Yakov Lerner" <iler.ml@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 12:33:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgILA-0006eg-7t
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 12:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624AbXDXKdk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 06:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754625AbXDXKdk
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 06:33:40 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:33183 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754624AbXDXKdj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 06:33:39 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070424103339.YDUX1235.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 24 Apr 2007 06:33:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id qyZd1W00A1kojtg0000000; Tue, 24 Apr 2007 06:33:39 -0400
In-Reply-To: <200704240823.00515.andyparkins@gmail.com> (Andy Parkins's
	message of "Tue, 24 Apr 2007 08:22:59 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45440>

Andy Parkins <andyparkins@gmail.com> writes:

> My own recommendation for this page - or in fact any similar list - is don't 
> bother - let's delete it or replace it with a link to Junio's email.

I wouldn't dismiss it that fast.  Replacing it with a notice
that says the community is looking for a volunteer (or group of
volunteers) who is willing to invest the time and effort to keep
it up to date would be very good, though.

I miss "kernel traffic" and its cousen "git traffic" (which we
saw only the first issue of, unfortunately).  FWIW, until very
recently, your "niggles" list $gmane/34244 was still kept in my
box as 'ticked'.  I recently unticked it as many of the issues
there have been resolved and some have been made irrelevant.

If somebody sent such a list (maybe starting with only his own
"niggles" list) and posted it to the list bi-weekly (with a good
maintenance -- removing stale items from such a list is often
much more important than adding newly raised issues to keep it
useful), that would be a great contribution to the community.
Interested people could even take turns to be the list editor.

> The way to get new features into git seems to be either
>  a. Do it yourself
>  b. Mention it (but not excessively) on the mailing list, if one of the guru's
>     is interested enough to do it (their choice not yours), then you're in.  
>     Otherwise - see (a).

I would say that is true for almost any project in the free
software world.  Also I would not state b. with word "guru".
You either do it yourself, or find people who can, and tempt
them do it for you.  And "people who can" do not have to be
necessarily gurus.

A good strategy to do b. is to demonstrate the need in concrete
terms; post your attempt at the problem, even though it may not
be elegant or inclusion quality, and explain what you are trying
to achieve.  Code, sample output, or even imaginary transcript
is worth thousands words to explain what you are trying to do.
Then, describe how much your attempt solves and what you find
lacking in it (iow what more is needed in the output from your
failed attempt to make you happy).

This has three possible outcome.  (1) Somebody might do it; (2)
Somebody might do it better than you imagined possible; (3)
Somebody might explain why it is a bad approach to do the way
you described, make you realize that what you initially thought
was "the need" was merely one possible approach (and not optimal
one) to solve a higher level problem you were ultimately trying
to solve, and teach you a better way to solve that problem.

On the other hand, a poor strategy is to say things like these:

 - Other system X does it.

   (If you are content with system X, we are happy.  We won't
   force you to use git and suffer from the lack of that
   feature.)

 - You would want more users, wouldn't you?

   (Not necessarily.  World domination might happen as a side
   effect of being the best system in the field, but it is not
   our goal by itself.)

 - Our project cannot use git unless you have this and that.

   (Tough.)       

without saying "if we had this, git can be more useful in such
and such scenario, and it is applicable not only this situation
but here and there."

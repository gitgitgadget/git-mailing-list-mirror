From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] user-manual.txt: fix a few mistakes
Date: Thu, 15 Nov 2007 22:54:16 -0500
Message-ID: <20071116035416.GF18909@fieldses.org>
References: <87bq9x7w4d.fsf@osv.gnss.ru> <20071114181858.GH14254@fieldses.org> <87lk8z3idj.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 04:54:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IssHz-0006E5-B0
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 04:54:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759354AbXKPDyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 22:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759473AbXKPDyT
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 22:54:19 -0500
Received: from mail.fieldses.org ([66.93.2.214]:33678 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759354AbXKPDyS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 22:54:18 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1IssHY-0005sT-Ip; Thu, 15 Nov 2007 22:54:16 -0500
Content-Disposition: inline
In-Reply-To: <87lk8z3idj.fsf@osv.gnss.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65186>

On Thu, Nov 15, 2007 at 01:36:40PM +0300, Sergei Organov wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> 
> > On Tue, Nov 13, 2007 at 09:19:39PM +0300, Sergei Organov wrote:
> >> 
> >> Signed-off-by: Sergei Organov <osv@javad.com>
> >> ---
> >>  Documentation/user-manual.txt |    8 ++++----
> >>  1 files changed, 4 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> >> index d99adc6..a169ef0 100644
> >> --- a/Documentation/user-manual.txt
> >> +++ b/Documentation/user-manual.txt
> >> @@ -475,7 +475,7 @@ Bisecting: 3537 revisions left to test after this
> >>  If you run "git branch" at this point, you'll see that git has
> >>  temporarily moved you to a new branch named "bisect".  This branch
> >>  points to a commit (with commit id 65934...) that is reachable from
> >> -v2.6.19 but not from v2.6.18.  Compile and test it, and see whether
> >> +"master" but not from v2.6.18.  Compile and test it, and see whether
> >>  it crashes.  Assume it does crash.  Then:
> >>  
> >>  -------------------------------------------------
> >> @@ -1367,7 +1367,7 @@ If you make a commit that you later wish you hadn't, there are two
> >>  fundamentally different ways to fix the problem:
> >>  
> >>  	1. You can create a new commit that undoes whatever was done
> >> -	by the previous commit.  This is the correct thing if your
> >> +	by the old commit.  This is the correct thing if your
> >>  	mistake has already been made public.
> >>  
> >>  	2. You can go back and modify the old commit.  You should
> >> @@ -1567,8 +1567,8 @@ old history using, for example,
> >>  $ git log master@{1}
> >>  -------------------------------------------------
> >>  
> >> -This lists the commits reachable from the previous version of the head.
> >> -This syntax can be used to with any git command that accepts a commit,
> >
> > I actually prefer "head" here.  On something like:
> >
> > 		 A--B--C
> > 		/
> > 	o--o--o
> > 		\
> > 		 o--o--o
> >
> >
> > The term "branch" could be used to refer to the whole line of
> > development consisting of A, B, and C.  The term "head", on the other
> > hand, refers to either C or a ref that points to it.  We also use the
> > terms "branch head" or just "branch" for that case, but I think "head"
> > is more precise.
> 
> Then I'd suggest to be precise here, e.g.:
> 
> "This lists the commits reachable from the previous version of the
> "master" branch head."

That sounds sensible to me, sure.

> 
> The real reason for me to replacing "head" with "branch" in the first
> place was that a few lines below there is example for HEAD, and I wanted
> to make it more obvious that those is entirely different.

OK, sure.  Thanks for the thoughtful editing!

--b.

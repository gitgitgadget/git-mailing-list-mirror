From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Merging commits together into a super-commit
Date: Thu, 10 May 2007 13:14:57 -0400
Message-ID: <20070510171457.GK13719@fieldses.org>
References: <1178794261.5806.98.camel@murta.transitives.com> <4643049C.3D5F30D8@eudaptics.com> <alpine.LFD.0.98.0705100857450.3986@woody.linux-foundation.org> <87wszg39cp.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Thu May 10 19:15:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmCEO-0000FP-MA
	for gcvg-git@gmane.org; Thu, 10 May 2007 19:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755179AbXEJRPE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 13:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755428AbXEJRPD
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 13:15:03 -0400
Received: from mail.fieldses.org ([66.93.2.214]:36999 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755179AbXEJRPD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 13:15:03 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HmCED-00067X-3s; Thu, 10 May 2007 13:14:57 -0400
Content-Disposition: inline
In-Reply-To: <87wszg39cp.wl%cworth@cworth.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46880>

On Thu, May 10, 2007 at 09:57:10AM -0700, Carl Worth wrote:
> I'm sure the most complex form of git-rebase solves some precise
> problem that someone has, (and maybe even gets used regularly). But
> it's got enough complications that I just ignore it, (and would
> instead really prefer being able to just cherry-pick a whole range).

I use it all the time to fix up old commits with

	git checkout sha1-of-bad-commit
	...edit, test,...
	git commit -a ---amend
	git rebase --onto HEAD sha1-of-bad-commit original-branch

But though it usually does what I want, I'm in total agreement about the
confusing syntax and branch-switching behavior....

--b.

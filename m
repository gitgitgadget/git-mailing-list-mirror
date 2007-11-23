From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Reordering lines in "git-rebase -i" task sheet
Date: Fri, 23 Nov 2007 08:54:38 +0000
Message-ID: <fi64ge$u1g$1@ger.gmane.org>
References: <7vlk8q7hzg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 09:55:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvUJX-0003mQ-Ar
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 09:55:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292AbXKWIyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 03:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752750AbXKWIyt
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 03:54:49 -0500
Received: from main.gmane.org ([80.91.229.2]:43128 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751813AbXKWIys (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 03:54:48 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IvUJB-0001h2-Ft
	for git@vger.kernel.org; Fri, 23 Nov 2007 08:54:45 +0000
Received: from 194.70.53.227 ([194.70.53.227])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Nov 2007 08:54:45 +0000
Received: from andyparkins by 194.70.53.227 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Nov 2007 08:54:45 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 194.70.53.227
User-Agent: KNode/0.10.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65877>

Junio C Hamano wrote:

> Could we please reorder the lines so that list of initial
> "pick"s come first and have the help comment lines at the very
> end?

I'm not convinced that this is a great idea.

Mostly with git-rebase -i one is reordering the most recent commits, which
are at the bottom.  Personally, I am often reordering commits that are as
yet unpushed, so for ease-of-thinking I type

 git rebase -i origin/master

again and again.   Hence the early lines are probably already sorted into a
nice order and it's commits at the bottom of the list that need a bit of
massaging.

At present it's easy to get to them because a shift-G or ctrl-end, or
$END_OF_FILE takes you there.   With the above change it's now more steps
to move to the interesting part.

Now if you were suggesting flipping the sort direction at the same time, I
could get on board - but that is perhaps one confusing step too far.

> That is the reason why git commit leaves the first line empty in
> its initial template.  It is to allow the user to immediately
> start typing.

That's different, for a commit message, the first line is exactly where one
would want to be.

Not a strong objection.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com

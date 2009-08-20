From: ib@wupperonline.de (Ingo Brueckl)
Subject: question concerning branches
Date: Thu, 20 Aug 2009 14:46:00 +0200
Message-ID: <4a8d4583@wupperonline.de>
References: <alpine.LFD.2.01.0908191441070.3158@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 20 14:53:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me78n-0006Qd-06
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 14:53:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754171AbZHTMxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 08:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754066AbZHTMxF
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 08:53:05 -0400
Received: from smtp.tal.de ([81.92.1.5]:51654 "EHLO smtp.tal.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753648AbZHTMxF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 08:53:05 -0400
Received: from ib (unknown [89.244.106.248])
	by smtp.tal.de (Postfix) with SMTP id 7ABC9AC605E;
	Thu, 20 Aug 2009 14:53:05 +0200 (CEST)
X-Mailer: blueMail 1.4 (SlipDoor 2.2)
In-Reply-To: <alpine.LFD.2.01.0908191441070.3158@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126618>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> branches have always been pointers to the top-of-commit

Obviously I expected them to be pointers on trees.

A kind of automatical starting commit in a newly created branch would at
least warn if one has begun changing files and wants to checkout back.
(Is this a feature worth of discussion?)

> the git behavior explicitly _encourages_ you to not have to decide
> before-the-fact to create a branch

Thanks for the explanation which help me to understand why git works like it
does.

I'm able to follow your examples, but what I had it mind when I started the
topic and my example was:

Assume a project is released (i.e. no more open bugs we know about) - I know
we're drifting towards fantasy now. ;-)

On the one hand, I want to add single new features (such as other developers
do) which will be written, tested and committed. I want to push/pull
frequently to be up to date all the time. (master branch)

On the other hand, I want to completely rewrite the core of the program.
(test or rewrite branch)

What is the git way to do this in a the right (and clever) manner?

In a branch, I learned, I have to commit or stash before I return to master
for push/pull to follow the project. If I forget, I'm screwed, because files
have changed due to the rewrite (in that branch), I won't get a warning until
my first commit (in that branch) and commits (in master) will conflict.

Ingo

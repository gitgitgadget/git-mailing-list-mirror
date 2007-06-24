From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Darcs
Date: Sun, 24 Jun 2007 10:59:52 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706241030540.3593@woody.linux-foundation.org>
References: <cecbdd220706232232w77a609faxf0e6b2dc37f0d1f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Bu Bacoo <bubacoo@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 20:00:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2WOM-0004Xm-FC
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 20:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbXFXSAZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 14:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbXFXSAB
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 14:00:01 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39481 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751433AbXFXSAA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jun 2007 14:00:00 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5OHxvEg027396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 24 Jun 2007 10:59:58 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5OHxqA7018582;
	Sun, 24 Jun 2007 10:59:52 -0700
In-Reply-To: <cecbdd220706232232w77a609faxf0e6b2dc37f0d1f4@mail.gmail.com>
X-Spam-Status: No, hits=-2.562 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50809>



On Sun, 24 Jun 2007, Bu Bacoo wrote:
> 
> What do you think about darcs?
> 
> There was a lot written/spoken about morons and stupidos around
> thinking in cvs / svn, etc... (what would be the words for dudes
> around vss ....).

Ahh, a chance to flame! I will never back down from such a challenge!

Darcs is .. umm .. ehh..

"Academic".

Ok, I realize that's a pretty weak flame, and I'm sorry. It's not that 
darcs users are "stupid" or "complete morons" or "donkey turds with arms 
and legs", it's just that the whole project is centered around some 
academic ideas that have absolutely no relevance in real life, and that 
just don't work in practice.

In other words, it's a fun project, but it's largely irrelevant. The whole 
underpinning of darcs ("everything is a collection of patches" and the 
"patch algebra") is kind of interesting, but it's irrelevant. The thing it 
solves is not the thing you want solved, and you really don't want to 
handle conflicts at a "patch" level.

I personally think darcs is closer to a smart "quilt" than a "final" SCM. 
It's good for keeping track of patches, but let's face it, if you have 
really big changes, you don't want to handle them the way darcs does.

And in that sense, I do think the two approaches can _complement_ each 
other. A lot of people use quilt (or quite often, something similar, based 
on a SCM in the background: git has and stgit and guilt, hg has "mercurial 
queues"). And it's absolutely true that you want to have a "fluid" level 
too, and darcs can do that. 

But you do *not* want to do the whole project history that way. At some 
point, you need something that works at another level than patch queues. 
Darcs itself kind of has something like this with "checkpointing", but the 
fact is, git is just better at this.

So it basically boils down to the fact that I don't think darcs solves the 
real problems, and won't scale up. It's versioning model seems *totally* 
broken, for example. 

Fundmantal example: somebody has a problem/bug. Tell me how to tell a 
developer what his exact version is - without creating new tags, and 
without having to synchronize the archives. Just tell the developer what 
version he is at.

In git, you just give a revision number. In darcs, what the *hell* do you 
do? And that's a pretty damn fundamental operation for a source control 
management setup! As far as I know, darcs only has patch identities.

			Linus

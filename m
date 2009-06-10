From: Theodore Tso <tytso@mit.edu>
Subject: Re: EasyGit Integration
Date: Tue, 9 Jun 2009 23:32:11 -0400
Message-ID: <20090610033211.GA7411@mit.edu>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com> <alpine.LFD.2.01.0906091512350.6847@localhost.localdomain> <51419b2c0906091530t3dfa5267s2262f979f1e9982a@mail.gmail.com> <alpine.LFD.2.01.0906091535410.6847@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>, Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 10 05:33:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEEYw-0001If-7Z
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 05:33:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbZFJDcq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 23:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752075AbZFJDcp
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 23:32:45 -0400
Received: from THUNK.ORG ([69.25.196.29]:43923 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750885AbZFJDco (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 23:32:44 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1MEEYI-00037X-Py; Tue, 09 Jun 2009 23:32:39 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1MEEXr-0005gp-Rp; Tue, 09 Jun 2009 23:32:11 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0906091535410.6847@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121246>

On Tue, Jun 09, 2009 at 03:40:35PM -0700, Linus Torvalds wrote:
> I also don't mind per se having the "git checkout" kind of semantics, 
> where different kinds of arguments result in different kinds of behavior. 
> I'm not convinced it's a wonderful design, but I would not object to
> 
>  - old behavior: revert the commit by creating an "anti-commit":
> 
> 	git revert <cmit-name>
> 
>  - new extension: revert the state of the working tree to the HEAD:
> 
> 	git revert [--] pathspec
> 
> which would kind of match the semantics of "git checkout" does.

My personal opinion is this kind of overloading is actually more
confusing than simply adding a new name, such as "git revert-file".
Of course, you can do that already using a git alias....  So IMHO the
best way of handling this issue is to have git tutorials use this as a
teachable moment, so people can create their own git alias for "git
checkout HEAD --".

   	       	      	   	   	   - Ted

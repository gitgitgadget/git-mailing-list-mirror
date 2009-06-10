From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: EasyGit Integration
Date: Tue, 9 Jun 2009 21:03:54 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906092058430.6847@localhost.localdomain>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com> <alpine.LFD.2.01.0906091512350.6847@localhost.localdomain> <51419b2c0906091530t3dfa5267s2262f979f1e9982a@mail.gmail.com> <alpine.LFD.2.01.0906091535410.6847@localhost.localdomain>
 <20090610033211.GA7411@mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Elijah Newren <newren@gmail.com>, Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 10 06:04:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEF2s-0008T6-Bl
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 06:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbZFJED5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 00:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbZFJED5
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 00:03:57 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60578 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750808AbZFJED4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2009 00:03:56 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5A43tjS022127
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 9 Jun 2009 21:03:56 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5A43spF013048;
	Tue, 9 Jun 2009 21:03:54 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090610033211.GA7411@mit.edu>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.467 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121248>



On Tue, 9 Jun 2009, Theodore Tso wrote:
> 
> My personal opinion is this kind of overloading is actually more
> confusing than simply adding a new name, such as "git revert-file".

I'd agree, except I think it actually worked pretty well in "git 
checkout". 

The alternative was to add yet another command for that, or to teach 
people about the internal commands we did have. Adding the capability for 
checkout to check out individual files - in addition to commits and 
branches - I think worked pretty well.

And "git checkout" in many ways is an even more complicated case, much 
more so than the suggested "git revert".

Now, I also happen to think that "git checkout [cmit] -- pathspec" is a 
much more _logical_ name for what the SVN people apparently call "revert", 
but hey, whatever. If SVN people feel happier about writing "git revert 
<pathspec>", then why not?

But I certainly won't argue very sternuously for adding that whole new 
"git revert [cmit] [--] <pathspec>" syntax. I can certainly live without 
it.  I don't think it would be a disaster, though.

		Linus

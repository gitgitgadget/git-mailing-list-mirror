From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: svn to git, N-squared?
Date: 12 Jun 2006 09:25:05 -0700
Message-ID: <867j3mwdcu.fsf@blue.stonehenge.com>
References: <9e4733910606111902l709c71ccyf45070d55112739e@mail.gmail.com>
	<Pine.LNX.4.64.0606112028010.5498@g5.osdl.org>
	<86irn6wdob.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 12 18:25:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FppE2-0006s7-3M
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 18:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbWFLQZK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 12:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752087AbWFLQZK
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 12:25:10 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:31823 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751883AbWFLQZI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 12:25:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 52FE38F302;
	Mon, 12 Jun 2006 09:25:06 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 10244-01-26; Mon, 12 Jun 2006 09:25:05 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id B4FE78F325; Mon, 12 Jun 2006 09:25:05 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
x-mayan-date: Long count = 12.19.13.6.16; tzolkin = 12 Cib; haab = 9 Zotz
In-Reply-To: <86irn6wdob.fsf@blue.stonehenge.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21713>

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:

>>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:
Linus> This sounds like _exactly_ what happens if you don't repack
Linus> occasionally.  Expecially if you are using a filesystem without hashed
Linus> filename lookup, but it's true to some degree even with that - the
Linus> filesystem tends to end up spending tons of time in kernel space,
Linus> trying to find a place to put new objects.

Randal> I'm using git-svn to do a similar thing with a 11K-commit history.  It's now 4
Randal> days running, and yes, I'm repacking and deleting empty dirs every 200-300
Randal> commits, but I'm only up to commit 4000 or so.  At this rate, I *may* finish
Randal> by sometime next week. :(

Randal> However, I notice one thing that can't be good: .git/git-svn/revs has one file
Randal> per revision.  Yes, I'll end up with 11000 files in a single directory.  Ugh.

Another contributing factor is that there's 2500 files in the repo (at
revision 3931).  I was recording 20 commits a minute in the early part of the
cycle, and now I'm down to 1 commit every two minutes.  Doing a bit of
back-of-the-scribbled-on-envelope calcs, I won't be finished for
another two weeks or so. :(

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!

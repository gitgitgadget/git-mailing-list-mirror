From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE: Git vs Monotone
Date: Thu, 31 Jul 2008 12:52:43 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807311244240.3277@nehalem.linux-foundation.org>
References: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com> <alpine.LFD.1.10.0807311211260.3277@nehalem.linux-foundation.org> <63BEA5E623E09F4D92233FB12A9F79430238A5EC@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sverre@rabbelier.nl, Git Mailinglist <git@vger.kernel.org>
To: "Craig L. Ching" <cching@mqsoftware.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 21:57:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOeGb-0001RE-Ls
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 21:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbYGaTzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 15:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753691AbYGaTzs
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 15:55:48 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42945 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751278AbYGaTzs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2008 15:55:48 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6VJtgS7019166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 Jul 2008 12:55:44 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6VJtg3S008898;
	Thu, 31 Jul 2008 12:55:42 -0700
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F79430238A5EC@emailmn.mqsoftware.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.406 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90976>



On Thu, 31 Jul 2008, Craig L. Ching wrote:
> 
> It's possible he's doing that, but it's also possible he just isn't that
> familiar with git.

Possible. But it really sounded like he didn't even try. Because quite 
frankly, if he had even bothered to _try_, he wouldn't have gotten the 
numbers he got.

The fact is, even without "-s", a local clone will do hardlinks for the 
database. And since the original pack-file is marked as a 'keep' file, 
that original pack-file won't even be broken apart.

So literally, if he had just bothered to even _try_ the git setup, he'd 
have noticed that git actually uses less disk than monotone would do. But 
it sounds like he didn't even try it.

So completely ignoring the fact that you could do a single database with 
git, and completely ignoring the fact that with git you'd probably use 
branches for at least some of those 11 repos anyway, he'd _still_ have had 
less disk space used by git unless he would do something intentionally odd 
(like clone all the repositories over the network separately).

			Linus

From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git vs Monotone
Date: Thu, 31 Jul 2008 12:17:32 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807311211260.3277@nehalem.linux-foundation.org>
References: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailinglist <git@vger.kernel.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Thu Jul 31 21:22:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOdir-0004T8-9g
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 21:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755862AbYGaTU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 15:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755548AbYGaTU6
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 15:20:58 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52118 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755390AbYGaTU6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2008 15:20:58 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6VJKW1Q016409
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 Jul 2008 12:20:33 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6VJKVtJ007346;
	Thu, 31 Jul 2008 12:20:31 -0700
In-Reply-To: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.407 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90971>



On Thu, 31 Jul 2008, Sverre Rabbelier wrote:
> 
> I just read this blog post [0] in which one of the Pidgin devs sheds
> his light on their 'tool choice'. In the post he mentions the
> following figures:

Don't even bother. The guy is apparently not even trying to work with his 
tools, he just has an agenda to push.

Quite frankly, anybody who wants to stay with monotone, we should 
_encourage_ them. They add nothing to any possible project, because they 
are clearly not very intelligent.

The guy is apparently happy using a single database for monotone (which 
apparently has a database that is two times the size of the git one), but 
then doesn't want to use a single database for git, but wants to force a 
full clone for each. Not to mention that in git, you'd normally not do 11 
clones to begin with, you'd just do 11 branches in one repo.

So there is no point discussing things with people like that. If he wants 
to skew things in monotone's favor, he can do it. Let him. 

			Linus

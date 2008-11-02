From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: commit takes 8 secs; but instant when offline - can I fix
 this?
Date: Sun, 2 Nov 2008 11:18:34 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811021115030.3483@nehalem.linux-foundation.org>
References: <1225634894605-1445352.post@n2.nabble.com>  <200811021514.00057.trast@student.ethz.ch> <7d856ea50811020834n3a252ae2r21d36b24c10eebbf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Brendan Macmillan <melbourne.research@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 20:20:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwiUw-0002Z0-97
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 20:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813AbYKBTTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 14:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752805AbYKBTTQ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 14:19:16 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56640 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752598AbYKBTTQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Nov 2008 14:19:16 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA2JIZZ2003368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 2 Nov 2008 11:18:36 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA2JIYbi011186;
	Sun, 2 Nov 2008 11:18:34 -0800
In-Reply-To: <7d856ea50811020834n3a252ae2r21d36b24c10eebbf@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.44 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99869>



On Mon, 3 Nov 2008, Brendan Macmillan wrote:
>
> Many thanks for the explanation, and it's now instant.
> 
> To ~/.gitconfig, I added:
> 
> [user]
>   email = myemail@address.com

I'd like to point out that in addition to making git not try to figure out 
your hostname, you may well want to try to fix your setup so that it 
doesn't take that long in the first place. 

In fact, you might use "git commit" (or "git var -l" which probably shows 
the same 8-second thing more easily without needing anything else) as a 
way to debug what it is that takes too long.

Because even though adding your email to yout .gitconfig file is the right 
solution _anyway_ (because the git guess is rather more flaky than you 
just telling it what host to use), I bet there are other programs that 
will have the same 8-second delay, and you are better off trying to just 
fix your DNS problem.

			Linus

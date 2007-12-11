From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 11:22:20 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712111119310.25032@woody.linux-foundation.org>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com> <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org> <vpq4pepcaz5.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Berlin <dberlin@dberlin.org>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Dec 11 20:23:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Ah4-0002vB-Le
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 20:23:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081AbXLKTWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 14:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752814AbXLKTWk
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 14:22:40 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41084 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752548AbXLKTWj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2007 14:22:39 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBBJMLGd023764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Dec 2007 11:22:22 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBBJMKk7004999;
	Tue, 11 Dec 2007 11:22:21 -0800
In-Reply-To: <vpq4pepcaz5.fsf@bauges.imag.fr>
X-Spam-Status: No, hits=-2.716 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67912>



On Tue, 11 Dec 2007, Matthieu Moy wrote:
> 
> I've seen you pointing this kind of examples many times, but is that
> really different from what even SVN does? "svn log drivers/char" will
> also list atomic commits, and give me a filtered view of the global
> log.

Ok, BK and CVS both got this horribly wrong, which is why I care. Maybe 
this is one of the things SVN gets right.

I seriously doubt it, though. Do you get *history* right, or do you just 
get a random list of commits?

Of course, to see the difference, you need to do "gitk drivers/char" or 
use another of the log viewers that actually show you history too. A plain 
"git log" won't make it obvious (unless you actually ask for parent 
information and then just track the history in your head, in which case 
you don't really need an SCM in the first place ;)

			Linus

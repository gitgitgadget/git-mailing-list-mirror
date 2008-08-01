From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: email address handling
Date: Fri, 1 Aug 2008 13:40:00 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808011335230.3277@nehalem.linux-foundation.org>
References: <20080731194042.a1534b4d.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011229400.3277@nehalem.linux-foundation.org> <20080801124550.26b9efc0.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011253580.3277@nehalem.linux-foundation.org>
 <20080801131127.20b3acfd.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011316050.3277@nehalem.linux-foundation.org> <20080801132415.0b0314e4.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 22:41:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP1Qv-0006Sx-3T
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 22:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353AbYHAUkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 16:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754147AbYHAUkE
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 16:40:04 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38900 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753862AbYHAUkC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2008 16:40:02 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m71Ke0RL001716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 1 Aug 2008 13:40:01 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m71Ke0TB001861;
	Fri, 1 Aug 2008 13:40:00 -0700
In-Reply-To: <20080801132415.0b0314e4.akpm@linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.413 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91095>



On Fri, 1 Aug 2008, Andrew Morton wrote:
> 
> pls read earlier email.

I did. It seems that your complaint is:

> So unless he explicitly typed a "From:" line (without quoting his name)
> into the top of his changelog, some piece of software somewhere has
> stripped the quotes when it was converting his name from the email
> headers into the git Author: line.

And yes, git will strip out all the crap and try to make it into a real 
name.

The part _you_ don't seem to understand is that my point is

 - git changed that "From:" line to an "Author:" line

 - "git log" isn't an email system. It's a human-readable (and 
   machine-parseable, for that matter) log.

If you want to turn it into emails, you need to follow the email rules. 
You're cutting-and-pasting anyway, it's not like this is fundamentally 
hard.

		Linus

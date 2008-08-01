From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: email address handling
Date: Fri, 1 Aug 2008 13:54:21 -0700
Message-ID: <20080801135421.5ca0f6af.akpm@linux-foundation.org>
References: <20080731194042.a1534b4d.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0808011229400.3277@nehalem.linux-foundation.org>
	<20080801124550.26b9efc0.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0808011253580.3277@nehalem.linux-foundation.org>
	<20080801131127.20b3acfd.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0808011316050.3277@nehalem.linux-foundation.org>
	<20080801132415.0b0314e4.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0808011335230.3277@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 22:55:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP1f5-0003Gt-OP
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 22:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796AbYHAUyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 16:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752646AbYHAUyl
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 16:54:41 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50943 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751388AbYHAUyk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2008 16:54:40 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m71KsMwT003030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 1 Aug 2008 13:54:23 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m71KsLFN002494;
	Fri, 1 Aug 2008 13:54:22 -0700
In-Reply-To: <alpine.LFD.1.10.0808011335230.3277@nehalem.linux-foundation.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
X-Spam-Status: No, hits=-2.824 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91098>

On Fri, 1 Aug 2008 13:40:00 -0700 (PDT)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> 
> On Fri, 1 Aug 2008, Andrew Morton wrote:
> > 
> > pls read earlier email.
> 
> I did. It seems that your complaint is:
> 
> > So unless he explicitly typed a "From:" line (without quoting his name)
> > into the top of his changelog, some piece of software somewhere has
> > stripped the quotes when it was converting his name from the email
> > headers into the git Author: line.
> 
> And yes, git will strip out all the crap and try to make it into a real 
> name.
> 
> The part _you_ don't seem to understand is that my point is
> 
>  - git changed that "From:" line to an "Author:" line
> 
>  - "git log" isn't an email system. It's a human-readable (and 
>    machine-parseable, for that matter) log.

What you're describing here is some explicit or implicit git design
decision and then telling me how it's implemented.

Well, what I'm saying is that it was an incorrect design decision.

> If you want to turn it into emails, you need to follow the email rules. 
> You're cutting-and-pasting anyway, it's not like this is fundamentally 
> hard.

Here is a real story from a real user of your software:

I very very frequently copy and paste name+email address out of git
output and into an MUA.  Have done it thousands and thousands of times,
and it has always worked.  I'm sure that many others do the same thing.

Yesterday, I copied and pasted what _looked_ like a usable
name+email-address from some git output and into an MUA.  Unlike the
thousands of preceding times, it did not work.

I think it was reasonable of me to assume that it would work.  Blaming
the surprised and misled user for not understanding some earlier
internal design decision didn't satisfy him!

True story!  From a user.

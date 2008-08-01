From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: email address handling
Date: Fri, 1 Aug 2008 14:12:04 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808011356560.3277@nehalem.linux-foundation.org>
References: <20080731194042.a1534b4d.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011229400.3277@nehalem.linux-foundation.org> <20080801124550.26b9efc0.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011253580.3277@nehalem.linux-foundation.org>
 <20080801131127.20b3acfd.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011316050.3277@nehalem.linux-foundation.org> <20080801132415.0b0314e4.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011335230.3277@nehalem.linux-foundation.org>
 <20080801135421.5ca0f6af.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 23:14:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP1x8-00022F-JI
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 23:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761369AbYHAVMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 17:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760549AbYHAVMd
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 17:12:33 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55788 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761364AbYHAVMc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2008 17:12:32 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m71LC5W6005039
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 1 Aug 2008 14:12:06 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m71LC4ZW003394;
	Fri, 1 Aug 2008 14:12:04 -0700
In-Reply-To: <20080801135421.5ca0f6af.akpm@linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.412 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91101>



On Fri, 1 Aug 2008, Andrew Morton wrote:
> 
> Well, what I'm saying is that it was an incorrect design decision.

And I'm saying that I disagree. 

> Yesterday, I copied and pasted what _looked_ like a usable
> name+email-address from some git output and into an MUA.  Unlike the
> thousands of preceding times, it did not work.
> 
> I think it was reasonable of me to assume that it would work.  Blaming
> the surprised and misled user for not understanding some earlier
> internal design decision didn't satisfy him!
> 
> True story!  From a user.

Hey, there are tons of surprises in life. Users make mistakes and 
assumptions that turn out to not be true. If you think you can avoid all 
such issues, I think you aren't living in the real world.

You'll be shocked to hear that even the so-called _email_ address isn't 
necessarily valid at all at times. Look closer, and you'll find email 
addresses that don't work at all. It turns out that if you don't set it 
explicitly, git will guess, and sometimes the end result won't actually 
work as an email address.

Beign surprised and then saying "I was surprised, so the whole design is 
broken" - that's a very silly standpoint to make. I suggest you 
reconsider. How many times have you had people "surprised" by correct 
kernel behaviour? Happens all the time.

Do you think they are all indicative of bad design, or maybe just "welcome 
to the real world - your preconceived notions didn't turn out to be 
accurate after all"?

It's a design decision to show the name as readably as possible. One that 
I think was correct.

			Linus

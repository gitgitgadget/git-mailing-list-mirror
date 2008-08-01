From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Monotone workflow compared to Git workflow ( was RE: Git vs
 Monotone)
Date: Thu, 31 Jul 2008 20:59:34 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807312049050.3277@nehalem.linux-foundation.org>
References: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com> <alpine.LFD.1.10.0807311211260.3277@nehalem.linux-foundation.org> <63BEA5E623E09F4D92233FB12A9F79430238A5EE@emailmn.mqsoftware.com> <alpine.LFD.1.10.0807311253140.3277@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0807311426090.3277@nehalem.linux-foundation.org> <20080801025024.GA18529@anvil.corenet.prv> <alpine.LFD.1.10.0807311956040.3277@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Craig L. Ching" <cching@mqsoftware.com>, sverre@rabbelier.nl,
	Git Mailinglist <git@vger.kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 06:00:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOloo-0005oi-5g
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 06:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbYHAD7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 23:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbYHAD7l
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 23:59:41 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46613 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750823AbYHAD7k (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2008 23:59:40 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m713xZoN026168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 Jul 2008 20:59:36 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m713xY8o027787;
	Thu, 31 Jul 2008 20:59:34 -0700
In-Reply-To: <alpine.LFD.1.10.0807311956040.3277@nehalem.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.405 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91026>



On Thu, 31 Jul 2008, Linus Torvalds wrote:
> 
> Well, the difference really is the beefy box.

Btw, the fact that I have a beefy box really wasn't the point. The fact 
that I can build the kernel three times quicker than I can build the git 
documentation _was_ kind of the point. A lot of projects have horrible 
build rules - makefiles that don't parallelize well or just tools that 
suck dead baby donkeys through a straw.

I often get the feeling that I can compile the kernel faster than I can 
run "./configure" on most of the other projects I ever compile.

So I'd heartily encourage projects to try to make their build lean and 
mean. It actually then allows you to be more efficient, and gives the 
option of using more efficient development models, where "use multiple 
branches in the same tree" is just one example of that.

Of course, I have to admit that git itself isn't exactly a stellar 
example. I can compile git itself in basically zero time, but those docs 
really take a loooong time.

Just one more reason for me to stay away from documentation.

			Linus

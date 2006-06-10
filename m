From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 9 Jun 2006 18:59:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606091853180.5498@g5.osdl.org>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com> 
 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com> 
 <46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com> 
 <Pine.LNX.4.64.0606091825080.5498@g5.osdl.org>  <Pine.LNX.4.64.0606091837040.5498@g5.osdl.org>
 <9e4733910606091848r5fb4d565taabfc5198140daf2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 10 03:59:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoslN-00047U-N2
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 03:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWFJB7m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 21:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWFJB7m
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 21:59:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42378 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751421AbWFJB7l (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 21:59:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5A1xcgt013316
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Jun 2006 18:59:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5A1xbMp006239;
	Fri, 9 Jun 2006 18:59:38 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606091848r5fb4d565taabfc5198140daf2@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21583>



On Fri, 9 Jun 2006, Jon Smirl wrote:
> > 
> > Btw, does anybody know roughly how much data a initial "cvs co" takes on
> > the mozilla repo? Git will obviously get the whole history, and that will
> > inevitably be bigger than getting a single check-out, but it's not
> > necessarily orders of magnitude bigger.
> 
> 339MB for initial checkout

And I think people run :pserver: with compression by default, so we're 
likely talking about half that in actual download overhead, no?

So a git clone would be about (wild handwaving, don't look at all the 
assumptions) four times as expensive - assuming we only look at a poor DSL 
line as the expense - as an initial CVS co, but you'd get the _whole_ 
history. Which may or may not make up for it. For some people it will, for 
others it won't.

Of course, to make up for some of the initial costs, I suspect that some 
people who are used to "cvs update" taking 15 minutes to update two files, 
it would be a serious relief to see the git kind of "300 objects in five 
seconds" kinds of pulls.

Although I guess that's one of the CVS things that SVN improved on. At 
least I'd hope so ;/

			Linus

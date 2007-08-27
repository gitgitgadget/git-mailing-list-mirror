From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: repo.or.cz wishes?
Date: Mon, 27 Aug 2007 11:23:52 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708271114470.25853@woody.linux-foundation.org>
References: <20070826235944.GM1219@pasky.or.cz> <20070827001634.GB1976MdfPADPa@greensroom.kotnet.org>
 <20070827004153.GN1219@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: skimo@liacs.nl, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Aug 27 20:35:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPjH0-0004TS-71
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 20:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757315AbXH0SZI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 14:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757438AbXH0SZH
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 14:25:07 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57257 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757156AbXH0SZG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Aug 2007 14:25:06 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7RINrTM029511
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 27 Aug 2007 11:23:54 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7RINqrx021945;
	Mon, 27 Aug 2007 11:23:52 -0700
In-Reply-To: <20070827004153.GN1219@pasky.or.cz>
X-Spam-Status: No, hits=-2.751 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.29__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56866>



On Mon, 27 Aug 2007, Petr Baudis wrote:

> On Mon, Aug 27, 2007 at 02:16:34AM CEST, Sven Verdoolaege wrote:
> > On Mon, Aug 27, 2007 at 01:59:44AM +0200, Petr Baudis wrote:
> > >   So now I wonder, what is the thing you miss most there? Any cool stuff
> > > repo.or.cz could (preferrably easily) do and doesn't?
> > 
> > Just a minor nit, but how about dropping the "git+" from the
> > Push URL?
> 
> I'm a major proponent of the "git+"

I'd say "only", not "major".

It makes no sense.

> - it's just the correct thing to specify. ssh:// by itself means secure 
> _shell_

No it isn't, and no it doesn't.

It makes no sense what-so-ever.

"ssh://" is the *protocol*. What is actually done over the protocol is 
specified by the program.

This is not at all git specific. Try running "ssh" vs "scp" some day, and 
you'll notice the exact same thing: they both use the ssh _protocol_, but 
no, your statement that "ssh://" by itself means "secure _shell_" is total 
and utter garbage.

It means nothing at all of the kind. 

"ssh://" means the ssh protocol. It is that unambiguous, and that simple. 
Saying "git+ssh://" is totally idiotic, always has been, and always will 
be.

It's as stupid as it would be to require people to say

	scp cp+ssh://host/filename .

and nobody sane would *ever* advocate something that stupid. It's not how 
it's done.

So why do you continue to advocate "git+ssh://", when nobody else does, 
and several people have asked you not to.

And yes, I realize that SVN does it. SVN for some unfathomable reason uses 
"svn+ssh://", but let's face it, the SVN developers have neither taste nor 
brains. They don't know any better.

			Linus

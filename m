From: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH 3/3] Add a few more words to the glossary.
Date: Thu, 04 May 2006 08:44:33 -0500
Message-ID: <E1Fbe89-0006W5-JT@jdl.com>
References: <E1FbVJi-0004UJ-59@jdl.com>  <7vu0868h7a.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 04 15:44:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fbe8G-0000H2-Nf
	for gcvg-git@gmane.org; Thu, 04 May 2006 15:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWEDNof (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 09:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWEDNof
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 09:44:35 -0400
Received: from www.jdl.com ([66.118.10.122]:2944 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1750709AbWEDNof (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 May 2006 09:44:35 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1Fbe89-0006W5-JT; Thu, 04 May 2006 08:44:34 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: Your message of "Wed, 03 May 2006 22:58:01 PDT."
             <7vu0868h7a.fsf@assigned-by-dhcp.cox.net> 
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19569>

So, like, the other day Junio C Hamano mumbled:
> Jon Loeliger <jdl@jdl.com> writes:
> 
> >  ref::
> > -	A 40-byte hex representation of a SHA1 pointing to a particular
> > -	object. These may be stored in `$GIT_DIR/refs/`.
> > +	A 40-byte hex representation of a SHA1 or a name that denotes
> > +	a particular object. These may be stored in `$GIT_DIR/refs/`.
> >  
 
> Uum.  Not very clear.  Do we use that word that often?

Well, I was mystified a bit too, and I tried to clean it up some...
"ref" gets used as half a <refspec>, from pull-fetch-param.txt:

	A parameter <ref> without a colon is equivalent to <ref>: when
	pulling/fetching, so it merges <ref> into the current branch
	without storing the remote branch anywhere locally

So maybe I was confused here.

> > +symbolic ref::
> > +	See "ref".
>
> I think I used that term to differenciate between HEAD symlink
> pointing at refs/heads/master and HEAD being a regular file that
> stores a line "ref: refs/heads/master\n"; the latter is the
> modern style "textual symref", so in that context it is not
> about 40-byte hex at all.  And at that level it is really a
> jargon to talk about one small implementation detail of HEAD, so
> I am not sure it deserves to be in the glossary.

Given "git-symbolic-ref <name> [<ref>]", clearly I just botched it.
You were right to drop my confused "symbolic ref" entry. :-(

> >  tracking branch::
> > -	A regular git branch that is used to follow changes from
> > +	A regular git branch that is used to follow changes frompointing
> >  	another repository.  A tracking branch should not contain
> 
> I think this is a typo?

Yes.  Thanks for noticing and cleaning.

jdl

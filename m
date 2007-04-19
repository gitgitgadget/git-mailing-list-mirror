From: Marcin Kasperski <Marcin.Kasperski@softax.pl>
Subject: Re: GIT vs Other: Need argument
Date: Thu, 19 Apr 2007 13:59:53 +0200
Organization: Softax
Message-ID: <1176983993.30690.13.camel@cauchy.softax.local>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
	 <20070417173007.GV2229@spearce.org> <462521C7.2050103@softax.com.pl>
	 <200704172239.20124.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 14:20:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeVcH-0004er-I7
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 14:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbXDSMT6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 08:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbXDSMT6
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 08:19:58 -0400
Received: from bozon2.softax.com.pl ([83.238.10.48]:43872 "EHLO
	bozon2.softax.com.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964796AbXDSMT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 08:19:57 -0400
Received: from bozon2.softax.pl (localhost.localdomain [127.0.0.1])
	by bozon2.softax.com.pl (Postfix) with ESMTP id ECD4CDC006;
	Thu, 19 Apr 2007 13:59:55 +0200 (CEST)
Received: from 127.0.0.1 (127.0.0.1)
 by bozon2.softax.pl (F-Secure/fsigk_smtp/488/bozon2.softax.pl);
 Thu, 19 Apr 2007 13:59:55 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/488/bozon2.softax.pl)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by bozon2.softax.com.pl (Postfix) with ESMTP id D41CCDC007;
	Thu, 19 Apr 2007 13:59:55 +0200 (CEST)
Received: from bozon2.softax.com.pl ([127.0.0.1])
 by localhost (bozon2.softax.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 03497-07; Thu, 19 Apr 2007 13:59:53 +0200 (CEST)
Received: from cauchy.softax.local (unknown [16.193.144.107])
	by bozon2.softax.com.pl (Postfix) with ESMTP id E213CDC006;
	Thu, 19 Apr 2007 13:59:53 +0200 (CEST)
In-Reply-To: <200704172239.20124.andyparkins@gmail.com>
X-Mailer: Evolution 2.6.3 
X-Virus-Scanned: amavisd-new at softax.pl
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45005>

> but git is definitely no harder to learn 
> than anything else.  I browsed through the mecurial tutorial 
> yesterday - and as well as being significantly less powerful than git, 
> it's no easier.

Mercurial is easier to learn, because it has better docs and slightly
simpler command line (all those -a, -p, ... options which one always
forgets to add). I tried it.
In fact, I did the experiment about month ago. I wanted to give a try
to distributed vc tool. I started from GIT, played a bit with it, and
abandoned it because a) I did not know whether I am expected to use git,
or cg, b) While reading docs many times I had the feeling that something
strange and unclear is going behind the hood.

Then I took mercurial and in a few hours I felt I know all the important
things.

> (I can't believe this one - if you want to branch a mercurial repository 
> you have to have another complete checkout.  Erm... the checkout takes 
> up more space than the repository - why do I need another copy? Anyway, 
> git is no harder than Mercurial here)

AFAIK you are wrong, they are able to link some files while cloning, so
you loose space only if you switch machine or filesystem. Also, recent
mercurial has initial within-repo branches support. But I am not really
the best person to conduct git-vs-hg discussion.

> "(Note for Windows users: Mercurial is missing a merge program" - that 
> Windows support isn't looking quite so hot now.

Mercurial on windows works well with kdiff3 or tortoisemerge, you must
only install one of them. 

> > c) Lack of reasonable subproject support (plus detailed permission
> > model).
> 
> Mercurial has no native subproject support either - it requires a 
> plugin, git's is in development.

As I said, I am not conducting hg-vs-git discussion. I just happened 
to introduce and manage VC system in corporate environment, so I am able
to point that this is important feature.

> As for permissions, well Shawn has often spoken of his hook scripts that 
> implement very strong permissions (and he has done so again in this 
> thread).

I am not quite sure how can you forbid johny to see the code
in ./secret, while johny must checkout whole repo...

Permissions are not only about writing.

> Depends what you want - I installed cygwin 

This is really not an option for typical windows user. Believe me.
Maybe it could be, if cygwin managed to create normal setup program
one day...

Let me retype it: I am not complaining. GIT developers are not forced to
think about win users, or about corporate needs. But if they are, it is
reasonable to know the problems.

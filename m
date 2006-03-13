From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What should I use instead of git show?
Date: Mon, 13 Mar 2006 08:33:22 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603130830050.3618@g5.osdl.org>
References: <20060313144747.GA81092@dspnet.fr.eu.org> <200603131717.53416.astralstorm@o2.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Olivier Galibert <galibert@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 13 17:38:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIpzT-0005Yy-Me
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 17:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWCMQdt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 11:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWCMQdt
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 11:33:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32642 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751361AbWCMQds (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Mar 2006 11:33:48 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2DGXNDZ010411
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 13 Mar 2006 08:33:23 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2DGXM17013072;
	Mon, 13 Mar 2006 08:33:22 -0800
To: Radoslaw Szkodzinski <astralstorm@o2.pl>
In-Reply-To: <200603131717.53416.astralstorm@o2.pl>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17571>



On Mon, 13 Mar 2006, Radoslaw Szkodzinski wrote:
> On Monday 13 March 2006 15:47, Olivier Galibert wrote yet:
> > Since it seems to be gone.
> >
> > Up until now, when I wanted to send a patch to someone with the
> > associated changelog, I just did a git log to find the changelog sha1
> > then a git show to get the goods.  How am I supposed to do that now?
> >
> >   OG.
> 
> Why not use git-whatchanged? It's exacly meant to do this.
> Or try qgit, or even gitk (which is what git show did).

Why not just use "git show"?

It hasn't gone anywhere that I know of. It's still there.

Are you stuck with an older version of git that doesn't have it? If so, 
you can indeed do

	git whatchanged -p -1 <sha1>

instead (actually, if your git is really old, you shouldn't use the modern 
shorthand of "-1", you should use the longer "--max-count=1" instead).

		Linus

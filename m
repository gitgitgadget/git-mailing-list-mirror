From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: Memory overrun in http-push.c
Date: Thu, 1 Mar 2007 12:11:00 +0300
Message-ID: <20070301091058.GA63606@codelabs.ru>
References: <20070228151516.GC57456@codelabs.ru> <200702281541.41164.andyparkins@gmail.com> <20070301051323.GG57456@codelabs.ru> <81b0412b0703010015l5c91c68pd4748ae379db98bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 10:11:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMhJh-00023w-W0
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 10:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933173AbXCAJLM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 04:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933174AbXCAJLM
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 04:11:12 -0500
Received: from pobox.codelabs.ru ([144.206.177.45]:53697 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933173AbXCAJLK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 04:11:10 -0500
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HMhJa-000Gef-R7; Thu, 01 Mar 2007 12:11:07 +0300
Content-Disposition: inline
In-Reply-To: <81b0412b0703010015l5c91c68pd4748ae379db98bb@mail.gmail.com>
X-Spam-Status: No, score=-2.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_05
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41057>

> >As Johannes pointed out, old habits are still alive. And when some
> >tool serves me the right way, I am happy with it. To make the patch
> >with Git I should create repository, hack there, merge it to the
> 
> hacking on Git you already have a git repo, don't you?

No, I was doing FreeBSD port of Git 1.5.0, so it was just the tarball.
Old habits, you know ;))

> It should have been as simple as:
> 
> $ vi http-push.c
> ...
> $ git diff
> 
> :)
> 
> BTW, git diff works outside of a git repositories (well, very recent
> git should).

Once I will get Git working for me I will get used to it and will
do many things in Git.

OK, I've forgot to ask in my previous letter: will the issue with
'+11' instead of '+1' be fixed (or its already fixed)? Or 11 is 10 + 1,
where 10 it strlen("git") trice plus one just to be sure? ;)))
-- 
Eygene

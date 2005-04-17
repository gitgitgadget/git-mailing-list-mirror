From: Brad Roberts <braddr@puremagic.com>
Subject: Re: [patch] fork optional branch point normazilation
Date: Sun, 17 Apr 2005 16:27:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.44.0504171614150.2625-100000@bellevue.puremagic.com>
References: <Pine.LNX.4.58.0504171005220.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 01:24:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNJ82-0005j1-BG
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 01:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVDQX2Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 19:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVDQX1u
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 19:27:50 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:16537 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261552AbVDQX1h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 19:27:37 -0400
Received: from bellevue.puremagic.com (localhost [127.0.0.1])
	by bellevue.puremagic.com (8.13.3/8.13.3/Debian-6) with ESMTP id j3HNRVcu031414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 17 Apr 2005 16:27:32 -0700
Received: from localhost (braddr@localhost)
	by bellevue.puremagic.com (8.13.3/8.13.3/Submit) with ESMTP id j3HNRV4n031408;
	Sun, 17 Apr 2005 16:27:31 -0700
X-Authentication-Warning: bellevue.puremagic.com: braddr owned process doing -bs
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504171005220.7211@ppc970.osdl.org>
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 17 Apr 2005, Linus Torvalds wrote:

> On Sun, 17 Apr 2005, Brad Roberts wrote:
> >
> > (ok, author looks better, but committer doesn't obey the AUTHOR_ vars yet)
>
> They should't, but maybe I should add COMMITTER_xxx overrides. I just do
> _not_ want people to think that they should claim to be somebody else:
> it's not a security issue (you could compile your own "commit-tree.c"
> after all), it's more of a "social rule" thing. I prefer seeing bad email
> addresses that at least match the system setup to seeing good email
> addresses that people made up just to make them look clean.
>
> Mind showing what your /etc/passwd file looks like (just your own entry,
> and please just remove your password entry if you don't use shadow
> passwords).
>
> Maybe I should just remove _all_ strange characters when I do the name
> cleanup in "commit". Right now I just remove the ones that matter to
> parsing it unambiguosly: '\n' '<' and '>'.
>
> (The ',' character really is special: some people have
>
> 	Torvalds, Linus
>
> and maybe I should not just remove the commas, I should convert it to
> always be "Linus Torvalds". But your gecos entry is just _strange_. Why
> the extra commas, I wonder?)
>
> 		Linus
> -

I fully agree with the intent of the field separation, they're two very
different activities.

braddr:x:1000:1000:Brad Roberts,,,:/home/braddr:/bin/bash

All gecos entries on all my debian boxes are of the form:

   fullname, office number, office extension, and home number

This is taken from the chfn man page on debian.  Looking on my nearest
redhat box, the chfn man page is roughly the same.  Debian's man page also
has one snippit that's not in redhat's, suggested delimiter is a ','.  A
bit of searching for other platforms, aix suggests a ';' as a delimiter.
HPUX seems to want a ','.

Later,
Brad


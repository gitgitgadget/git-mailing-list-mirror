From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: refining .gitignores
Date: Thu, 15 Nov 2007 20:28:06 +0000
Message-ID: <80ejerdzjd.fsf@tiny.isode.net>
References: <804pfobgkp.fsf@tiny.isode.net>
            <20071114230258.GG3973@steel.home>
            <807ikj3fge.fsf@tiny.isode.net>
            <20071115192654.GA3552@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 21:28:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IslKB-0008UF-1k
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 21:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbXKOU2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 15:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752258AbXKOU2O
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 15:28:14 -0500
Received: from rufus.isode.com ([62.3.217.251]:39467 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751718AbXKOU2N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 15:28:13 -0500
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <Rzyr1gBBVHDz@rufus.isode.com>; Thu, 15 Nov 2007 20:28:08 +0000
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Thu, 15 Nov 2007 20:28:06 +0000
X-Hashcash: 1:20:071115:raa.lkml@gmail.com::Gp4B1gTAkEa8R7L6:00000000000000000000000000000000000000000001RRr
X-Hashcash: 1:20:071115:git@vger.kernel.org::/5FNMzmY2B0MvmQn:0000000000000000000000000000000000000000000FT+
In-Reply-To: <20071115192654.GA3552@steel.home> (Alex Riesen's message of "Thu\, 15 Nov 2007 20\:26\:54 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65156>

Alex Riesen <raa.lkml@gmail.com> writes:

[...]

> .gitignore? Without "s"?

Yes, my mistake.  I added '*.c' to ".gitignore".

> Maybe your .c files are already added to index? Otherwise you have to
> use the second form. It shows known-to-Git ignored files.

They are in the index.  What I want is a list of files which are known
to git, which are matched by the default rules (in particular the
.gitignore files).

So that should be this?

    git ls-files --exclude-per-directory=.gitignore -i

But that shows nothing at all, and it still shows nothing if I add a
"builtin-add.c" as an argument to it (this file exists, and is in the
index).

"git add builtin-add.c" fails, complaining (correctly) that the path
is ignored by one of my .gitignore files.

We're obviously talking past one another somehow, or I have a broken
build of git?

[...]

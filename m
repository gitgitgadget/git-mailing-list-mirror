From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: using gvim as editor on Windows
Date: Tue, 9 Mar 2010 00:32:09 +0100
Message-ID: <201003090032.10037.markus.heidelberg@web.de>
References: <20100306070628.GM2480@ece.pdx.edu> <201003061317.38422.markus.heidelberg@web.de> <20100308185439.GO2480@ece.pdx.edu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tait <git.git@t41t.com>
X-From: git-owner@vger.kernel.org Tue Mar 09 13:35:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoySG-0001Do-Ko
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 13:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755537Ab0CHXbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 18:31:11 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:60055 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174Ab0CHXbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 18:31:09 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 7FD1614BE8B99;
	Tue,  9 Mar 2010 00:31:07 +0100 (CET)
Received: from [91.19.4.192] (helo=pluto.localnet)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1NomPj-0007wn-00; Tue, 09 Mar 2010 00:31:07 +0100
User-Agent: KMail/1.12.3 (Linux/2.6.30-gentoo-r8; KDE/4.3.3; i686; ; )
In-Reply-To: <20100308185439.GO2480@ece.pdx.edu>
Jabber-ID: markus.heidelberg@web.de
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX192pC5RXXyNgc5TdbqoLGoCRJRSpDmLXyzQv3RY
	oNTcaDfblN694HHDlk9rgjiBx6uZM/1uuNFf1CBDWK9+gClRhp
	cJYn/vjq0oN6G0I3Rp0A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141815>

Tait, 2010-03-08 19:54:
> > > On Windows, gvim -f is basically a shortcut for the start invocation I
> > > pasted above.
> >
> > Not necessarily. You can avoid using the .bat wrappers from C:\Windows,
> > which cause the problem, but use gvim.exe directly by setting your PATH
> > appropriately. It will also work for git-difftool.
> 
> I was hoping for a little more life in this thread.

First of all: do you have the problems in cmd.exe or Git Bash or both?

> Does calling the .exe directly work for you? If I call gvim.exe directly
> (with or without -f -- it doesn't matter), it opens a new file called
> $@.

I don't know where the $@ should come from. You apparently don't invoke
gvim.exe directly. git-commit is a C program, not a shell script, there
should come no $@ from this side. What does invoking gvim.exe on the
command line without the use of git do?

I have:
core.editor=gvim -f
C:\Programme\Vim\vim72 in PATH (both before or after C:\WINDOWS works here)
Works with cmd.exe and Git Bash.

> The problem seems to be unique to me, so I'll find some time to look at
> what rebase and/or commit are doing wrong.

I guess neither rebase nor commit are wrong in this case.

Markus

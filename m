From: Jean-Luc Herren <jlh@gmx.ch>
Subject: Re: [RFC] Zit: the git-based single file content tracker
Date: Fri, 24 Oct 2008 01:23:38 +0200
Message-ID: <4901077A.7050904@gmx.ch>
References: <gdok16$vh2$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 24 01:25:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kt9YN-0001fH-Nm
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 01:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758649AbYJWXXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 19:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752672AbYJWXXl
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 19:23:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:45703 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758649AbYJWXXk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 19:23:40 -0400
Received: (qmail invoked by alias); 23 Oct 2008 23:23:38 -0000
Received: from 154-55.78-83.cust.bluewin.ch (EHLO [192.168.123.204]) [83.78.55.154]
  by mail.gmx.net (mp015) with SMTP; 24 Oct 2008 01:23:38 +0200
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX1/O7DsBIQnOrGrT4j5K9pXUaC6nOXKzqSC1WJ6HeS
	2zt/2gub+aXdas
User-Agent: Thunderbird 2.0.0.17 (X11/20080928)
In-Reply-To: <gdok16$vh2$1@ger.gmane.org>
X-Enigmail-Version: 0.95.7
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98994>

Hi!

Giuseppe Bilotta wrote:
> So today I decided to start hacking at a git-based but file-oriented
> content tracker, which I decided to name Zit.

This sounds great and would seem very useful to manage my ~/bin/
directory which contains a set of unrelated one-file-tools that
evolve over time.  I haven't played with it yet though.

> when you choose to start tracking a file with Zit [...]
> Zit will create a directory .zit.file to hold a git repository

If you have many files you want to track in a single directory
(like ~/bin/), all those additional directories will quickly feel
like clutter.  If you track every file, it will even double the
number of things you see with an "ls -a".

If you decide against a shared repository, maybe you want to
consider to not use ".zit.file/", but ".zit/file/" as the
repository?  This would reduce the clutter to a single directory,
just like with ".git".  And moving files around wouldn't be that
much complicated.

jlh

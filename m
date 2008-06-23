From: Ian Hilt <Ian.Hilt@gmx.com>
Subject: Re: git blame for a commit
Date: Sun, 22 Jun 2008 23:40:26 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806222300410.23258@sys-0.hiltweb.site>
References: <485ED2E5.3070906@mircea.bardac.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mircea Bardac <dev@mircea.bardac.net>
X-From: git-owner@vger.kernel.org Mon Jun 23 05:48:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAd2F-0007nX-Ab
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 05:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbYFWDrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 23:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752750AbYFWDrK
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 23:47:10 -0400
Received: from mail.gmx.com ([74.208.5.67]:47809 "HELO mail.gmx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752407AbYFWDrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 23:47:09 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Jun 2008 23:47:09 EDT
Received: (qmail invoked by alias); 23 Jun 2008 03:40:27 -0000
Received: from cpe-75-185-208-72.woh.res.rr.com (EHLO [192.168.1.1]) [75.185.208.72]
  by mail.gmx.com (mp-us001) with SMTP; 22 Jun 2008 23:40:27 -0400
X-Authenticated: #47758715
X-Provags-ID: V01U2FsdGVkX180snEQRvE0bgsVzRNfNKKGHbYzwSPqvtuDIm6KZ8
	/6Fx8jnLGp8f7H
In-Reply-To: <485ED2E5.3070906@mircea.bardac.net>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85832>

On Sun, 22 Jun 2008 at 11:32pm +0100, Mircea Bardac wrote:

> Hi everyone,
> 
> Is there any straightforward way of doing git blame for all the files that got
> changed in a commit. Problems are renames, deletes and copies.

Sounds like you want to track files rather than content.  Git tracks the
latter.

> I was also thinking of git diff with a huge number of context lines, but this
> one feels a bit hacking. "git diff" is also missing author info, so "git
> blame" is a bit more desirable.
> 
> Has anyone ever done this before?
> 
> Many thanks.

Try "git diff --name-only commit1..commit2" or "git log --name-only
commit1..commit2".  This will give you only the names of the files in
which content was altered.  Other than that, I think you should re-read
(hint) git-blame(1).  It's focus is on content, not files as a whole.


--
Ian Hilt
Ian.Hilt (at) gmx.com
GnuPG key: 0x4AFC1EE3

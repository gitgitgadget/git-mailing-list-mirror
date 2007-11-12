From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Is it possible for git to remember the options preference for
 "git log"?
Date: Sun, 11 Nov 2007 20:02:28 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711111954520.29952@iabervon.org>
References: <f17812d70711111633u6c00d182u532fef1c16c3c94a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: eric miao <eric.y.miao@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 02:02:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrNhN-0005jJ-AH
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 02:02:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbXKLBCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 20:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbXKLBCa
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 20:02:30 -0500
Received: from iabervon.org ([66.92.72.58]:45912 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751672AbXKLBC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 20:02:29 -0500
Received: (qmail 627 invoked by uid 1000); 12 Nov 2007 01:02:28 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Nov 2007 01:02:28 -0000
In-Reply-To: <f17812d70711111633u6c00d182u532fef1c16c3c94a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64547>

On Mon, 12 Nov 2007, eric miao wrote:

> All,
> 
> Most of the time I'm using git-log for inspecting a brief history
> and insert/remove/modify commits between, which I have to
> type "git log --abbrev-commit --pretty=oneline" every time. Is
> it possible for git to remember this command line options
> preference?
> 
> And no, I don't really want to use shell's alias or something
> else, I was just used to type "git xxx" :-)

Git has a built-in alias mechanism, which is probably what you want. If 
you put in your config file:

[alias]
	xxx = log --abbrev-commit --pretty=online

then you can type "git xxx" and it'll do what you want. Changing the 
default behavior of the basic commands is looked down on because there are 
scripts that use them to get their input, and those scripts have 
particular formats they expect.

	-Daniel
*This .sig left intentionally blank*

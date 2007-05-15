From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: git as a backup tool?
Date: Tue, 15 May 2007 07:51:32 +0200
Message-ID: <20070515055132.GC5493@xp.machine.xx>
References: <Pine.LNX.4.64.0705141334120.20215@anakin> <c1b8b6670705142209x267e44cbrea26aa8818275aea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, git@vger.kernel.org
To: Russell <russellsteicke@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 15 07:51:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hnpwk-0006Ki-Fk
	for gcvg-git@gmane.org; Tue, 15 May 2007 07:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756569AbXEOFvg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 01:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758203AbXEOFvg
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 01:51:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:41137 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756569AbXEOFvf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 01:51:35 -0400
Received: (qmail invoked by alias); 15 May 2007 05:51:33 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp009) with SMTP; 15 May 2007 07:51:33 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1/IWtIPSO3I/lly/VvVkeUflG1s7vUN7G15RXjDmy
	RFI0jqQcsNBF2z
Mail-Followup-To: Russell <russellsteicke@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <c1b8b6670705142209x267e44cbrea26aa8818275aea@mail.gmail.com>
User-Agent: Mutt/1.5.14+cvs20070403 (2007-04-02)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47315>

On Tue, May 15, 2007 at 01:09:06PM +0800, Russell wrote:
>  On 5/14/07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >         Hi,
> >
> > Has anyone considered using git as a backup tool?  I.e.
> >   - put your whole file system in git
> >   - do `git add .; git commit -a' from cron
> >   - copy .git to external media once in a while
> >   - clean up old stuff (unused and older than xx days) from .git
> 
>  I'm using git to backup my private email, all in Maildir format, in
>  that manner.  In addition, I push to a remote bare repository
>  automatically, using ssh host keys.
> 
>  The most annoying issue was trying to prevent spam getting stuck in
>  the mail history.  I do this by having the "unsure" mail folder in a
>  different place, and then having a symlink from the mail store point
>  there so mutt can still find it easily if needed.
> 
>  Backing up a whole home directory would require careful thought about
>  what _not_ to backup, similar to the spam issue.  You probably
>  wouldn't want to backup things that you download off the net and can
>  easily retrieve again, like foo-1.2.tar.gz etc.
> 
>  I'm not sure what you mean by cleaning up old stuff.  git (or at least
>  my usage of it) requires the whole history to be in the repository.  I
>  haven't looked at shallow clones or other ways to prune history.
> 

There was already a discussion about using git for backup in [1], which
is probabily worth reading. For cleaning up old history Junio explained a
very elegant solution in [2].

-Peter


[1]: http://thread.gmane.org/gmane.comp.version-control.git/33887
[2]: http://article.gmane.org/gmane.comp.version-control.git/34455

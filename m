From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Mon, 15 Jan 2007 22:35:28 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701152154030.20138@iabervon.org>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com>
 <slrneqha0g.5sa.Peter.B.Baumann@xp.machine.xx>
 <E5A7E6A8-45FF-4A7A-A31E-DFEBAD48DF1C@silverinsanity.com>
 <200701131815.27481.alan@chandlerfamily.org.uk>
 <8E585186-FC3F-473B-BA1F-91CFEF1A63F4@silverinsanity.com>
 <20070113203456.GA17648@spearce.org> <Pine.LNX.4.63.0701141340020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070114224204.GA10888@spearce.org> <7v4pqtf699.fsf@assigned-by-dhcp.cox.net>
 <20070115011217.GA11240@spearce.org> <Pine.LNX.4.64.0701151727310.20138@iabervon.org>
 <200701160034.l0G0YC5J005016@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Alan Chandler <alan@chandlerfamily.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 04:35:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6f6k-00034n-1D
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 04:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbXAPDfa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 22:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbXAPDfa
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 22:35:30 -0500
Received: from iabervon.org ([66.92.72.58]:3839 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932070AbXAPDfa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 22:35:30 -0500
Received: (qmail 4552 invoked by uid 1000); 15 Jan 2007 22:35:28 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Jan 2007 22:35:28 -0500
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
In-Reply-To: <200701160034.l0G0YC5J005016@laptop13.inf.utfsm.cl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36919>

On Mon, 15 Jan 2007, Horst H. von Brand wrote:

> Daniel Barkalow <barkalow@iabervon.org> wrote:
> > An config option to prohibit committing with untracked files should be 
> > easy to add.
> 
> Right. And that will annoy the heck out of people who have random litter
> left behind, so their fingers will go "git clean; git commit -a" and then
> "OOoops!!!". If they can't read the commit message template in the first
> place, or train their fingers to "git add" new files immediately...

Or they can avoid enabling the config option if it's not actually helpful 
to them. I don't think it should be the default behavior, but I think it 
should be available to people who tend to make the mistake Shawn 
described. For that matter, it would be nice to have an option for 
filename patterns that shouldn't be left untracked. I end up with plenty 
of junk, but none of it is *.c or *.h, unless the file is one I put in 
.gitignore.

Actually, a "git ignore" command that adds things to .gitignore (like 'for 
i in "$*"; do echo $i >> .gitignore; done; git-update-index --add 
.gitignore') would probably also be helpful. All of the files in my 
directories are one of (1) Things everybody wants to ignore, because 
they're build system output or common backup file patterns, (2) Things 
that should be tracked, because they're source, and (3) Things that 
shouldn't be tracked in the project, but which I want to hang on to, like 
interesting debugging output.

	-Daniel
*This .sig left intentionally blank*

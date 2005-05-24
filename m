From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 23:31:02 +0200
Message-ID: <20050524213102.GB19180@vrfy.org>
References: <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org> <20050524161745.GA9537@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org> <20050524184612.GA23637@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505241236020.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505241259250.2307@ppc970.osdl.org> <20050524202846.GC25606@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505241410380.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	David Mansfield <david@cobite.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 23:32:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dagy2-0000vF-PW
	for gcvg-git@gmane.org; Tue, 24 May 2005 23:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbVEXVbO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 17:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbVEXVbN
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 17:31:13 -0400
Received: from soundwarez.org ([217.160.171.123]:46222 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262194AbVEXVbG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2005 17:31:06 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 4B0EC3992A; Tue, 24 May 2005 23:31:02 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505241410380.2307@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, May 24, 2005 at 02:13:26PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 24 May 2005, Thomas Glanzmann wrote:
> > 
> > btw:
> > 
> > For the mutt tree there are a few 'empty commits' eg were the
> > parent tree is the same as the current. This is because git ignores
> > .cvsignore and they commited some .cvsignore files without any other
> > deltas. I don't know if you want to handle this. Just a note.
> 
> I don't like source repositories with dot-files, and I thought it was a
> good idea to disallow them, but on the other hand I'd like it even less if
> some CVS-weenie goes and says "I can't convert my project to git without
> potentially losing information".
> 
> So in the name of furthering humanity through allowing people to migrate
> away from CVS, I'm considering making the git dot-file check be more
> specific to "." ".." and ".git". After all, project-specific rules might
> have their own porcelain-related ignore-files that cause dot-files to
> never appear..

What about allowing to put some file inside of .git/ under revision-control
too? Wouldn't it be nice to have something like an "ignore" file or other
repository meta-data managed by git itself.

Kay

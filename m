From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] rename dirlink to gitlink.
Date: Tue, 22 May 2007 13:53:53 +0200
Message-ID: <20070522115353.GI4489@pasky.or.cz>
References: <20070521200828.GC5412@admingilde.org> <e7bda7770705211612w3ce1b7dew8d48f1ddeb7d100e@mail.gmail.com> <7vodkdbvmk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torgil Svensson <torgil.svensson@gmail.com>,
	Martin Waitz <tali@admingilde.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 22 13:54:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqSwD-0005Jc-By
	for gcvg-git@gmane.org; Tue, 22 May 2007 13:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756431AbXEVLxz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 07:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758225AbXEVLxz
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 07:53:55 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53757 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756431AbXEVLxy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 07:53:54 -0400
Received: (qmail 24291 invoked by uid 2001); 22 May 2007 13:53:53 +0200
Content-Disposition: inline
In-Reply-To: <7vodkdbvmk.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48095>

On Tue, May 22, 2007 at 01:32:51AM CEST, Junio C Hamano wrote:
> "Torgil Svensson" <torgil.svensson@gmail.com> writes:
> 
> > On 5/21/07, Martin Waitz <tali@admingilde.org> wrote:
> >> Unify naming of plumbing dirlink/gitlink concept:
> >>
> >> perl -pi -e 's/dirlink/gitlink/g' -e 's/DIRLNK/GITLINK/g'
> >> ---
> >
> > Does this mean that the link doesn't necessarily has to be represented
> > as a directory (even though current code does it) ?
> 
> I do not think the patch has that much deep meaning.
> 
> Personally I think the patch is similar to renaming "cache" used
> in the code to "index" --- needless code shuffling that does not
> buy you anything.

FWIW, I seriously considered making a patch for that several times - but
always found something better to do; that is, it is not so big an itch
for me to scratch unless I'd be really bored and miss some goot git@
flamewar badly ;-). However, I still think that using "cache" in the
code is a mistake - it's confusing and inconsistent.

(BTW, the other thing I hate about the codebase are the filenames. When
I want to look at the source of some command, I have to try THREE names:
git-something.<tab> (sh, perl, ...), builtin-something.c and
something.c. I wish I could just write git-something.<tab>. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett

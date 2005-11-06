From: Petr Baudis <pasky@suse.cz>
Subject: Re: git binary directory?
Date: Sun, 6 Nov 2005 09:28:30 +0100
Message-ID: <20051106082830.GO1431@pasky.or.cz>
References: <7voe4y5w3v.fsf@assigned-by-dhcp.cox.net> <200511060312.jA63CUcv010887@inti.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 06 09:29:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYftE-00089E-HY
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 09:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbVKFI2d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 03:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbVKFI2d
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 03:28:33 -0500
Received: from w241.dkm.cz ([62.24.88.241]:39371 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932330AbVKFI2c (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Nov 2005 03:28:32 -0500
Received: (qmail 27349 invoked by uid 2001); 6 Nov 2005 09:28:30 +0100
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Content-Disposition: inline
In-Reply-To: <200511060312.jA63CUcv010887@inti.inf.utfsm.cl>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11196>

Dear diary, on Sun, Nov 06, 2005 at 04:12:30AM CET, I got a letter
where Horst von Brand <vonbrand@inf.utfsm.cl> told me that...
> Junio C Hamano <junkio@cox.net> wrote:
> >                                                    we need to
> > teach some of our commands that use other git commands to
> > prepend /usr/lib/git/ (or /usr/libexec/git)
> 
> AFAIU, /usr/libexec/git (or /usr/libexec/git-<version>) would be better.
> Including the version would make it possible to have the last stable and a
> development version coexisting, like gcc does with -V. Or its -B option,
> which tells it where to find the executables that do the real work.

In Cogito, when including the lib programs, I'm doing

	. ${COGITO_LIB}cg-Xlib || exit 1

and then during installation I do:

	sed -e 's/\$${COGITO_LIB}/"\$${COGITO_LIB:-$(libdir)\/}"/g'

Then I can override it during execution by exporting $COGITO_LIB.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.

From: Junio C Hamano <junkio@cox.net>
Subject: Tool renames.
Date: Wed, 07 Sep 2005 18:04:11 -0700
Message-ID: <7vfysg2wvo.fsf_-_@assigned-by-dhcp.cox.net>
References: <200509050054.j850sC3D023778@laptop11.inf.utfsm.cl>
	<Pine.LNX.4.58.0509050738340.3504@evo.osdl.org>
	<46a038f90509051713389c62c8@mail.gmail.com>
	<Pine.LNX.4.58.0509060013520.4316@evo.osdl.org>
	<7vll2atz8a.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509060057491.4316@evo.osdl.org>
	<7vwtlusi9t.fsf@assigned-by-dhcp.cox.net>
	<u5tek82bmlb.fsf@fidgit.hq.vtech>
	<7v1x41g3c6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <davidk@lysator.liu.se>, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Sep 08 03:04:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDApt-0000fa-8S
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 03:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbVIHBEP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Sep 2005 21:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbVIHBEP
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Sep 2005 21:04:15 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:35490 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932495AbVIHBEO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2005 21:04:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050908010411.BFXM6784.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 7 Sep 2005 21:04:11 -0400
To: git@vger.kernel.org
In-Reply-To: <7v1x41g3c6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 06 Sep 2005 16:54:01 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8184>

Junio C Hamano <junkio@cox.net> writes:

> My proposal to have git-archimport.perl in the source tree and
> install it as $(bindir)/git-archimport solves the editability
> issues (sorry, Linus, you will have to say "em *.sh *.perl"
> instead of "em *-script" if we did this) and simplifies the
> first half of the 'git' wrapper (it just needs to attempt
> running "git-$1"), but does not help what the latter half of
> 'git' wrapper does (to give you the list of Porcelainish
> commands).
>
> To make 'git' wrapper produce useful 'list of subcommands', we
> need to come up with a list of Porcelainish commands, be they
> written in C or sh or Perl, and tell 'git' about that list.
> Current implementation cheats by assuming everything that ends
> with *-script are such, but it does not have to stay that way.

I have done this and the first commit since 0.99.6 in the
proposed updates branch contains the big rename.

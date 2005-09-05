From: Junio C Hamano <junkio@cox.net>
Subject: Re: Tool renames? was Re: First stab at glossary
Date: Mon, 05 Sep 2005 11:13:05 -0700
Message-ID: <7vr7c35qoe.fsf@assigned-by-dhcp.cox.net>
References: <200509050054.j850sC3D023778@laptop11.inf.utfsm.cl>
	<Pine.LNX.4.58.0509050738340.3504@evo.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Tim Ottinger <tottinge@progeny.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 20:14:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECLSz-0002Qf-1N
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 20:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbVIESNJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 14:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbVIESNJ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 14:13:09 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:60819 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932372AbVIESNI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2005 14:13:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050905181307.XCAO8185.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Sep 2005 14:13:07 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509050738340.3504@evo.osdl.org> (Linus Torvalds's
	message of "Mon, 5 Sep 2005 07:41:30 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8105>

Linus Torvalds <torvalds@osdl.org> writes:

> ... and I don't see _any_ point to naming 
> by what _kind_ of interpreter you use. Why would _anybody_ care whether 
> something is written in perl vs shell?

One possibility that comes to mind is to again help developers
who use an editor that is syntax-aware and looks *only* at
filename suffix to figure out which language syntax to use
(Emacs is not one of them -- it knows how to read #! line).

Another is, although we do not currently do it, to make the
Makefile simpler if/when we start to do the interpreter line
munging ("#!/usr/bin/perl -> #!/usr/local/bin/perl") before
install time.

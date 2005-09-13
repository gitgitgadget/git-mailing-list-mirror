From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Improve "git grep" flags handling
Date: Tue, 13 Sep 2005 11:53:11 -0700
Message-ID: <7v8xy03ilk.fsf@assigned-by-dhcp.cox.net>
References: <200509131739.j8DHdQL1010615@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 13 20:54:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFFu8-0002ai-GA
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 20:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbVIMSxN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 14:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbVIMSxN
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 14:53:13 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:14475 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S964978AbVIMSxN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2005 14:53:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050913185313.GVM8185.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 13 Sep 2005 14:53:13 -0400
To: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <200509131739.j8DHdQL1010615@laptop11.inf.utfsm.cl> (Horst von
	Brand's message of "Tue, 13 Sep 2005 13:39:26 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8478>

Horst von Brand <vonbrand@inf.utfsm.cl> writes:

> Shouldn't shebang go /bin/bash, as the script uses bash-isms now?
> (For portability to non-enlightened systems the installation would have to
> locate bash too... and/or mention this in the INSTALL file)

I heard somebody say the shell arrays actually came from Korn,
so /bin/bash is a wrong thing to do if that is the case.

> Or perhaps redo the mess in Perl or some such?

Especially given 'xargs grep' part is moderately expensive
anyway and startup overhead between shell and perl does not
matter here very much, the suggestion is mildly tempting.

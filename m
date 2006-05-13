From: Junio C Hamano <junkio@cox.net>
Subject: Re: git diff: support "-U" and "--unified" options properly
Date: Sat, 13 May 2006 13:59:37 -0700
Message-ID: <7vzmhlsksm.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605131317200.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 13 23:00:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ff1DI-0007hX-Pn
	for gcvg-git@gmane.org; Sat, 13 May 2006 22:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWEMU7k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 May 2006 16:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWEMU7k
	(ORCPT <rfc822;git-outgoing>); Sat, 13 May 2006 16:59:40 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:48523 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751345AbWEMU7j (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 May 2006 16:59:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060513205938.KXHD19284.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 13 May 2006 16:59:38 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605131317200.3866@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 13 May 2006 13:23:48 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19946>

Linus Torvalds <torvalds@osdl.org> writes:

> [ Maybe this can still hit 1.3.3? ]

Ah, we did not pass the diffopt to the function builtin_diff() in
1.3.X series, so not really.  We could forward port but I do not
know if it is worth the effort of backporting while stripping
the updates of the whole chain of diff generation from the post
1.3.0 "master" work.  I have to think a bit.

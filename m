From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fmt-patch: understand old <his> notation
Date: Sat, 06 May 2006 18:31:38 -0700
Message-ID: <7v8xper56t.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0605062252530.4155@wbgn013.biozentrum.uni-wuerzburg.de>
	<7viroirfur.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605061527030.16343@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 07 03:31:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcY7b-0005LV-4H
	for gcvg-git@gmane.org; Sun, 07 May 2006 03:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWEGBbk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 21:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWEGBbk
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 21:31:40 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:21994 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751173AbWEGBbk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 May 2006 21:31:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060507013139.NQEP17501.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 6 May 2006 21:31:39 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0605061527030.16343@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 6 May 2006 15:30:38 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19687>

Linus Torvalds <torvalds@osdl.org> writes:

> Maybe not. I've actually cursed the fact that I made "git diff X" mean 
> "diff from X to current working tree", because it almost never makes any 
> sense at all when X is anything but "HEAD".

Actually, I do "git diff next" all the time while on the tip of
my topic branches, and also when merging a topic branch into
"master".  This "a different tree with the current working
files" is probably the second most frequently used form for me
(the first one is of course HEAD vs working files). 

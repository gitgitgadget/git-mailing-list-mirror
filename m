From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-name-rev off-by-one bug
Date: Tue, 29 Nov 2005 18:06:18 -0800
Message-ID: <7vek4y51ph.fsf@assigned-by-dhcp.cox.net>
References: <20051130001503.28498.qmail@science.horizon.com>
	<Pine.LNX.4.64.0511291742000.3135@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 03:07:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhHMZ-0007wX-5O
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 03:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbVK3CGY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 21:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbVK3CGX
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 21:06:23 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:23962 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750805AbVK3CGX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 21:06:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051130020513.PBAQ17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 29 Nov 2005 21:05:13 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511291742000.3135@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 29 Nov 2005 17:51:38 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12979>

Linus Torvalds <torvalds@osdl.org> writes:

> If we left things in the index in an unmerged state, we'd be guaranteed to 
> either _fail_ that git commit unless somebody has done the 
> git-update-index (or names the files specifically on the commit command 
> line, which will do it for you).
>
> So I think I agree. 

I suspect we are saying the same thing.  Funny.

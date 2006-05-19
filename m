From: Junio C Hamano <junkio@cox.net>
Subject: Re: Libify the index refresh logic
Date: Fri, 19 May 2006 15:36:28 -0700
Message-ID: <7vodxthcb7.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605190942060.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 20 00:36:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhDaC-00047o-H4
	for gcvg-git@gmane.org; Sat, 20 May 2006 00:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWESWga (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 18:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWESWg3
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 18:36:29 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:24319 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751347AbWESWg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 18:36:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060519223628.ZGIL9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 19 May 2006 18:36:28 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605190942060.10823@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 19 May 2006 09:56:35 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20362>

Linus Torvalds <torvalds@osdl.org> writes:

> This cleans up and libifies the "git update-index --[really-]refresh" 
> functionality. This will be eventually required for eventually doing the 
> "commit" and "status" commands as built-ins.

Thanks.

With the recent torrent of moving functions around across files
without necessarily making the old file empty (thus resulting in
what some people call "file rename"), the Porcelainish people
would have enough testcases to think about how to handle merges
that involve with cases like these.

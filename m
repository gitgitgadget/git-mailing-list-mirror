From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] add strcpy_user_path() and use it in init-db.c and git.c
Date: Sat, 24 Dec 2005 10:08:38 -0800
Message-ID: <7virtes6zd.fsf@assigned-by-dhcp.cox.net>
References: <20051224122016.GD3963@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 24 19:08:54 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EqDp3-0006tg-GH
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 19:08:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbVLXSIk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Dec 2005 13:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbVLXSIk
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Dec 2005 13:08:40 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:5332 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932157AbVLXSIj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Dec 2005 13:08:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051224180704.BPGX17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Dec 2005 13:07:04 -0500
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20051224122016.GD3963@mail.yhbt.net> (Eric Wong's message of
	"Sat, 24 Dec 2005 04:20:16 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14029>

Eric Wong <normalperson@yhbt.net> writes:

> Hint: build git with: make 'prefix=~'

Sorry, I do not see why you would want to do this.  I understand
"make prefix=~" or "make prefix=$HOME", but "make prefix='~'"
and expanding tilde and friends at runtime you need to justify
why it helps in which situation.

We are not DOS and do not do argument expansion shell should
have done for us ourselves.

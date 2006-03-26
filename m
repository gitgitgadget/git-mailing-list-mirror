From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Do not print header in diff-tree --root unless asked to
Date: Sat, 25 Mar 2006 16:48:36 -0800
Message-ID: <7vu09mt4ij.fsf@assigned-by-dhcp.cox.net>
References: <20060325232807.9146.12846.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 26 01:48:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNJQv-0007ah-QV
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 01:48:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWCZAsj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 19:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWCZAsj
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 19:48:39 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:48328 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932095AbWCZAsi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 19:48:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060326004838.QUWT6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Mar 2006 19:48:38 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060325232807.9146.12846.stgit@machine.or.cz> (Petr Baudis's
	message of "Sun, 26 Mar 2006 00:28:07 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18011>

Petr Baudis <pasky@suse.cz> writes:

> ... git-diff-tree would always return the sha1 of the commit
> when --root was passed.

I am not sure why this change is needed.

The output from "git-diff-tree --root e83c51" (the very initial
"git") and "git-diff-tree 8bc9a0" (the second commit) without
any other parameters (specifically, there is no '-v') look
comparable right now, but I suspect this change would break it.

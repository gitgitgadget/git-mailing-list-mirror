From: Junio C Hamano <junkio@cox.net>
Subject: Re: Support "git cmd --help" syntax
Date: Sat, 15 Apr 2006 13:54:19 -0700
Message-ID: <7vsloeef0k.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0604151054380.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 22:54:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUrmi-0006qf-OE
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 22:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWDOUyV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 16:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWDOUyV
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 16:54:21 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:45028 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751460AbWDOUyV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 16:54:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060415205420.HIUI8660.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 15 Apr 2006 16:54:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604151054380.3701@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 15 Apr 2006 11:13:49 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18763>

Linus Torvalds <torvalds@osdl.org> writes:

> However, as anybody who has ever used CVS or some similar devil-spawn 
> program, it's confusing as h*ll when options before the sub-command act 
> differently from options after the sub-command, so this quick hack just 
> makes it acceptable to do "git cmd --help" instead, and get the exact same 
> result.
>
> It may be hacky, but it's simple and does the trick.

Tried "git commit --help" with and without the patch?

I am not sure if we want to "help" migrants from CVS or some
similar program by shooting ourselves in the foot.

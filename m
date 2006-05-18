From: Junio C Hamano <junkio@cox.net>
Subject: Re: Make "git rev-list" be a builtin
Date: Thu, 18 May 2006 14:50:11 -0700
Message-ID: <7vejyrngto.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605181415090.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 23:50:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgqNt-0004tb-MW
	for gcvg-git@gmane.org; Thu, 18 May 2006 23:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWERVuO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 17:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWERVuO
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 17:50:14 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:40844 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932155AbWERVuM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 17:50:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060518215012.KKLJ25666.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 18 May 2006 17:50:12 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605181415090.10823@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 18 May 2006 14:19:20 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20305>

Linus Torvalds <torvalds@osdl.org> writes:

> This was surprisingly easy. The diff is truly minimal: rename "main()" to 
> "cmd_rev_list()" in rev-list.c, and rename the whole file to reflect its 
> new built-in status.
>
> We should have done this long ago.

Should we have?

Certainly it is almost trivial, and it means we need to worry
about one less file, but is that the point?

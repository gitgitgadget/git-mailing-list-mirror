From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-count-objects --all support
Date: Sat, 21 Jan 2006 19:48:19 -0800
Message-ID: <7vd5ikhqik.fsf@assigned-by-dhcp.cox.net>
References: <20060122022718.16375.78611.stgit@machine.or.cz>
	<7vslrhht8b.fsf@assigned-by-dhcp.cox.net>
	<20060122030215.GT28365@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 22 04:48:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0WDP-0004ln-50
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 04:48:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWAVDsV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 22:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWAVDsV
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 22:48:21 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:43673 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932240AbWAVDsU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 22:48:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060122034618.FYAG17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 Jan 2006 22:46:18 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060122030215.GT28365@pasky.or.cz> (Petr Baudis's message of
	"Sun, 22 Jan 2006 04:02:15 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15044>

Petr Baudis <pasky@suse.cz> writes:

>> The point of counting objects is to see if it is time to repack,
>> so the warning is something I am quite hesitant to accept, even
>> with a suppression option.
>
> Then please change the command name - it is very confusing this way;

True.  count-loose-objects would have been a good name, if it
were named that way from the beginning.

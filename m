From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] 'Download' stat
Date: Sun, 30 Apr 2006 00:11:30 -0700
Message-ID: <7vslnvzgf1.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550604292159t5fac5436q73aecd5dbd56f516@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 30 09:11:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fa65f-0000pi-HH
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 09:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWD3HLc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 03:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbWD3HLc
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 03:11:32 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:10229 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751017AbWD3HLc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Apr 2006 03:11:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060430071131.OPBQ27327.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 30 Apr 2006 03:11:31 -0400
To: "Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <e5bfff550604292159t5fac5436q73aecd5dbd56f516@mail.gmail.com>
	(Marco Costalba's message of "Sun, 30 Apr 2006 06:59:56 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19329>

"Marco Costalba" <mcostalba@gmail.com> writes:

> Hi all,
>
>     none is interested in (writing ;-)  ) a kind of 'download' summary stat?
>
> If git-daemon after a connection could save a record with fields like:
>
> - date
> - command requested (clone, pull, etc..)
> - current HEAD
>
> Perhaps would be possible to show nice stat/graph about repository
> activity and most downloaded repository content tags.

Perhaps "git-daemon --verbose --syslog".  Grep for loginfo in
daemon.c for details.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: git --version
Date: Wed, 31 May 2006 12:06:39 -0700
Message-ID: <7vac8yypxc.fsf@assigned-by-dhcp.cox.net>
References: <4d8e3fd30605301516l782ad81dk5b11074e88db90a4@mail.gmail.com>
	<7vu077ywmw.fsf@assigned-by-dhcp.cox.net>
	<4d8e3fd30605311158n9d669dgd6c392ee8d194b78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed May 31 21:06:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlW1j-0006YI-T6
	for gcvg-git@gmane.org; Wed, 31 May 2006 21:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965097AbWEaTGl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 15:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965099AbWEaTGl
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 15:06:41 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:37825 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S965097AbWEaTGk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 15:06:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060531190640.DIEV27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 31 May 2006 15:06:40 -0400
To: git@vger.kernel.org
In-Reply-To: <4d8e3fd30605311158n9d669dgd6c392ee8d194b78@mail.gmail.com>
	(Paolo Ciarrocchi's message of "Wed, 31 May 2006 20:58:52 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21075>

"Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> writes:

> paolo@Italia:~$ cd git/
> paolo@Italia:~/git$ git --version
> git version 1.3.GIT
> paolo@Italia:~/git$ make >/dev/null
> paolo@Italia:~/git$ sudo make install >/dev/null
> Password:
> GIT_VERSION = 1.3.GIT

Unfortunate is we cannot see what this "sudo" did -- does it
successfully run (installed) git to check the "full" version and
manage to store it in ./GIT-VERSION-FILE?

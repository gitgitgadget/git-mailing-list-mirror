From: Junio C Hamano <junkio@cox.net>
Subject: Re: git --version
Date: Tue, 30 May 2006 15:29:27 -0700
Message-ID: <7vu077ywmw.fsf@assigned-by-dhcp.cox.net>
References: <4d8e3fd30605301516l782ad81dk5b11074e88db90a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 31 00:29:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlCiS-0004dD-6n
	for gcvg-git@gmane.org; Wed, 31 May 2006 00:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWE3W33 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 18:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbWE3W33
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 18:29:29 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:61355 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932524AbWE3W33 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 May 2006 18:29:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060530222928.HYOD27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 30 May 2006 18:29:28 -0400
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
In-Reply-To: <4d8e3fd30605301516l782ad81dk5b11074e88db90a4@mail.gmail.com>
	(Paolo Ciarrocchi's message of "Wed, 31 May 2006 00:16:30 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21046>

"Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> writes:

> I'm confused by the following:
> paolo@Italia:~/git$ ./GIT-VERSION-GEN
> GIT_VERSION = 1.3.3.g2186
>
> paolo@Italia:~/git$ git --version
> git version 1.3.GIT
>
> Why git --version is not reporting the "full" version number?

There is a bit of chicken and egg problem involved.  The build
procedure wants to have an already installed git to figure out
the "full" version number.  If you are bootstrapping, make clean
and rebuild after you install git once would give you a git
binary that knows what version it is.

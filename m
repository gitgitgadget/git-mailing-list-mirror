From: Junio C Hamano <junkio@cox.net>
Subject: Re: Question on GIT tutorial.
Date: Thu, 17 Nov 2005 11:47:27 -0800
Message-ID: <7vlkznt5tc.fsf@assigned-by-dhcp.cox.net>
References: <cda58cb80511140220n26da3edm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 20:50:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcpjY-0005M1-0v
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 20:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbVKQTr3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 14:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbVKQTr3
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 14:47:29 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:31916 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S964812AbVKQTr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 14:47:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051117194651.CYJG20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 17 Nov 2005 14:46:51 -0500
To: Franck <vagabon.xyz@gmail.com>
In-Reply-To: <cda58cb80511140220n26da3edm@mail.gmail.com>
	(vagabon.xyz@gmail.com's message of "Mon, 14 Nov 2005 11:20:23 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12149>

Franck <vagabon.xyz@gmail.com> writes:

> Hi,
>
> I have a question about the GIT tutorial. At page 21, there is a
> description of "subsystem maintainer" work cycle, I don't understand
> why point 3 is needed. This point tells:
>
> """
> Copy over the packed files from "project lead" public repository to
> your public repository.
> """
>
> Why is it needed ?

That was a remnant from the days some transports did not
understand objects/info/alternates; I think we do not need that
step anymore.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-log output changed from 1.4.0 -> 1.4.1?
Date: Thu, 06 Jul 2006 14:58:03 -0700
Message-ID: <7vlkr65rbo.fsf@assigned-by-dhcp.cox.net>
References: <761519800607061451n9473ad4oa9e2781517ca9389@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 06 23:58:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FybrO-0004O8-87
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 23:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWGFV6H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 17:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWGFV6H
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 17:58:07 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:63455 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750787AbWGFV6F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jul 2006 17:58:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060706215805.FTYV18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 6 Jul 2006 17:58:05 -0400
To: "Robin Luckey" <robinluckey@gmail.com>
In-Reply-To: <761519800607061451n9473ad4oa9e2781517ca9389@mail.gmail.com>
	(Robin Luckey's message of "Thu, 6 Jul 2006 14:51:23 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23406>

"Robin Luckey" <robinluckey@gmail.com> writes:

> In git 1.4.0, the following command...
>
> git log -r --root --abbrev=40 master

After Timo's diff options rewrite, -r does not seem to
automatically imply diff output anymore.  I personally think it
should.

In the meantime, "git log --raw -r ..." would give you want you
want, I think.

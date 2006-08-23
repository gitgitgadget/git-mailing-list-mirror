From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] gitweb: Whitespace cleanup: realign, reindent
Date: Wed, 23 Aug 2006 02:55:38 -0700
Message-ID: <7vac5vixnp.fsf@assigned-by-dhcp.cox.net>
References: <200608221651.19629.jnareb@gmail.com>
	<200608221652.50443.jnareb@gmail.com>
	<7virkkjkvd.fsf@assigned-by-dhcp.cox.net> <ech55l$reh$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 23 11:56:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFpSd-0003tw-Lw
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 11:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbWHWJzk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 05:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbWHWJzk
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 05:55:40 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:35032 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751515AbWHWJzj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Aug 2006 05:55:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060823095539.TYTF4015.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 23 Aug 2006 05:55:39 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ech55l$reh$1@sea.gmane.org> (Jakub Narebski's message of "Wed,
	23 Aug 2006 10:55:22 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25906>

Jakub Narebski <jnareb@gmail.com> writes:

> So what is the default? 5-column tabs? 8-column tabs? And to what width?
> 80-column wide? 120-column wide?

Quoting the person who invented git:

                    Chapter 1: Indentation

    Tabs are 8 characters, and thus indentations are also 8 characters.
    There are heretic movements that try to make indentations 4 (or even 2!)
    characters deep, and that is akin to trying to define the value of PI to
    be 3.

    Rationale: The whole idea behind indentation is to clearly define where
    a block of control starts and ends.  Especially when you've been looking
    at your screen for 20 straight hours, you'll find it a lot easier to see
    how the indentation works if you have large indentations.

    Now, some people will claim that having 8-character indentations makes
    the code move too far to the right, and makes it hard to read on a
    80-character terminal screen.  The answer to that is that if you need
    more than 3 levels of indentation, you're screwed anyway, and should fix
    your program.

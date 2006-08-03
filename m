From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 9/10] Remove cmd_usage() routine and re-organize the help/usage code.
Date: Thu, 03 Aug 2006 12:30:50 -0700
Message-ID: <7vr6zxpqfp.fsf@assigned-by-dhcp.cox.net>
References: <000101c6b72a$51601a80$c47eedc1@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 03 21:31:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8iuG-0001If-G9
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 21:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWHCTax (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 15:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWHCTax
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 15:30:53 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:10135 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932466AbWHCTaw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Aug 2006 15:30:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060803193051.BFJY6303.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 3 Aug 2006 15:30:51 -0400
To: "Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
In-Reply-To: <000101c6b72a$51601a80$c47eedc1@ramsay1.demon.co.uk> (Ramsay
	Jones's message of "Thu, 3 Aug 2006 19:26:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24749>

"Ramsay Jones" <ramsay@ramsay1.demon.co.uk> writes:

> In any event, I'm sorry to have broken your test,

Don't worry.  My primary function while wearing the "maintainer"
hat is to catch mistakes like this; even if this test breakage
slipped through, it would not have been your fault but mine.

> ... I should have
> documented the changed behaviour. The change should be limited to
> a lower-case usage prefix and a change in exit code from 1 to 129.

I think both are good changes.  The native usage() exits with 129
so it would be consistent for the git wrapper to exit with 129
when it gives usage message, and in lowercase.

Will take a look at your patches when I go home (I am at day-job
today).

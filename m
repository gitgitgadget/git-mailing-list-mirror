From: Junio C Hamano <junkio@cox.net>
Subject: Re: rebasing trouble
Date: Thu, 29 Jun 2006 18:12:32 -0700
Message-ID: <7v3bdno39b.fsf@assigned-by-dhcp.cox.net>
References: <20060629194723.GD14287@fieldses.org>
	<20060629215725.GI14287@fieldses.org>
	<7vlkrfoaky.fsf@assigned-by-dhcp.cox.net>
	<20060629234502.GB10041@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 03:12:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw7Yk-0004pC-LZ
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 03:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWF3BMe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 21:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWF3BMe
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 21:12:34 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:5017 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751376AbWF3BMd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 21:12:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060630011233.GPPX6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Jun 2006 21:12:33 -0400
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20060629234502.GB10041@fieldses.org> (J. Bruce Fields's message
	of "Thu, 29 Jun 2006 19:45:02 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22939>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> I don't know why I find that syntax so counterintuitive.  Something like
>
> 	git checkout -b newgood master
> 	git cherry-pick next..good
>
> would seem more obvious.

Yes.  Everybody loves to hate this syntax.

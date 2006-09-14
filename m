From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Handle invalid argc gently
Date: Thu, 14 Sep 2006 09:53:36 -0700
Message-ID: <7virjq4cfj.fsf@assigned-by-dhcp.cox.net>
References: <20060914010409.GB20593@nomad.office.altlinux.org>
	<7vu03b5k0t.fsf@assigned-by-dhcp.cox.net>
	<20060914013146.GD7044@basalt.office.altlinux.org>
	<7vpsdz5542.fsf@assigned-by-dhcp.cox.net>
	<20060914131626.GE6709@basalt.office.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 14 18:53:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNuT7-0002NB-Fq
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 18:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWINQxi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 12:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWINQxi
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 12:53:38 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:18357 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750743AbWINQxh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 12:53:37 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060914165337.YEK6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Thu, 14 Sep 2006 12:53:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NGtS1V0041kojtg0000000
	Thu, 14 Sep 2006 12:53:26 -0400
To: "Dmitry V. Levin" <ldv@altlinux.org>
In-Reply-To: <20060914131626.GE6709@basalt.office.altlinux.org> (Dmitry
	V. Levin's message of "Thu, 14 Sep 2006 17:16:26 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27012>

"Dmitry V. Levin" <ldv@altlinux.org> writes:

>> What is the valid reason to do execlp("git", NULL, NULL)?
>
> Personally I do not plan to execute git this way on regular basis, indeed. :)
>
> But argc == 0 is allowed, so why should git crash?

Oh, no I was not arguing for making git crash.  I was just
trying to learn if there is a valid reason to choose to, or
common misconfiguration that causes it to, run with ac == 0,
since I did not think of any.

It is good to be extra careful and defensive -- I just wanted to
know if there is more to it.

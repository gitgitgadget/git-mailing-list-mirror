From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT 1.4.3-rc2
Date: Tue, 10 Oct 2006 10:42:33 -0700
Message-ID: <7vpsd02hkm.fsf@assigned-by-dhcp.cox.net>
References: <7viris63xz.fsf@assigned-by-dhcp.cox.net>
	<20061010093914.GC8612@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 19:42:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXLcj-0003Jh-JY
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 19:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWJJRmf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 13:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWJJRmf
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 13:42:35 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:11915 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751047AbWJJRme (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 13:42:34 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061010174234.UEDC26416.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Oct 2006 13:42:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Yhic1V00X1kojtg0000000
	Tue, 10 Oct 2006 13:42:37 -0400
To: Martin Waitz <tali@admingilde.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28640>

Martin Waitz <tali@admingilde.org> writes:

> have you looked into the git-fetch --update-head-ok thing I sent last
> week?

I remember seeing it and wondering what workflow would need it.
Also at the same time I wondered if it was indeed needed for a
workflow why that workflow can get away with adding only that
option to git-fetch without either adding more things to it or
have a custom porcelain that drives the underlying
git-fetch-pack directly.

In the end I dropped it on the floor because what I wondered
about was not clear from the proposed commit log message.

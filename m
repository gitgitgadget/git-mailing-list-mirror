From: Junio C Hamano <junkio@cox.net>
Subject: Re: Release 1.4.2 build failure
Date: Tue, 10 Oct 2006 15:11:23 -0700
Message-ID: <7vejtfzur8.fsf@assigned-by-dhcp.cox.net>
References: <452C00FD.1020307@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 00:11:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXPou-0005x4-QT
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 00:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030571AbWJJWLZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 18:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030572AbWJJWLZ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 18:11:25 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:52430 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1030571AbWJJWLY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 18:11:24 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061010221124.LJSZ18985.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Oct 2006 18:11:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YmBT1V0071kojtg0000000
	Tue, 10 Oct 2006 18:11:27 -0400
To: Phillip Susi <psusi@cfl.rr.com>
In-Reply-To: <452C00FD.1020307@cfl.rr.com> (Phillip Susi's message of "Tue, 10
	Oct 2006 16:22:21 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28674>

Are you by any chance running the test with the stdin connected
to </dev/null?

If so, the fix is in 1.4.2.2.

BTW, the latest "maint" release is 1.4.2.3 and we have 1.4.3-rc2
from the "master" branch.

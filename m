From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsserver: fix "cvs diff" in a subdirectory
Date: Tue, 10 Oct 2006 18:01:15 -0700
Message-ID: <7vslhvy8bo.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0610110032560.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martyn Smith <martyn@catalyst.net.nz>,
	Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Oct 11 03:01:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXSTH-0007ac-V7
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 03:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030419AbWJKBBR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 21:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965144AbWJKBBR
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 21:01:17 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:51860 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S965141AbWJKBBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 21:01:16 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061011010116.BPVD28934.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Oct 2006 21:01:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Yp1J1V00H1kojtg0000000
	Tue, 10 Oct 2006 21:01:19 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0610110032560.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 11 Oct 2006 00:33:28 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28688>

Will park this and the "U for update, M for modified" patch in
"pu", waiting for acks from actual git-cvsserver users.  It
feels it is safe enough change, so with an Ack from Mart[yi]n
it may be woth having it in 1.4.3

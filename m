From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Teach git-branch -v and -w options
Date: Sun, 22 Oct 2006 12:35:25 -0700
Message-ID: <7vmz7o5eki.fsf@assigned-by-dhcp.cox.net>
References: <1161516626749-git-send-email-hjemli@gmail.com>
	<11615166273819-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 21:35:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbj6c-0007TQ-67
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 21:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWJVTf1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 15:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbWJVTf1
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 15:35:27 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:153 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751022AbWJVTf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 15:35:27 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061022193526.QBMI13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Oct 2006 15:35:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id dXbW1V00F1kojtg0000000
	Sun, 22 Oct 2006 15:35:30 -0400
To: Lars Hjemli <hjemli@gmail.com>
In-Reply-To: <11615166273819-git-send-email-hjemli@gmail.com> (Lars Hjemli's
	message of "Sun, 22 Oct 2006 13:30:26 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29777>

Lars Hjemli <hjemli@gmail.com> writes:

> This makes git-branch display sha1 and first line of commit
> message for each branch.
>
> Additionaly, the -w option may be used to specify columnwidth
> for branchname (default is 20 characters)
>
> Signed-off-by: Lars Hjemli <hjemli@gmail.com>

If you are going in this direction, probably you would want to
refactor 2/3 a bit differently, so that you do not have to
duplicate the same printf for local and remote cases?

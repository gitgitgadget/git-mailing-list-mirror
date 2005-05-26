From: Junio C Hamano <junkio@cox.net>
Subject: Re: git full diff output issues..
Date: Thu, 26 May 2005 13:56:52 -0700
Message-ID: <7v64x5bt9n.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261214140.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505261223240.2307@ppc970.osdl.org>
	<Pine.LNX.4.60.0505262036500.16829@hermes-1.csi.cam.ac.uk>
	<Pine.LNX.4.58.0505261316250.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 22:58:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbPQd-0006Cp-Ea
	for gcvg-git@gmane.org; Thu, 26 May 2005 22:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbVEZU6x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 16:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVEZU6v
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 16:58:51 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:47762 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261763AbVEZU4z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 16:56:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050526205653.IOND1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 26 May 2005 16:56:53 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505261316250.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 26 May 2005 13:33:26 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> This means, btw, that the "git --diff" format must _not_ do

LT> 	diff --git a/file /dev/null
LT> 	deleted file mode 100644

I just checked, and both built-in and git-external-diff-script
should be safe about this issue.

So what do you want from me at this point?  Nothing?
 


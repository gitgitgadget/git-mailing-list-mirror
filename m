From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Sun, 05 Mar 2006 11:53:46 -0800
Message-ID: <7vk6b8fz1x.fsf@assigned-by-dhcp.cox.net>
References: <7vacc5jza6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603042058250.13139@g5.osdl.org>
	<7vfylxigxc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603050946280.13139@g5.osdl.org>
	<Pine.LNX.4.64.0603051027400.13139@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 05 20:54:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFzIf-0005jO-46
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 20:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWCETxs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 14:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751616AbWCETxs
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 14:53:48 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:46497 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751012AbWCETxr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 14:53:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060305195059.ZNRS17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Mar 2006 14:50:59 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17241>

I was going through 'whatchanged rev-list.c' but was half-way
when I sent the previous message.  -S'UNINTERESTING|SHOWN' found
this one.

51b1e1713b1ed8e962e994cd0850ea439ad8c3de
Author: Jon Seymour <jon.seymour@gmail.com>
Date:   Mon Jun 20 12:29:38 2005 +1000

    [PATCH] Prevent git-rev-list without --merge-order producing
    dupicates in output

    If b is reachable from a, then:

         git-rev-list a b

    argument would print one of the commits twice.

    This patch fixes that problem. A previous problem fixed it
    for the --merge-order switch.

    Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

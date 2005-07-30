From: Junio C Hamano <junkio@cox.net>
Subject: Re: Display of merges in gitk
Date: Fri, 29 Jul 2005 21:25:41 -0700
Message-ID: <7vy87o6htm.fsf@assigned-by-dhcp.cox.net>
References: <17130.56620.137642.941175@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 06:27:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dyiw9-00005i-7R
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 06:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbVG3E0T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jul 2005 00:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262938AbVG3E0S
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jul 2005 00:26:18 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:46017 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262771AbVG3EZn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2005 00:25:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050730042530.ZLHM550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 30 Jul 2005 00:25:30 -0400
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17130.56620.137642.941175@cargo.ozlabs.ibm.com> (Paul Mackerras's message of "Fri, 29 Jul 2005 20:51:40 -0500")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Paul Mackerras <paulus@samba.org> writes:

> Linus, could you do a pull from the usual place to pick this up?
> (rsync://rsync.kernel.org/pub/scm/gitk/gitk.git).  I also included a
> patch from Junio.

In case you did not notice, /pub/scm/git/git.git/ repository is
under the care of yours truly starting this week.  I've merged
from your tree up to this commit:

    commit c8a4acbf4a7b0f9da3e320877b2b2d12cd58700b
    Author: Paul Mackerras <paulus@samba.org>
    Date:   Fri Jul 29 09:23:03 2005 -0500

      Improve the merge display when the result differs from all parents.

      Now we see if the result is quite similar to one of the parents, and
      if it is, display the result as a diff from that parent.  If the result
      is similar to more than one parent, pick the one that it's most
      similar to.

Thanks for the great tool.

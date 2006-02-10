From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git 1.1.6.g4d44 make test FAILURE report
Date: Fri, 10 Feb 2006 13:38:11 -0800
Message-ID: <7vhd76vqrg.fsf@assigned-by-dhcp.cox.net>
References: <43ED0368.7020204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Feb 10 22:38:17 2006
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1F7fy4-0004hA-00
	for <gcvg-git@gmane.org>; Fri, 10 Feb 2006 22:38:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWBJViN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 16:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWBJViN
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 16:38:13 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:40676 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750956AbWBJViN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 16:38:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060210213535.OHRY26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 10 Feb 2006 16:35:35 -0500
To: gitzilla@gmail.com
In-Reply-To: <43ED0368.7020204@gmail.com> (A. Large Angry's message of "Fri,
	10 Feb 2006 13:19:36 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15888>

Thanks; good catch.  I think we should export GIT_*_{NAME,EMAIL}
variables explicitly for this particular problem.  We probably
do _not_ want to do the same for GIT_*_DATE though.

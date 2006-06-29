From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Rename man1 and man7 variables to man1dir and man7dir
Date: Thu, 29 Jun 2006 13:17:46 -0700
Message-ID: <7v1wt7ra1h.fsf@assigned-by-dhcp.cox.net>
References: <200606292211.28352.jnareb@gmail.com>
	<200606292213.00726.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 22:18:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw2xU-0002R9-VK
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 22:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWF2URt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 16:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbWF2URt
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 16:17:49 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:63979 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751292AbWF2URs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 16:17:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060629201748.GWXE19057.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Jun 2006 16:17:48 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200606292213.00726.jnareb@gmail.com> (Jakub Narebski's message
	of "Thu, 29 Jun 2006 22:13:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22900>

Doesn't this break "make dist-doc" by _REMOVING_ make variables
man1 and man7, which I mentioned earlier?

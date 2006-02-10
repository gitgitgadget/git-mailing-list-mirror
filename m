From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] ls-files: honour per-directory ignore file from higher directories.
Date: Thu, 09 Feb 2006 20:44:31 -0800
Message-ID: <7vhd77zuts.fsf@assigned-by-dhcp.cox.net>
References: <1138125570.24415.11.camel@dv>
	<20060125061140.GA8408@mars.ravnborg.org>
	<7vmzh1eykq.fsf_-_@assigned-by-dhcp.cox.net>
	<1139542730.23725.3.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Ravnborg <sam@ravnborg.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 05:44:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7Q96-0003pi-7F
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 05:44:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWBJEoe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 23:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWBJEod
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 23:44:33 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:43729 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750935AbWBJEod (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 23:44:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060210044211.GLIV17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 23:42:11 -0500
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1139542730.23725.3.camel@dv> (Pavel Roskin's message of "Thu, 09
	Feb 2006 22:38:50 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15865>

Pavel Roskin <proski@gnu.org> writes:

> With this patch, the simplified version of cg-clean passes the cogito
> testsuite.  That's where the original bug was caught.

Thanks for testing it.

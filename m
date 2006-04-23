From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-clone --reference problem?
Date: Sun, 23 Apr 2006 10:50:40 -0700
Message-ID: <7vmzecgozz.fsf@assigned-by-dhcp.cox.net>
References: <1145810080.16166.223.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 23 19:51:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXijW-0003jS-2R
	for gcvg-git@gmane.org; Sun, 23 Apr 2006 19:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWDWRum (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Apr 2006 13:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWDWRum
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Apr 2006 13:50:42 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:61621 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751153AbWDWRum (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Apr 2006 13:50:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060423175041.HOEJ24981.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 23 Apr 2006 13:50:41 -0400
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1145810080.16166.223.camel@shinybook.infradead.org> (David
	Woodhouse's message of "Sun, 23 Apr 2006 17:34:40 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19071>

David Woodhouse <dwmw2@infradead.org> writes:

> Should I expect cloning with alternates using '--reference' to be
> transitive?

Not with the current code and design, but a patch that cleanly
does that can be considered for inclusion.  Adjusting relative
paths obtained from other repositories correctly, and avoiding
circular alternates by mistake would be tricky, though.

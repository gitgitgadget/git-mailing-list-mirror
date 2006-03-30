From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitk: Use git wrapper to run git-ls-remote.
Date: Thu, 30 Mar 2006 10:08:02 -0800
Message-ID: <7v8xqr3iwt.fsf@assigned-by-dhcp.cox.net>
References: <20060330123151.25779.73775.stgit@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 30 20:08:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FP1Z3-00032G-9b
	for gcvg-git@gmane.org; Thu, 30 Mar 2006 20:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWC3SIF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Mar 2006 13:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWC3SIF
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Mar 2006 13:08:05 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:46845 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751350AbWC3SIE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Mar 2006 13:08:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060330180803.NWHB17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 30 Mar 2006 13:08:03 -0500
To: Mark Wooding <mdw@distorted.org.uk>
In-Reply-To: <20060330123151.25779.73775.stgit@metalzone.distorted.org.uk>
	(Mark Wooding's message of "Thu, 30 Mar 2006 13:31:51 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18201>

Mark Wooding <mdw@distorted.org.uk> writes:

> From: Mark Wooding <mdw@distorted.org.uk>
>
> For some reason, the Cygwin Tcl's `exec' command has trouble running
> scripts...

Yup, I've seen this and have a "personal edition" workaround
exactly like yours.  I haven't bothered to put it in even "pu",
because I am reluctant to add an workaround to a problem I do
not understand (and I haven't bothered to try understanding the
problem which happens only on Windows ;-).

Does anybody know what is going on?

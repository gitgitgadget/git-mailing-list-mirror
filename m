From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git-daemon messing up permissions for gitweb
Date: Fri, 09 Jun 2006 13:18:34 -0700
Message-ID: <7vslmem6at.fsf@assigned-by-dhcp.cox.net>
References: <5A14AF34CFF8AD44A44891F7C9FF41050795787F@usahm236.amer.corp.eds.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 09 22:18:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FonRI-0000xP-1v
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 22:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030490AbWFIUSg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 16:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030488AbWFIUSg
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 16:18:36 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:53488 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030490AbWFIUSg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jun 2006 16:18:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060609201835.QTIP5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 9 Jun 2006 16:18:35 -0400
To: "Post, Mark K" <mark.post@eds.com>
In-Reply-To: <5A14AF34CFF8AD44A44891F7C9FF41050795787F@usahm236.amer.corp.eds.com>
	(Mark K. Post's message of "Fri, 9 Jun 2006 16:08:15 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21548>

"Post, Mark K" <mark.post@eds.com> writes:

> Martin is using git over SSH.  I have git-shell in /etc/passwd for his
> account.

Ah, then umask git-shell gets from sshd is too restrictive.
Loosen it and you will be fine.

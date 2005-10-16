From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT 0.99.8d
Date: Sun, 16 Oct 2005 11:22:57 -0700
Message-ID: <7vll0txqwu.fsf@assigned-by-dhcp.cox.net>
References: <7vachadnmy.fsf@assigned-by-dhcp.cox.net>
	<200510161024.37873.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 16 20:23:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERDAF-0005im-8e
	for gcvg-git@gmane.org; Sun, 16 Oct 2005 20:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbVJPSW7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Oct 2005 14:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbVJPSW7
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Oct 2005 14:22:59 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:53692 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751340AbVJPSW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2005 14:22:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051016182232.WKRC11356.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 16 Oct 2005 14:22:32 -0400
To: Ed Tomlinson <tomlins@cam.org>
In-Reply-To: <200510161024.37873.tomlins@cam.org> (Ed Tomlinson's message of
	"Sun, 16 Oct 2005 10:24:37 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10168>

Ed Tomlinson <tomlins@cam.org> writes:

(Obligatory "do not top post" request omitted)

> Debian users beware.  This version introduces a dependency - package: 
> libcurl3-gnutls-dev
> is now needed to build git.

Is this really true?  The one I uploaded was built on this
machine:

: siamese; dpkg -l libcurl\* | sed -ne 's/^ii  //p'
libcurl3          7.14.0-2       Multi-protocol file transfer library, now wi
libcurl3-dev      7.14.0-2       Development files and documentation for libc

Having said that, a tested patch to debian/control to adjust
Build-Depends is much appreciated.

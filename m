From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] contrib/git-svn: add show-ignore command
Date: Sun, 26 Feb 2006 14:53:41 -0800
Message-ID: <7vlkvx7mve.fsf@assigned-by-dhcp.cox.net>
References: <11409493473353-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 26 23:53:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDUlw-0007UW-VO
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 23:53:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWBZWxp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 17:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWBZWxp
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 17:53:45 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:56469 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751423AbWBZWxo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2006 17:53:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060226225048.HJZG26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 26 Feb 2006 17:50:48 -0500
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <11409493473353-git-send-email-normalperson@yhbt.net> (Eric
	Wong's message of "Sun, 26 Feb 2006 02:22:27 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16802>

After Andrew Morten raised the issue, I've made sure I _really_
enable my pre-applypatch hook.

Please enable your pre-commit hook (comes with the distribution
as a sample hook) to catch these trailing whitespaces before
they hit your commit objects.

Applying 'contrib/git-svn: add show-ignore command'

*
* You have some suspicious patch lines:
*
* In contrib/git-svn/git-svn.perl
* trailing whitespace (line 268)
contrib/git-svn/git-svn.perl:268:	
* trailing whitespace (line 276)
contrib/git-svn/git-svn.perl:276:	

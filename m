From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Git.pm: Call external commands using execv_git_cmd()
Date: Thu, 22 Jun 2006 17:08:07 -0700
Message-ID: <7vhd2chgyg.fsf@assigned-by-dhcp.cox.net>
References: <20060622233752.29122.78856.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 23 02:08:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtZDY-00064s-VY
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 02:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbWFWAIK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 20:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbWFWAIJ
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 20:08:09 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:17053 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751665AbWFWAIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 20:08:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060623000808.EBEX12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Jun 2006 20:08:08 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060622233752.29122.78856.stgit@machine.or.cz> (Petr Baudis's
	message of "Fri, 23 Jun 2006 01:37:52 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22387>

Petr Baudis <pasky@suse.cz> writes:

> Instead of explicitly using the git wrapper to call external commands,
> use the execv_git_cmd() function which will directly call whatever
> needs to be called. GitBin option becomes useless so drop it.

I think you meant GitPath here.

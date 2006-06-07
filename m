From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Support for configurable git command aliases (v3)
Date: Tue, 06 Jun 2006 17:29:18 -0700
Message-ID: <7vk67tn6zl.fsf@assigned-by-dhcp.cox.net>
References: <20060607001638.5175.77792.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 02:29:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnlvH-0006sF-8E
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 02:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWFGA3V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 20:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWFGA3V
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 20:29:21 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:56727 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751403AbWFGA3U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 20:29:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060607002919.SHDN18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Jun 2006 20:29:19 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060607001638.5175.77792.stgit@machine.or.cz> (Petr Baudis's
	message of "Wed, 07 Jun 2006 02:16:38 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21422>

I've already swallowed Johannes's patch that also takes good
parts from your patch (most importantly, the part to call
setup_git_directory_gently() so that things can work from a
subdirectory and still find the config) in "next", and I am
hoping to push it out by end of (my) tomorrow.  So I'd
appreciate any improvements (including docs perhaps) on top of
that instead.

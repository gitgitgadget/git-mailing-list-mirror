From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Support for passing path to custom map in git-shortlog.perl
Date: Sun, 06 Nov 2005 16:11:33 -0800
Message-ID: <7vek5twc3u.fsf@assigned-by-dhcp.cox.net>
References: <20051106230757.24941.19267.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 07 01:12:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYubr-00047D-4E
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 01:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbVKGALg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 19:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbVKGALg
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 19:11:36 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:35779 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932378AbVKGALf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 19:11:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051107001051.DMKC29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 6 Nov 2005 19:10:51 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051106230757.24941.19267.stgit@machine.or.cz> (Petr Baudis's
	message of "Mon, 07 Nov 2005 00:07:57 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11241>

Petr Baudis <pasky@suse.cz> writes:

> Aside of looking into .mailmap, add support for -m MAPFILE.

I thought about this when I did .mailmap because I felt 
the more flexibility the better, but wouldn't maintaining the
project-wide .mailmap as part of the project easier to manage?

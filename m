From: Junio C Hamano <junkio@cox.net>
Subject: Re: older git archive access broken in 1.2.0?
Date: Mon, 13 Feb 2006 21:48:17 -0800
Message-ID: <7vek26wkwu.fsf@assigned-by-dhcp.cox.net>
References: <20060214050616.GA28528@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 06:49:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8t3n-0006La-TG
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 06:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbWBNFsV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 00:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030466AbWBNFsV
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 00:48:21 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:44525 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030367AbWBNFsT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 00:48:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060214054823.YCAL25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 14 Feb 2006 00:48:23 -0500
To: Greg KH <greg@kroah.com>
In-Reply-To: <20060214050616.GA28528@kroah.com> (Greg KH's message of "Mon, 13
	Feb 2006 21:06:16 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16113>

Greg KH <greg@kroah.com> writes:

> I was trying to find where something changed in the historical Linux
> kernel git tree:
> 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/
>
> when I noticed that the latest version of git doesn't seem to like this
> archive.  I can't clone it, but 'git log' and 'git whatchanged' seems to
> work fine.

I think 1.2.0 may be a coincidence.  history.git/ mistakenly has
an extra .git subdirectory underneath it.  Removing it should
make things to work again I suspect.

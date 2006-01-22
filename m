From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-count-objects --all support
Date: Sat, 21 Jan 2006 18:49:40 -0800
Message-ID: <7vslrhht8b.fsf@assigned-by-dhcp.cox.net>
References: <20060122022718.16375.78611.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 22 03:49:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0VIX-0003xX-9M
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 03:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWAVCtm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 21:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWAVCtm
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 21:49:42 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:48359 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751254AbWAVCtm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 21:49:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060122024652.PHGW20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 Jan 2006 21:46:52 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060122022718.16375.78611.stgit@machine.or.cz> (Petr Baudis's
	message of "Sun, 22 Jan 2006 03:27:19 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15037>

Petr Baudis <pasky@suse.cz> writes:

> Having command called "git-count-objects" count only unpacked objects is
> a little strange and confusing. This patch adds a warning if packs are
> already present in the current repository,

The point of counting objects is to see if it is time to repack,
so the warning is something I am quite hesitant to accept, even
with a suppression option.  The other way around is probably OK
("please warn me if I have packs"), but feels somewhat pointless.

The --all option might be a welcome addition, though.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Date: Tue, 19 Apr 2005 15:45:02 -0700
Message-ID: <7vpswqpes1.fsf@assigned-by-dhcp.cox.net>
References: <20050419043938.GA23724@kroah.com>
	<20050419185807.GA1191@kroah.com>
	<Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org>
	<426583D5.2020308@mesatop.com> <20050419222609.GE9305@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Cole <elenstev@mesatop.com>,
	Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
	Greg KH <gregkh@suse.de>,
	Git Mailing List <git@vger.kernel.org>,
	linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
X-From: git-owner@vger.kernel.org Wed Apr 20 00:41:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO1P0-00078y-TY
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 00:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVDSWpL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 18:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVDSWpL
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 18:45:11 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:20205 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261716AbVDSWpF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 18:45:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050419224503.CMFN19936.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 19 Apr 2005 18:45:03 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050419222609.GE9305@pasky.ji.cz> (Petr Baudis's message of
 "Wed, 20 Apr 2005 00:26:10 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> I'm wondering if doing

PB> if [ "$(show-diff)" ]; then
PB> 	git diff | git apply
PB> else
PB> 	checkout-cache -f -a
PB> fi

PB> would actually buy us some time; or, how common is it for people to have
PB> no local changes whatsoever, and whether relative slowdown of additional
PB> show-diff to git diff would actually matter.

"show-diff -s" perhaps.  Also wouldn't it be faster to pipe
show-diff output (not git diff output) to patch (not git apply)?



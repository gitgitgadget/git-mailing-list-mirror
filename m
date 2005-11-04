From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem cloning the Linux history tree
Date: Fri, 04 Nov 2005 01:44:41 -0800
Message-ID: <7v1x1w21di.fsf@assigned-by-dhcp.cox.net>
References: <7vmzkl3yl0.fsf@assigned-by-dhcp.cox.net>
	<20051104092146.E5E35353C33@atlas.denx.de>
	<20051104092626.GL1431@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Marcel Holtmann <marcel@holtmann.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 10:45:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXy7q-0005ra-2V
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 10:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161094AbVKDJon (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 04:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161124AbVKDJon
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 04:44:43 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:50901 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1161094AbVKDJon (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 04:44:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051104094357.SOFH776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 4 Nov 2005 04:43:57 -0500
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20051104092626.GL1431@pasky.or.cz> (Petr Baudis's message of
	"Fri, 4 Nov 2005 10:26:26 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11126>

Petr Baudis <pasky@suse.cz> writes:

>> 09:58:42 URL:http://www.denx.de/git/linux-2.6-denx.git/refs/tags/DENX-2005-10-02-18:30 [41/41] -> "refs/tags/DENX-2005-10-02-18:30" [1]

I do not know if Cogito works it around or the above just
happens to work, but (notice colon there) tag names that do not
pass git-check-ref-format(1) are not supported.

>> And I did run git-update-server-info, even with --force.

You may want to double check that all your refs appear in
denx.git/info/refs file, and similarly all your packs are
described in denx.git/objects/info/packs file.

> And what exactly is the problem? It seemed to clone ok.

Oh, if that is the case I would stop worrying about it, then.

However, there is this bit that looks suspicious.

>> Missing object of tag v2.6.14-rc3... unable to retrieve

This does not look like an error message I generate, so I am
assuming it is coming from cg-fetch.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem cloning the Linux history tree
Date: Thu, 03 Nov 2005 19:02:03 -0800
Message-ID: <7vmzkl3yl0.fsf@assigned-by-dhcp.cox.net>
References: <1131008187.6634.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 04:03:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXrqG-0006k6-66
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 04:02:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161118AbVKDDCG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 22:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161119AbVKDDCG
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 22:02:06 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:17058 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1161118AbVKDDCF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 22:02:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051104030205.JXYN9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 3 Nov 2005 22:02:05 -0500
To: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1131008187.6634.14.camel@localhost.localdomain> (Marcel
	Holtmann's message of "Thu, 03 Nov 2005 09:56:26 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11118>

Marcel Holtmann <marcel@holtmann.org> writes:

> # cg-clone http://www.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
> defaulting to local storage area
> 09:53:02 URL:http://www.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/HEAD [41/41] -> "refs/heads/.origin-fetching" [1]
> Getting alternates list
> Getting pack list
> error: The requested URL returned error: 404

That repository is packed but lacks objects/info/packs file.
Perhaps you need to ask tglx to run git-update-server-info in
the repository.

Cloning over git native transport should work, though:

    $ git clone git://git.kernel.org/pub/scm/lin.../history.git history

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [QUESTION] Access to a huge GIT repository.
Date: Wed, 16 Nov 2005 10:24:21 -0800
Message-ID: <7vveys8n8q.fsf@assigned-by-dhcp.cox.net>
References: <cda58cb80511160424j1acac7c6j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 19:25:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcRxO-00017v-7v
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 19:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030418AbVKPSYY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 13:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030425AbVKPSYY
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 13:24:24 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:35755 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030418AbVKPSYX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 13:24:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051116182328.KHXU17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 16 Nov 2005 13:23:28 -0500
To: Franck <vagabon.xyz@gmail.com>
In-Reply-To: <cda58cb80511160424j1acac7c6j@mail.gmail.com>
	(vagabon.xyz@gmail.com's message of "Wed, 16 Nov 2005 13:24:25 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12036>

Franck <vagabon.xyz@gmail.com> writes:

> I'm trying to clone a small part of a big repository.

What Linus has already said...

This is the second time this week the issue came up, so maybe
"large bundled repository, whose users typically are interested
in only one branch" may not be so uncommon as I first expected.
An optional form of 'git-clone' that clones only from a limited
subset of branches might be useful.

The underlying network transfer program, 'git-clone-pack', can
be told to clone only specified branches.  If somebody is
interested, updating the 'git-clone' wrapper to use it should
not be too hard -- obviously this needs to be done for other
transports as well, though.

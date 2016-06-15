From: Junio C Hamano <junkio@cox.net>
Subject: Re: warning merge message
Date: Thu, 21 Dec 2006 16:49:09 -0800
Message-ID: <7vr6us92m2.fsf@assigned-by-dhcp.cox.net>
References: <867728.44872.qm@web31814.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 01:49:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxYb4-00032N-OB
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 01:49:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423166AbWLVAtL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 19:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423168AbWLVAtL
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 19:49:11 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:56254 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423166AbWLVAtK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 19:49:10 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222004909.OGDQ29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Thu, 21 Dec 2006 19:49:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1cpN1W0091kojtg0000000; Thu, 21 Dec 2006 19:49:22 -0500
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <867728.44872.qm@web31814.mail.mud.yahoo.com> (Luben Tuikov's
	message of "Wed, 20 Dec 2006 13:22:59 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35101>

Luben Tuikov <ltuikov@yahoo.com> writes:

> Can we please eliminate this message:
> Warning: No merge candidate found because value of config option
>          "branch.master.merge" does not match any remote branch fetched.

The above message was meant only for "git pull", but was leaked
even when you did "git fetch"; it was a bug and was corrected
already (hopefully).

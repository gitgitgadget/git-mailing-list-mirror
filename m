From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] svnimport: Fix broken tags being generated
Date: Sun, 15 Oct 2006 22:40:00 -0700
Message-ID: <7vpscsx1hr.fsf@assigned-by-dhcp.cox.net>
References: <20061016010037.27259.26157.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 16 07:40:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZLCq-0005iz-Ho
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 07:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbWJPFkE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 01:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWJPFkE
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 01:40:04 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:6549 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751470AbWJPFkB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Oct 2006 01:40:01 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061016054001.YWKC18985.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Mon, 16 Oct 2006 01:40:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id atg41V00T1kojtg0000000
	Mon, 16 Oct 2006 01:40:05 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061016010037.27259.26157.stgit@machine.or.cz> (Petr Baudis's
	message of "Mon, 16 Oct 2006 03:00:37 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28952>

Petr Baudis <pasky@suse.cz> writes:

> Currently git-svnimport generates broken tags missing the timespec in the
> 'tagger' line. This is a random stab at a minimal fix.
>
> Signed-off-by: Petr Baudis <pasky@suse.cz>

Interesting.  Applied.

I remember that older "git tag" does not even add the tagger
line (the kernel history starts using one from 2.6.13-rc4 on Jul
28, 2005).  Does gitweb handle those tags correctly, I wonder?

Especially for 2.6.11-tree tag there is no info you can guess
any "age" information from.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: SIGSEGV in merge recursive
Date: Sat, 30 Dec 2006 18:30:59 -0800
Message-ID: <7vvejshk4c.fsf@assigned-by-dhcp.cox.net>
References: <10871.51671.qm@web31801.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 03:31:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0qTa-0002NX-Lo
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 03:31:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932679AbWLaCbD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 21:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932683AbWLaCbD
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 21:31:03 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:57850 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932679AbWLaCbB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 21:31:01 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061231023100.ZKJS29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Dec 2006 21:31:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5EWE1W00D1kojtg0000000; Sat, 30 Dec 2006 21:30:15 -0500
To: ltuikov@yahoo.com
In-Reply-To: <10871.51671.qm@web31801.mail.mud.yahoo.com> (Luben Tuikov's
	message of "Sat, 30 Dec 2006 17:42:06 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35652>

Luben Tuikov <ltuikov@yahoo.com> writes:

> So it appears that the fix is in "master", but not in "next".
>
> Junio, can you confirm this?

It was merged into 'next' with 1e48a691, about 2 hours after I
merged the fix 5d6b151f to 'master'.  Sometimes when I have a
fix that is urgent enough, I push out only 'master' before
merging and retesting it in 'next', so it is plausible that your
fetch grabbed such a state.

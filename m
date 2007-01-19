From: Junio C Hamano <junkio@cox.net>
Subject: Re: Packfile SHA1 mismatch with itself
Date: Fri, 19 Jan 2007 13:22:10 -0800
Message-ID: <7vlkjyg1a5.fsf@assigned-by-dhcp.cox.net>
References: <510820.93884.qm@web31802.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 22:22:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H81Bf-0004cZ-By
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 22:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbXASVWM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 16:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbXASVWM
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 16:22:12 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:39368 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964867AbXASVWL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 16:22:11 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070119212210.KHMD15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Fri, 19 Jan 2007 16:22:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id D9NT1W00m1kojtg0000000; Fri, 19 Jan 2007 16:22:28 -0500
To: ltuikov@yahoo.com
In-Reply-To: <510820.93884.qm@web31802.mail.mud.yahoo.com> (Luben Tuikov's
	message of "Fri, 19 Jan 2007 12:35:09 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37204>

Luben Tuikov <ltuikov@yahoo.com> writes:

> $GIT_DIR=. git-fsck-objects --full
> error: Packfile ./objects/pack/pack-8cafdff4eb66bb2219016e4c0817cdb5cb326ab6.pack SHA1 mismatch
> with itself

Nothing rings a bell other than:

commit 8977c110b5bbd230c28c727ddb85856067d55cfb
Author: Junio C Hamano <junkio@cox.net>
Date:   Wed Jan 3 23:09:08 2007 -0800

    pack-check.c::verify_packfile(): don't run SHA-1 update on huge data

which is in 1.4.4.4.  'master' has an equilvalent due to the use
of sliding mmap.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: 'git status' is not read-only fs friendly
Date: Fri, 09 Feb 2007 16:16:35 -0800
Message-ID: <7vejoyq330.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
	<Pine.LNX.4.64.0702091148060.8424@woody.linux-foundation.org>
	<7vr6szt71j.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550702091235x74e44362gad5b9b6076a5ea53@mail.gmail.com>
	<Pine.LNX.4.64.0702091253120.8424@woody.linux-foundation.org>
	<7vmz3mq394.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>,
	GIT list <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Feb 10 01:16:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFfuz-0001Wu-8R
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 01:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946795AbXBJAQh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 19:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946794AbXBJAQh
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 19:16:37 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:35037 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946792AbXBJAQg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 19:16:36 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070210001636.YIOT21668.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Fri, 9 Feb 2007 19:16:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id McGa1W00i1kojtg0000000; Fri, 09 Feb 2007 19:16:35 -0500
In-Reply-To: <7vmz3mq394.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 09 Feb 2007 16:12:55 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39204>

Junio C Hamano <junkio@cox.net> writes:

> We could do "git runstatus --refresh", which only updates the
> index in-core.
>
> The patch does two things.

Ah, crap.  Sorry for a wip.

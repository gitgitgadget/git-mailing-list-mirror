From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] Update git-send-email-script with --compose
Date: Mon, 05 Sep 2005 14:10:39 -0700
Message-ID: <7vek832pbk.fsf@assigned-by-dhcp.cox.net>
References: <11258971871874-git-send-email-ryan@michonline.com>
	<46a038f905090504166246dc0a@mail.gmail.com>
	<20050905153705.GD5335@mythryan2.michonline.com>
	<7vll2b4ake.fsf@assigned-by-dhcp.cox.net>
	<46a038f90509051306212d4e93@mail.gmail.com>
	<7vslwj2qty.fsf@assigned-by-dhcp.cox.net>
	<46a038f905090513456d67842b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 23:13:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECOF5-0002in-Ob
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 23:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbVIEVKn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 17:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbVIEVKn
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 17:10:43 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:146 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932541AbVIEVKn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2005 17:10:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050905211040.NOLC3588.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Sep 2005 17:10:40 -0400
To: martin.langhoff@gmail.com
In-Reply-To: <46a038f905090513456d67842b@mail.gmail.com> (Martin Langhoff's
	message of "Tue, 6 Sep 2005 08:45:54 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8117>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> It shows that I was never familiar with the practices of linux
> hackers. I've always read the references to mboxes holding patchbombs
> meaning literally one mbox file with a zillion contatenated patches
> received via email.

To be fair to you, it is _not_ the practices of Linux hackers.
For one thing, I am not among them.  I think it is perfectly
reasonable to expect it to produce a single mailbox, like you
expected.

The primary reason why "format-patch --mbox" only does one file
per patch is because I am too lazy to add a --single-mbox option
which does the "right thing".  This _could_ be "fixed", but on
the other hand the current one file per patch behaviour is
arguably more flexible than always creating a single mbox, and
that is what I use as an excuse to justify my laziness ;-).

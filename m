From: Junio C Hamano <junkio@cox.net>
Subject: Re: "git revert" (Re: pci_update_resource() getting called on sparc64)
Date: Mon, 08 Aug 2005 15:47:56 -0700
Message-ID: <7vd5oo11wj.fsf@assigned-by-dhcp.cox.net>
References: <20050808.103304.55507512.davem@davemloft.net>
	<Pine.LNX.4.58.0508081131540.3258@g5.osdl.org>
	<20050808160846.GA7710@kroah.com>
	<20050808.123209.59463259.davem@davemloft.net>
	<20050808194249.GA6729@kroah.com>
	<Pine.LNX.4.58.0508081249110.3258@g5.osdl.org>
	<Pine.LNX.4.58.0508081257190.3258@g5.osdl.org>
	<7vd5oo40mq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508081357020.3258@g5.osdl.org>
	<7voe882kds.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508081444040.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 00:48:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2GPs-00045K-H3
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 00:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbVHHWsA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 18:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbVHHWr7
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 18:47:59 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:56275 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932330AbVHHWr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 18:47:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050808224758.IDVD8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 Aug 2005 18:47:58 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508081444040.3258@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 8 Aug 2005 14:58:35 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Or if you want to be more CVS-like, use "-F", and accept "-" for stdin?

Yes my vote goes:

	-m "message"
        -c "from this commit, literally."
        -C "from this commit, but let me edit the log further."
        -F "from this file."
        -F - <stdin

> But I like "test -t 0" regardless. Very few editors are ok with non-tty
> stdin, although I could imagine some disturbed individual having "ed" as
> their editor and expecting to be able to pipe commands into it or
> something.

I am a disturbed individual who always works in Emacs and run
"git commit" in the compilation buffer, setting EDITOR to
emacsclient.  Admittably the compilation buffer uses pty, so
"test -t 0" would succeed, though.

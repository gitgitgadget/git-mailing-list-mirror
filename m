From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] ls-tree: remove trailing slashes properly.
Date: Tue, 31 May 2005 15:35:16 -0700
Message-ID: <7vhdgjvxaz.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505310827330.1876@ppc970.osdl.org>
	<7vvf4zvzfw.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505311507010.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 01 00:38:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdFMR-0005mz-2Z
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 00:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVEaWjP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 18:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVEaWhd
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 18:37:33 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:26877 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261201AbVEaWfU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2005 18:35:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050531223517.NRVL7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 31 May 2005 18:35:17 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505311507010.1876@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 31 May 2005 15:19:13 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> I just checked in a fix for this in diffcore-patchspec.c,
LT> I'd hope that ls-tree could get it right too. Removing
LT> trailing slashes is a bandaid that hides one bug by making
LT> it appear as a different bug.

Yes, I am aware of that problem but have not touched it; I sent
an earlier email about this to you.  While I was waiting for
your response, I found that drivers/char/ does not even match
drivers/char tree, which is what the patch you are responding to
is about.  Will look into it later.



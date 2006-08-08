From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Racy git: avoid having to be always too careful
Date: Tue, 08 Aug 2006 16:07:44 -0700
Message-ID: <7vpsfau8qn.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0607310945490.4168@g5.osdl.org>
	<7virl7e8ed.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0608081659320.1800@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vr6zrw352.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0608090030080.1800@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 09 01:08:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAagD-0006Mi-6E
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 01:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbWHHXHs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 19:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965068AbWHHXHr
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 19:07:47 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:25812 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S965053AbWHHXHq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Aug 2006 19:07:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060808230746.LGJA6711.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 8 Aug 2006 19:07:46 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608090030080.1800@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 9 Aug 2006 00:30:40 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25098>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Okay, how about 100 paths? And make _this_ a config variable?

Actually, I have a better patch I'll be pushing out in "next"
this evening.

Hint: ce_write() batches and buffers things, so "now" obtained
in the current code is unreliable.

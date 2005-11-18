From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add .git/version
Date: Thu, 17 Nov 2005 16:49:49 -0800
Message-ID: <7vu0eard8y.fsf@assigned-by-dhcp.cox.net>
References: <11322339372137-git-send-email-matlads@dsmagic.com>
	<200511171644.48438.Josef.Weidendorfer@gmx.de>
	<7v7jb7uler.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511171131260.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Nov 18 01:51:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcuRv-0007qS-6y
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 01:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbVKRAtw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 19:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbVKRAtw
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 19:49:52 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:16270 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751305AbVKRAtv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 19:49:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051118004838.IUMZ17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 17 Nov 2005 19:48:38 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12180>

Linus Torvalds <torvalds@osdl.org> writes:

> My one argument against this is that I don't see why we have to have a 
> separate file for this.

True.

> Why not just add a "core.version" flag to the config file?

True, perhaps core.repository-format-version?

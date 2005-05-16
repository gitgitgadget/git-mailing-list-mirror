From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/4] Implement git-checkout-cache -u to update stat
 information in the cache.
Date: Mon, 16 May 2005 15:34:54 -0700
Message-ID: <7v8y2eol4h.fsf@assigned-by-dhcp.cox.net>
References: <7vll6gqj3z.fsf@assigned-by-dhcp.cox.net>
	<20050516220153.GA8609@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Tue May 17 00:36:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXoBW-0006zw-2s
	for gcvg-git@gmane.org; Tue, 17 May 2005 00:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbVEPWfZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 May 2005 18:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVEPWfR
	(ORCPT <rfc822;git-outgoing>); Mon, 16 May 2005 18:35:17 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:58042 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261912AbVEPWe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2005 18:34:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050516223454.DEWQ8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 16 May 2005 18:34:54 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050516220153.GA8609@pasky.ji.cz> (Petr Baudis's message of
 "Tue, 17 May 2005 00:01:53 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> That reminds me, the patches would be a little easier for me to process
PB> if you followed the /dev/null convention.

Oops, thanks for spotting a bug in "jit-log -p" ;-).


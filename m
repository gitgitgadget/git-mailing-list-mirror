From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-fmt-merge-message problem..
Date: Wed, 12 Jul 2006 22:09:29 -0700
Message-ID: <7vlkqyw0om.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0607122133250.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 13 07:09:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0tSD-0007CG-LP
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 07:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWGMFJc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 01:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbWGMFJc
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 01:09:32 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:16810 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750881AbWGMFJb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 01:09:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060713050931.IBJO6303.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Jul 2006 01:09:31 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607122133250.5623@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 12 Jul 2006 21:38:05 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23813>

Linus Torvalds <torvalds@osdl.org> writes:

> which makes no sense AT ALL. It's doesn't even parse. "Merge commit <repo> 
> of <branch>"? Whaa? That's just insane.
>
> Also, the " * HEAD" is just ugly. It was better before.

Yes, this is a simple mistranslation from Perl to C.  A patch
will follow shortly.

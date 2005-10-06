From: Junio C Hamano <junkio@cox.net>
Subject: Re: clone: I'm only doing a max of 256 requests
Date: Thu, 06 Oct 2005 13:16:51 -0700
Message-ID: <7v1x2y9z9o.fsf@assigned-by-dhcp.cox.net>
References: <20051005191300.GC17475@hexapodia.org>
	<Pine.LNX.4.64.0510051541300.31407@g5.osdl.org>
	<81b0412b0510060641g3a3c6e02m6827370dd61b5ea6@mail.gmail.com>
	<Pine.LNX.4.64.0510060737160.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Andy Isaacson <adi@hexapodia.org>
X-From: git-owner@vger.kernel.org Thu Oct 06 22:19:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENcAl-0006aq-PM
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 22:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbVJFUQ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 16:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbVJFUQ5
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 16:16:57 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:40432 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750913AbVJFUQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2005 16:16:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051006201647.HNAL4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 6 Oct 2005 16:16:47 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510060737160.31407@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 6 Oct 2005 07:39:02 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9781>

Linus Torvalds <torvalds@osdl.org> writes:

> Junio, please apply.

I've been considering about this myself for quite a while, but
haven't done so only because I suspected the removal of the
checks are probably not good enough.  I'll apply the patch, and
we will see what happens.

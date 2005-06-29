From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] denser delta header encoding
Date: Tue, 28 Jun 2005 22:35:34 -0700
Message-ID: <7virzxk9nd.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0506290021050.1667@localhost.localdomain>
	<7vmzp9kbcf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506282217010.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 29 07:28:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnV7n-0005tF-US
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 07:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbVF2Ffj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 01:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262428AbVF2Ffj
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 01:35:39 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:37256 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262427AbVF2Ffg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2005 01:35:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050629053534.HRAD18672.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 29 Jun 2005 01:35:34 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506282217010.19755@ppc970.osdl.org> (Linus Torvalds's message of "Tue, 28 Jun 2005 22:21:37 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Ahh. I see it. "packed_delta_info()". And it looks like "diff" uses it 
LT> too. Oh, for the copy and rename detection. I don't think I tested that 
LT> part, nope.

OK, not too much damage done.  I'll fix the rest up.

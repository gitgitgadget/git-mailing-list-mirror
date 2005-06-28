From: Junio C Hamano <junkio@cox.net>
Subject: Re: CAREFUL! No more delta object support!
Date: Mon, 27 Jun 2005 19:32:32 -0700
Message-ID: <7vslz3yzwf.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0506271755140.19755@ppc970.osdl.org>
	<7vwtofi6jk.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506271910390.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 04:26:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dn5nn-0000gv-QK
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 04:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbVF1Ccm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Jun 2005 22:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbVF1Ccm
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jun 2005 22:32:42 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:12442 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262275AbVF1Cce (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2005 22:32:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050628023233.HQUF17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 27 Jun 2005 22:32:33 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506271910390.19755@ppc970.osdl.org> (Linus
 Torvalds's message of "Mon, 27 Jun 2005 19:13:08 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Fair enough. I'd prefer for the pull/push to push object packs around 
LT> anyway, so there's some more work there..

Yes, I'd prefer that too.

By the way, you broke t/t0000 with the last commit.  Now an
empty GIT_OBJECT_DIRECTORY has 257 subdirectories.

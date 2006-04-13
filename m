From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff-options: add --stat
Date: Thu, 13 Apr 2006 11:55:39 -0700
Message-ID: <7vwtdt1f10.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0604130301240.28688@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v64ld2uyv.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604131138080.14565@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 13 20:55:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FU6ym-0004Nu-Dr
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 20:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWDMSzl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 14:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWDMSzl
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 14:55:41 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:53636 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932435AbWDMSzk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Apr 2006 14:55:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060413185540.JZBD2467.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Apr 2006 14:55:40 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604131138080.14565@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 13 Apr 2006 11:39:22 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18666>

Linus Torvalds <torvalds@osdl.org> writes:

> I think you can just depend on it being in mb[0].ptr[0], no?

Yes that happens to be the case _now_.  I just did not want to
worry about future breakage, in case if Davide ever wants to
change how mb[] is prepared for whatever reason.

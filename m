From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] First cut at libifying revlist generation
Date: Mon, 27 Feb 2006 15:55:30 -0800
Message-ID: <7vu0akwe4t.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602251608160.22647@g5.osdl.org>
	<7vpsl93395.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602261914270.22647@g5.osdl.org>
	<7vy7zx1j6u.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602262119200.22647@g5.osdl.org>
	<Pine.LNX.4.64.0602270851560.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 28 00:55:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDsDQ-00045f-Gm
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 00:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbWB0Xzg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 18:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbWB0Xzg
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 18:55:36 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:54229 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751774AbWB0Xzf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 18:55:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060227235249.IBCQ17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 27 Feb 2006 18:52:49 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602270851560.22647@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 27 Feb 2006 08:54:36 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16895>

Linus Torvalds <torvalds@osdl.org> writes:

> Here's a cleanup patch that does that. It also moves "unpacked" (and the 
> flag parsing) into rev_info, since that actually does affect the revision 
> walker too, and thus logically belongs there.

Makes sense.  Thanks.

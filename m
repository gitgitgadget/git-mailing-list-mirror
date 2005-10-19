From: Junio C Hamano <junkio@cox.net>
Subject: Re: The git protocol and DoS
Date: Wed, 19 Oct 2005 14:54:45 -0700
Message-ID: <7voe5l2mvu.fsf@assigned-by-dhcp.cox.net>
References: <4356A5C5.5080905@zytor.com>
	<7vmzl544f3.fsf@assigned-by-dhcp.cox.net> <4356B2C7.601@zytor.com>
	<Pine.LNX.4.64.0510191410570.3369@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 23:56:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESLth-0004no-Kw
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 23:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbVJSVyr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 17:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbVJSVyr
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 17:54:47 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:52683 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750850AbVJSVyr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 17:54:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051019215413.GRHM24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Oct 2005 17:54:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510191410570.3369@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 19 Oct 2005 14:31:47 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10314>

Linus Torvalds <torvalds@osdl.org> writes:

> But once you're talking to a git-aware 
> SYN-flooder, I don't think a challenge-response makes it any better, since 
> a git-aware SYN-flooder would just be written to give the right response.

I think Peter's point is that the one that can give the right
response needs to read from the server to compute it, and at
that point it is not a "SYN-flooder" anymore.

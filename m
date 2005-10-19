From: Junio C Hamano <junkio@cox.net>
Subject: Re: The git protocol and DoS
Date: Wed, 19 Oct 2005 14:06:36 -0700
Message-ID: <7vek6h43oj.fsf@assigned-by-dhcp.cox.net>
References: <4356A5C5.5080905@zytor.com>
	<7vmzl544f3.fsf@assigned-by-dhcp.cox.net> <4356B2C7.601@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 23:09:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESL90-0000IQ-1Q
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 23:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbVJSVGj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 17:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbVJSVGj
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 17:06:39 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:38562 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751348AbVJSVGi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 17:06:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051019210623.ZMGM9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Oct 2005 17:06:23 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4356B2C7.601@zytor.com> (H. Peter Anvin's message of "Wed, 19
	Oct 2005 13:55:35 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10309>

"H. Peter Anvin" <hpa@zytor.com> writes:

> You mean an option on the *server* to skip the cookie exchange?  If so, 
> how would you expect the client to handle it?

No, what I was thinking was to tell the client "you will be
talking to an old server, so do not try to read that cookie and
get stuck".

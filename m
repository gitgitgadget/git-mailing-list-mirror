From: Junio C Hamano <junkio@cox.net>
Subject: Re: Disallow empty pattern in "git grep"
Date: Wed, 16 Nov 2005 13:18:50 -0800
Message-ID: <7vr79g47gl.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511160934480.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 16 22:21:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcUgB-0003MX-Jd
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 22:18:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030445AbVKPVSx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 16:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030479AbVKPVSx
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 16:18:53 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:16616 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1030445AbVKPVSw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 16:18:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051116211815.LMVS20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 16 Nov 2005 16:18:15 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511160934480.13959@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 16 Nov 2005 09:38:46 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12059>

Linus Torvalds <torvalds@osdl.org> writes:

> Yeah, maybe we should allow an empty pattern, and just check the number of 
> arguments instead.

I think this patch is OK; I do not see a reason for wanting an
empty pattern.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff: --abbrev option
Date: Sat, 17 Dec 2005 18:57:19 -0800
Message-ID: <7vek4byuwg.fsf@assigned-by-dhcp.cox.net>
References: <7v3bks12n6.fsf@assigned-by-dhcp.cox.net>
	<20051218001756.GS22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Dec 18 03:59:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnokF-000343-14
	for gcvg-git@gmane.org; Sun, 18 Dec 2005 03:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbVLRC5V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Dec 2005 21:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbVLRC5V
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Dec 2005 21:57:21 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:21965 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932669AbVLRC5V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2005 21:57:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051218025555.CNCR17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 17 Dec 2005 21:55:55 -0500
To: git@vger.kernel.org
In-Reply-To: <20051218001756.GS22159@pasky.or.cz> (Petr Baudis's message of
	"Sun, 18 Dec 2005 01:17:56 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13785>

Petr Baudis <pasky@suse.cz> writes:

>   I was actually thinking to by default trim all the hashes Cogito show
> to 12 or 16 characters. Seven still seems dangerously low to me, though;
> it would be nice if the number of characters to trim would be
> configurable (unless I've missed that).

Well, I did better than you imagined this time, for a change ;-)
It trims and adds extra as needed without breaking alignments,
so you could get something like this:

>       :100755 100755 0266f46... b0e54ed... M	git-branch.sh
>       :100755 100755 f241d4b9.. 36308d2ab. M	git-checkout.sh

That is, ... is not just distraction but are part of the
design.  Cut and paste is a byproduct.

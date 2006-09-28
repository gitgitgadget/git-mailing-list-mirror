From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] diff --stat: allow custom diffstat output width.
Date: Thu, 28 Sep 2006 14:27:46 -0700
Message-ID: <7vac4ju1f1.fsf@assigned-by-dhcp.cox.net>
References: <7vr6xyjal0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609281349110.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
X-From: git-owner@vger.kernel.org Thu Sep 28 23:28:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT3Q7-0008M0-G8
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 23:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWI1V1s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 17:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWI1V1s
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 17:27:48 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:31718 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932085AbWI1V1s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 17:27:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060928212747.ZFDL18985.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Sep 2006 17:27:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TxTp1V0081kojtg0000000
	Thu, 28 Sep 2006 17:27:49 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609281349110.3952@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 28 Sep 2006 13:54:27 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28052>

Linus Torvalds <torvalds@osdl.org> writes:

> So how about just extending the existing "--stat" thing, and just making 
> it do something like
>
> 	git diff --stat=72,30
>
> instead (perhaps along with a config option to set the defaults to 
> something else if we want to).
>
> What do you think?

I am all for it.

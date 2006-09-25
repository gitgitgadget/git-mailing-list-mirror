From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RESEND] git-repack: allow git-repack to run in subdirectory
Date: Sun, 24 Sep 2006 20:16:02 -0700
Message-ID: <7vwt7s63gt.fsf@assigned-by-dhcp.cox.net>
References: <fcaeb9bf0609220221w3a65af24u9db1da4e1be0d1eb@mail.gmail.com>
	<20060925023111.GA14003@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 25 05:16:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRgwy-0001vu-HF
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 05:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWIYDQF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 23:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWIYDQF
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 23:16:05 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:52116 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751395AbWIYDQE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Sep 2006 23:16:04 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060925031603.YELQ12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Sun, 24 Sep 2006 23:16:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id STG51V00d1kojtg0000000
	Sun, 24 Sep 2006 23:16:05 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060925023111.GA14003@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 24 Sep 2006 22:31:11 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27724>

Jeff King <peff@peff.net> writes:

> Now that we explicitly create all tmpfiles below $GIT_DIR, there's no reason
> to care about which directory we're in.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> There was no response on this; is there any reason not to allow this, or
> did it just get dropped?

Simply forgotten; it might be _correct_ but it is not important.

While it may technically be correct that the command could be
run from anywhere, repack is a whole repository operation, and
it is an operation performed not that often.  There is no reason
to forbid it to run from subdirectories, but it does not hurt
users much if it did.

Will queue for "next" and push it out before 1.4.3 if I do not
forget it again ;-).

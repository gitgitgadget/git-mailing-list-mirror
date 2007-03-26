From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-rm: don't remove newly added file without -f
Date: Mon, 26 Mar 2007 15:36:42 -0700
Message-ID: <7vk5x3vdhh.fsf@assigned-by-dhcp.cox.net>
References: <8aa486160703260759v438d445ev82161600d8e8bf02@mail.gmail.com>
	<20070326185539.GA1650@coredump.intra.peff.net>
	<7v1wjbwvzl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703262314090.4045@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vslbrvgf1.fsf@assigned-by-dhcp.cox.net>
	<8aa486160703260759v438d445ev82161600d8e8bf02@mail.gmail.com>
	<20070326185539.GA1650@coredump.intra.peff.net>
	<7v1wjbwvzl.fsf@assigned-by-dhcp.cox.net>
	<20070326222239.GA3498@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 00:36:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVxo2-0003wZ-Me
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 00:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933602AbXCZWgs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 18:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933640AbXCZWgs
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 18:36:48 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:40514 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933602AbXCZWgr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 18:36:47 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070326223644.HOGP748.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 26 Mar 2007 18:36:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id faci1W00f1kojtg0000000; Mon, 26 Mar 2007 18:36:43 -0400
In-Reply-To: <20070326222239.GA3498@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 26 Mar 2007 18:22:39 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43196>

Jeff King <peff@peff.net> writes:

> Hmm, yes, I agree that is inconsistent. However, it's such a common
> workflow that forcing a '-f' would become meaningless. And you _can_
> rescue the blob from the object database in a pinch, though finding it
> can be tedious.

That's exactly the reason why I mentioned this inconsistency
between add vs rm "tongue-in-cheek".

We really do not want to require -f for common situations so
much that it ends up training people's fingers to type -f
without thinking, which would render the safety option
meaningless.

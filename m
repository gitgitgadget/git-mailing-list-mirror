From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Teach Git how to parse standard power of 2 suffixes.
Date: Sat, 30 Dec 2006 21:38:18 -0800
Message-ID: <7vejqgk4l1.fsf@assigned-by-dhcp.cox.net>
References: <20061231020218.GA5366@spearce.org>
	<7vodpkhjzq.fsf@assigned-by-dhcp.cox.net>
	<20061231023809.GC5082@spearce.org>
	<7vk608hiwq.fsf@assigned-by-dhcp.cox.net>
	<20061231030119.GD5082@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 06:38:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0tOp-0000Bv-ED
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 06:38:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932919AbWLaFiU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 00:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932971AbWLaFiU
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 00:38:20 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:51851 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932934AbWLaFiU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 00:38:20 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061231053819.WRJQ9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Sun, 31 Dec 2006 00:38:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5HdY1W00Y1kojtg0000000; Sun, 31 Dec 2006 00:37:33 -0500
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061231030119.GD5082@spearce.org> (Shawn Pearce's message of
	"Sat, 30 Dec 2006 22:01:19 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35672>

Shawn Pearce <spearce@spearce.org> writes:

> So in your test case where you thought you entered 20 pages, what you
> really had was just 2 pages.  We rounded 20 bytes down to 0 pages,
> then forced that to a minimum of 2 pages.  :-)

Yes.

And I found something else that is interesting.  I still had 2
pages windows but reduced packedgitlimit to 256kB and re-run the
same test to reproduce all merges in git.git.  It still did not
fail, but it took even shorter wallclock time (again, it is only
3 seconds or so out of 5 1/2 minuts, so it is probably
statistically insignificant).

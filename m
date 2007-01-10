From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Wed, 10 Jan 2007 01:40:47 -0800
Message-ID: <7v3b6jcj8g.fsf@assigned-by-dhcp.cox.net>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net>
	<87ps9xgkjo.wl%cworth@cworth.org>
	<7virfprquo.fsf@assigned-by-dhcp.cox.net>
	<87odphgfzz.wl%cworth@cworth.org>
	<7vbql9ydd7.fsf@assigned-by-dhcp.cox.net>
	<20070108131735.GA2647@coredump.intra.peff.net>
	<7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net>
	<20070109142130.GA10633@coredump.intra.peff.net>
	<7virffkick.fsf@assigned-by-dhcp.cox.net>
	<20070109213117.GB25012@fieldses.org>
	<87zm8ryiyz.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 10:41:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Zwy-000596-56
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 10:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932762AbXAJJkt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 04:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbXAJJkt
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 04:40:49 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:34267 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932762AbXAJJkt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 04:40:49 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070110094048.LJSG29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Wed, 10 Jan 2007 04:40:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9Mfx1W00S1kojtg0000000; Wed, 10 Jan 2007 04:39:58 -0500
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87zm8ryiyz.wl%cworth@cworth.org> (Carl Worth's message of "Tue,
	09 Jan 2007 13:43:16 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36494>

Carl Worth <cworth@cworth.org> writes:

> Frankly, I don't understand why so much effort is being put toward
> allowing these "fragile commits" to be made in the first place. Why
> not require users to name the branch before creating any commits, just
> as has always been the case?

Then we would not be talking about detached HEAD at all.  Why
not require users to name the branch if they want to check out
what they should not be able to in the first place?

Convenience.

Some features of git are about being convenient by allowing you
to defer the decision.  You can start mucking with the working
tree files without knowing where it leads to and then from that
point with the dirty working tree state decide to fork what you
have started using "checkout -b newbranch".  Even though you may
have many dirty files in the working tree, you can selectively
update index (especially with the patch subcommand of the
interactive git-add) to prepare for commit -- you do not choose
what to edit, but you defer the decision of what to include in
the commit.

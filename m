From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk changing line color for no reason after merge
Date: Wed, 8 Feb 2006 13:30:28 +1100
Message-ID: <17385.22468.218755.833713@cargo.ozlabs.ibm.com>
References: <1138900897.28967.18.camel@dv>
	<1139289517.15955.23.camel@dv>
	<7vlkwnxz5t.fsf@assigned-by-dhcp.cox.net>
	<1139360047.13646.22.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 08 03:36:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6fBm-0000zt-6y
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 03:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030464AbWBHCgL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 21:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030465AbWBHCgK
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 21:36:10 -0500
Received: from ozlabs.org ([203.10.76.45]:21737 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030464AbWBHCgJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2006 21:36:09 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 2A29568A20; Wed,  8 Feb 2006 13:36:08 +1100 (EST)
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1139360047.13646.22.camel@dv>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15729>

Pavel Roskin writes:

> I'm trying to make it easier to follow a line.  It's easier if its color
> is not changing, especially on trivial nodes (one parent, one child).

OK, you're using "line" to mean something a bit different from the
connection between a commit and its children, which is how I use it.
You seem to be using it more as a "line of development", or as a
series of related patches.  Which is fine, if you can find a way to
identify lines of development automatically.  (I know it looks obvious
when you look at the gitk display, but that's a lot different from
writing down an algorithm to do it.)

> http://red-bean.com/proski/gitk/gitk-ideal.png - made in GIMP.  Trivial
> nodes never change line color, because it changes as soon as the line
> forks.

My problem with that is that it isn't clear that e.g. the green and
brown lines near the bottom actually represent the same parent - and
that will get worse with more complex graphs.

Paul.

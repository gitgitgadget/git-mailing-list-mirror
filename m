From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Test for recent rev-parse $abbrev_sha1 regression
Date: Tue, 29 May 2007 23:28:42 -0700
Message-ID: <7vzm3m3jvp.fsf@assigned-by-dhcp.cox.net>
References: <20070530045026.GA12380@spearce.org>
	<7vlkf6508y.fsf@assigned-by-dhcp.cox.net>
	<20070530055806.GQ7044@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed May 30 08:28:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtHfw-000397-Uw
	for gcvg-git@gmane.org; Wed, 30 May 2007 08:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185AbXE3G2o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 02:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbXE3G2o
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 02:28:44 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:61966 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbXE3G2n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 02:28:43 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070530062843.VNVH19731.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 30 May 2007 02:28:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 5JUi1X0061kojtg0000000; Wed, 30 May 2007 02:28:42 -0400
In-Reply-To: <20070530055806.GQ7044@spearce.org> (Shawn O. Pearce's message of
	"Wed, 30 May 2007 01:58:06 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48746>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> But to me, anything that hits 'next' that breaks Git this badly is
> a regression.  Why?  Because I run my production repositories off
> next, that's why.  Of course I do this to exercise next more fully...
> to prevent this sort of stuff from getting to master.  ;-)

I'm almost always on 'next'.  I switch to run 'master' a few
days before -rc0 and a few days after the final feature release
I switch back to 'next'.

The tip of 'next' may not be perfect, but it should not be so
broken that it is beyond a quick repair to inconvenience users
that rely on 'next' working.  And it helps us catch problems
before the topics hit 'master'.

Because the tip of 'master' gets tagged only once every 6 weeks
or so, its tip is not an official release at any other times,
but we effectively have the usual pre-release QA continuously
running on the stuff that hits 'master'.  That's what 'next' is
all about.

And that's how we can keep our 'master' a lot more robust than
the development branches of other open source projects.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Add --ignore-notfound option to exit with zero status when no files are removed.
Date: Mon, 16 Apr 2007 01:53:46 -0700
Message-ID: <7v7iscvgx1.fsf@assigned-by-dhcp.cox.net>
References: <20070416000408.GA19107@midwinter.com>
	<7v4pnh18hr.fsf@assigned-by-dhcp.cox.net>
	<4622C0AC.8090904@midwinter.com>
	<7vps65yvc1.fsf@assigned-by-dhcp.cox.net>
	<20070416074648.GA18719@midwinter.com>
	<20070416075324.GA18961@midwinter.com>
	<7vps64vjfc.fsf@assigned-by-dhcp.cox.net>
	<20070416085011.GA2387@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 10:53:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdMy7-0006ir-Cl
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 10:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbXDPIxs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 04:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbXDPIxs
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 04:53:48 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:54907 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030196AbXDPIxr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 04:53:47 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070416085347.QTOA1271.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 16 Apr 2007 04:53:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id nktm1W00E1kojtg0000000; Mon, 16 Apr 2007 04:53:47 -0400
In-Reply-To: <20070416085011.GA2387@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 16 Apr 2007 04:50:11 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44631>

Jeff King <peff@peff.net> writes:

> On Mon, Apr 16, 2007 at 12:59:35AM -0700, Junio C Hamano wrote:
>
>> > +\--ignore-notfound::
>> > +	Exit with a zero status even if no files matched.
>> > +
>> ls-files has --error-unmatch so we may want to make the name
>> consistent by saying --ignore-unmatch?  I particularly do not
>> care about the minute naming issues _right_ _now_, but we might
>> regret it in the long run.
>
> Isn't this quite similar to the '-k' option to git-mv?

Heh, I never use 'git-mv' and 'git-rm' myself, so I did not know
about that option, but from the Documentation/git-mv.txt, it
sounds similar.  What does it stand for, I wonder?

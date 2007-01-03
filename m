From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Tue, 02 Jan 2007 18:45:51 -0800
Message-ID: <7vd55wsu8w.fsf@assigned-by-dhcp.cox.net>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net>
	<87ps9xgkjo.wl%cworth@cworth.org>
	<7virfprquo.fsf@assigned-by-dhcp.cox.net>
	<87odphgfzz.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 03 03:46:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1w8k-0007ME-5A
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 03:46:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891AbXACCpx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 21:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753900AbXACCpx
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 21:45:53 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:52100 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891AbXACCpw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 21:45:52 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070103024552.PXKG16632.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Tue, 2 Jan 2007 21:45:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 6Sl41W00M1kojtg0000000; Tue, 02 Jan 2007 21:45:04 -0500
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87odphgfzz.wl%cworth@cworth.org> (Carl Worth's message of "Tue,
	02 Jan 2007 15:34:24 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35839>

Carl Worth <cworth@cworth.org> writes:

> I don't actually prefer "no commit allowed". I just didn't want the
> user to have to explicitly disable the safety before being able to
> perform a checkout based on a tag.

Ok, then I think we are in agreement that the safety should be
at the point where the user might leave the detached state.

> I am still interested in this feature, so I will try to find time to
> come back with a revised version of your patch with the missing safety
> check (and without requiring -d on checkout). Thanks again for this
> initial take on the problem. (Though if anyone else beats me to it, I
> certainly will not be offended.)

Sounds good.  

I do not mind losing -d, but I would suggest that there should
be a message that says "you are no longer on any branch" after a
checkout that makes the head detached.  The user should be
warned about such an unusal situation.

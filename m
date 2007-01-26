From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Teach git-describe to display distances from tags.
Date: Fri, 26 Jan 2007 01:00:57 -0800
Message-ID: <7vlkjq17sm.fsf@assigned-by-dhcp.cox.net>
References: <20070125173954.GA13276@spearce.org>
	<7vmz46ajcq.fsf@assigned-by-dhcp.cox.net>
	<7v7ivaailb.fsf@assigned-by-dhcp.cox.net>
	<20070125214923.GD13874@spearce.org>
	<Pine.LNX.4.64.0701251830400.3021@xanadu.home>
	<7vmz4663xq.fsf@assigned-by-dhcp.cox.net>
	<38b2ab8a0701260052q517285e8l2505114a48d34558@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Francis Moreau" <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 26 10:01:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAMxB-0004rn-NQ
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 10:01:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030836AbXAZJA7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 04:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030837AbXAZJA7
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 04:00:59 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:55716 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030836AbXAZJA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 04:00:58 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070126090058.KNLW9717.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Fri, 26 Jan 2007 04:00:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Fl001W0021kojtg0000000; Fri, 26 Jan 2007 04:00:00 -0500
In-Reply-To: <38b2ab8a0701260052q517285e8l2505114a48d34558@mail.gmail.com>
	(Francis Moreau's message of "Fri, 26 Jan 2007 09:52:19 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37816>

"Francis Moreau" <francis.moro@gmail.com> writes:

> On 1/26/07, Junio C Hamano <junkio@cox.net> wrote:
>> Another backward incompatibility to mention in the release
>> notes.  I guess it is not too big a deal but makes me feel
>> uneasy.
>>
>
> Sorry if I missed any discussions about that point but why not calling
> the coming release 2.0 instead of 1.5 if this one implies some
> backward incompabilities and a lot of change in the UI ?

Because with the usual numbering the next normal feature release
would have been called 1.4.5, we said we would bump to 1.5 some
time ago.

There is no fundamental change between 1.4.4 series and the
upcoming 1.5.0 -- only superficial ones.  I do not think it
deserves a bump in the major version; well, at least I did not
think it would, when we first started talking about "the new
release whose main theme was usability enhancements".

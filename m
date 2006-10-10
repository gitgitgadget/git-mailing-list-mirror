From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Mon, 09 Oct 2006 22:46:21 -0700
Message-ID: <7vslhw7mfm.fsf@assigned-by-dhcp.cox.net>
References: <7vy7ro7o3g.fsf@assigned-by-dhcp.cox.net>
	<20061010053841.42852.qmail@web31815.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 07:46:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXARe-0001se-3a
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 07:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbWJJFqX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 01:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbWJJFqX
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 01:46:23 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:33447 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964995AbWJJFqX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 01:46:23 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061010054622.CQMH26416.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Oct 2006 01:46:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YVmR1V0031kojtg0000000
	Tue, 10 Oct 2006 01:46:25 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20061010053841.42852.qmail@web31815.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Mon, 9 Oct 2006 22:38:41 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28604>

Luben Tuikov <ltuikov@yahoo.com> writes:

> --- Junio C Hamano <junkio@cox.net> wrote:
>> Having said that, I agree to the point you are trying to make
>> here.  It was a mistake to remove blob/tree links from the view
>> that lists pathnames.
>> 
>> If we did not have any obviously clickable links on the right
>> hand side it might have been a different story, but when given
>> UNIXy permission bits, pathname and blame/history/raw links,
>> nobody would think of clicking on the pathname itself to grab
>> its contents.  The blame link would give you the same
>
> I've seen the exact opposite.
>
> BTW, what is our standard here? People with zero-computer
> exposure? With some? With high?
>
> Certainly, if I didn't know what a folder/directory/tree is,
> and what a file is and I was told to "get" that file, the first
> thing I'd do when I see it on the screen would be to "put my pointer
> over the file and press the action button".

I would agree with that if we did not have anything on the right
hand side that attracts eye and hand to tempt clicking.  And
that would be true for all levels of users.

If we replaced UNIXy mode bits with folder/file/symlink icons,
people might be tempted to click on them as well.

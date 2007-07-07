From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use /etc/mailname for the hostname part of the email address.
Date: Fri, 06 Jul 2007 23:07:42 -0700
Message-ID: <7vabu8d9w1.fsf@assigned-by-dhcp.cox.net>
References: <11837748652889-git-send-email-kraai@ftbfs.org>
	<alpine.LFD.0.999.0707061945220.31544@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Kraai <kraai@ftbfs.org>, git@vger.kernel.org,
	Matt Kraai <kraai@asturias.ftbfs.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 07 08:07:56 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I73SV-0001B7-19
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 08:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbXGGGHp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 02:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbXGGGHo
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 02:07:44 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:41551 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbXGGGHo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 02:07:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070707060743.VQRK11062.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sat, 7 Jul 2007 02:07:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LW7i1X00X1kojtg0000000; Sat, 07 Jul 2007 02:07:43 -0400
In-Reply-To: <alpine.LFD.0.999.0707061945220.31544@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 6 Jul 2007 19:54:34 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51805>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> The thing is, I actually personally tend to _prefer_ the committer name as 
> being "user@hostname" rather than a "real" email address.
>
> It often tells you something much more.

I remember you said exactly the same thing before.  But I wonder
if "committer" e-mail address is really the place you would want
to use as (one of) the source of reliable information for that
kind of thing.  The information obviously can be used among
people who exchange commits via git-pull, but what about people
whose changes are always fed as e-mailed patches?

For such people, if they would want to encode the auxiliary
information in their author name like you do with g5 and woody,
would you recommend they put the in-body From: header, which may
not be working e-mail addresses to reach them?

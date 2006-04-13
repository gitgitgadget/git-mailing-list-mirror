From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFH] shifting xdiff hunks?
Date: Thu, 13 Apr 2006 16:31:58 -0700
Message-ID: <7vslohvyq9.fsf@assigned-by-dhcp.cox.net>
References: <7vmzeqyolw.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604122348010.7104@alien.or.mcafeemobile.com>
	<Pine.LNX.4.64.0604131452250.10564@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 14 01:32:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUBIF-000292-3h
	for gcvg-git@gmane.org; Fri, 14 Apr 2006 01:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbWDMXcD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 19:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbWDMXcB
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 19:32:01 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:53473 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S965042AbWDMXcB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Apr 2006 19:32:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060413233159.PBVX16517.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Apr 2006 19:31:59 -0400
To: Davide Libenzi <davidel@xmailserver.org>
In-Reply-To: <Pine.LNX.4.64.0604131452250.10564@alien.or.mcafeemobile.com>
	(Davide Libenzi's message of "Thu, 13 Apr 2006 14:55:48 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18679>

Davide Libenzi <davidel@xmailserver.org> writes:

> On Wed, 12 Apr 2006, Davide Libenzi wrote:
>
>> Yes, this is what GNU diff does. It's a post-process of the edit
>> script. Not a problem at all. Till this weekend (included) I'm
>> pretty booked, but I'll do that in the following days.
>
> Dang, that was a short weekend. I found a lunch-time hour for
> this. Would you try to see if this libxdiff-based diff merges on your
> tree?
> See also how it looks for you.

Very impressed, and pleased with the result.  I've only taken a
cursory look, but with a very limited number of tests, it looks
much better.  Thanks.

For the sake of full disclosure, the reason I wanted consistency
was not for the diff output I quoted earlier, but to help making
the combined patch output cleaner.  It does reduce false match
from the infamous 12-way Octopus by Len Brown:

	git diff-tree --cc 9fdb62af92c741addbea15545f214a6e89460865

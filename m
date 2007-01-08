From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsimport: skip commits that are too recent
Date: Sun, 07 Jan 2007 18:19:54 -0800
Message-ID: <7vd55qz2d1.fsf@assigned-by-dhcp.cox.net>
References: <1168218683853-git-send-email-martin@catalyst.net.nz>
	<7virfiz3at.fsf@assigned-by-dhcp.cox.net>
	<46a038f90701071813g7b892af1y2cfa620ef2656657@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 08 03:20:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3k7I-0005VF-4x
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 03:20:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030447AbXAHCT4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 21:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030448AbXAHCT4
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 21:19:56 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:36361 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030447AbXAHCTz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 21:19:55 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070108021954.LFW29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Sun, 7 Jan 2007 21:19:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 8SK41W00p1kojtg0000000; Sun, 07 Jan 2007 21:19:05 -0500
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90701071813g7b892af1y2cfa620ef2656657@mail.gmail.com>
	(Martin Langhoff's message of "Mon, 8 Jan 2007 15:13:32 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36224>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> On 1/8/07, Junio C Hamano <junkio@cox.net> wrote:
>>  Almost immediately
>> after that, I do another incremental cvsimport so that I can
>> rebase the remainder of my branch on top of what I made public.
>
> That probably means I should have added a
> --force-fetch-all-and-i-mean-it flag to override the cautious
> behaviour. I'll repost ina few hours, with doco too.

Well I meant to say that my conclusion is that that flag is not
needed in practice.

>
> ...
>
>> Which means that you did not give me a new excuse to take a
>> coffee break and work on git stuff instead of my day job project
>> to my management but that is Ok.  I'll find other ways ;-).
>
> I'll try harder next time ;-)
>
> cheers
>
>
> martin

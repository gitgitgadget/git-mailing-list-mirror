From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Suggest use of "git add file1 file2" when there is nothing to commit.
Date: Fri, 05 Jan 2007 14:33:11 -0800
Message-ID: <7virfldryw.fsf@assigned-by-dhcp.cox.net>
References: <20061216025309.GA19955@spearce.org>
	<1168029891.11130.18.camel@ibook.zvpunry.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 05 23:33:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2xci-0001LY-L8
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 23:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbXAEWdN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 17:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbXAEWdN
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 17:33:13 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:35597 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbXAEWdN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 17:33:13 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070105223312.DFJM19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Fri, 5 Jan 2007 17:33:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 7aYP1W00J1kojtg0000000; Fri, 05 Jan 2007 17:32:23 -0500
To: Michael Loeffler <zvpunry@zvpunry.de>
In-Reply-To: <1168029891.11130.18.camel@ibook.zvpunry.de> (Michael Loeffler's
	message of "Fri, 05 Jan 2007 21:44:51 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36033>

Michael Loeffler <zvpunry@zvpunry.de> writes:

> Am Freitag, den 15.12.2006, 21:53 -0500 schrieb Shawn O. Pearce:
> ...
>> +		printf("%s (%s)\n",
>> +			s->amend ? "# No changes" : "nothing to commit",
>> +			use_add_msg);
>>  }
> I don't like the new 'nothing to commit (use "git add ... message")'
> message. I use git status very often to see if there is something to
> commit, but now there is always this annoying "use git add ..." message.

I tend to not like _ANY_ change at all, but I've learned to wait
and see if I get used to it when I see something that annoys me
initially, to see if the annoyance is because what it does is
truly wrong or it is because what it does is merely different
from what I am used to.

So I've been trying it out myself as one of the guinea pigs on
this one as well.

So far, my judgement is that this is of the better kind; it is
easy to get used to, and once you get used to it, it is easily
ignorable.

Other people's tastes may differ, of course.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] --walk-reflogs: actually find the right commit by date.
Date: Sat, 20 Jan 2007 23:09:32 -0800
Message-ID: <7vhcuk500j.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0701201048560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vhcum80u4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701202225020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 21 08:28:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8X7z-0007HP-1N
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 08:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbXAUH2b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 02:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbXAUH2b
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 02:28:31 -0500
Received: from fed1rmmtai20.cox.net ([68.230.241.39]:35908 "EHLO
	fed1rmmtai20.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbXAUH2a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 02:28:30 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070121070932.XBPD3976.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Sun, 21 Jan 2007 02:09:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Dj8d1W0081kojtg0000000; Sun, 21 Jan 2007 02:08:37 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701202225020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 20 Jan 2007 22:36:31 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37308>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Sat, 20 Jan 2007, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > Embarassing thinko.
>> 
>> Aha, progress ;-).  But it still seems to pick up entry that is
>> less than specified number of hours if I do:
>> 
>> 	$ git log --walk-reflogs -4 master@{1.hour} | head -2
>>         commit 33dd19c2a9c0b114436f53d86fc1c2c5e00c26bb
>>         Reflog: master@{Sat, 20 Jan 2007 00:01:35 -0800} (Junio C Ham
>> 
>> It is Jan 20th 02:10 now and the master was not pointing at that
>> commit 1 hour ago.
>
> I tried to reproduce this effect, but so far no luck.

Sorry, I was reading the timestamp wrong.  That is one minute
thirty-five seconds past midnight, not thirty five minute past
one o'clock.

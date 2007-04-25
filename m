From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add date format --local-zone
Date: Wed, 25 Apr 2007 14:02:41 -0700
Message-ID: <7v8xcgw4jy.fsf@assigned-by-dhcp.cox.net>
References: <1177482982542-git-send-email-junkio@cox.net>
	<alpine.LFD.0.98.0704250800030.9964@woody.linux-foundation.org>
	<alpine.LFD.0.98.0704250805440.9964@woody.linux-foundation.org>
	<20070425201212.GD30061@steel.home>
	<7vk5w0w615.fsf@assigned-by-dhcp.cox.net>
	<20070425204147.GE30061@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 23:03:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgodz-0002GT-AC
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 23:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211AbXDYVCn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 17:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754215AbXDYVCn
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 17:02:43 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:44074 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754211AbXDYVCm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 17:02:42 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070425210242.VMPX22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Wed, 25 Apr 2007 17:02:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id rZ2h1W00F1kojtg0000000; Wed, 25 Apr 2007 17:02:41 -0400
In-Reply-To: <20070425204147.GE30061@steel.home> (Alex Riesen's message of
	"Wed, 25 Apr 2007 22:41:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45577>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Wed, Apr 25, 2007 22:30:46 +0200:
>> >> 
>> >> Btw, when you do "--local-zone", you should drop the TZ printout too, I 
>> >> think. It doesn't seem to make any sense to give the *wrong* timezone.
>> >
>> > The timezone is interesting to see: it is a hint as to _where_ the
>> > commit is coming from. Obviously not reliable, it can be amusing.
>> 
>> Unless you spotted a bug in the patch, with --local-zone, I do
>> not think you would get any such hint from the zone information.
>> 
>
> No, not in your patch. For example, look at the timezone information
> in the Date: and Received: headers of this mail.

Ok, I misunderstood.  I did not realize that you were making a
comment that was totally unrelated to the --local-zone option.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 11:45:57 -0700
Message-ID: <7v7iqyxdp6.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705241039200.4648@racer.site>
	<20070524105112.GI942MdfPADPa@greensroom.kotnet.org>
	<Pine.LNX.4.64.0705241201270.4648@racer.site>
	<20070524111645.GK942MdfPADPa@greensroom.kotnet.org>
	<Pine.LNX.4.64.0705241230410.4648@racer.site>
	<20070524114354.GN942MdfPADPa@greensroom.kotnet.org>
	<Pine.LNX.4.64.0705241315290.4648@racer.site>
	<8c5c35580705240541j7f632fc4lbd308c9386c2bde6@mail.gmail.com>
	<7vabvuywix.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0705241030440.26602@woody.linux-foundation.org>
	<20070524175519.GU942MdfPADPa@greensroom.kotnet.org>
	<alpine.LFD.0.98.0705241105210.26602@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skimo@liacs.nl, Lars Hjemli <hjemli@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu May 24 20:46:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrIK3-0001l1-4L
	for gcvg-git@gmane.org; Thu, 24 May 2007 20:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbXEXSqB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 14:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbXEXSqB
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 14:46:01 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:57945 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbXEXSqA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 14:46:00 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070524184600.RXXI22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 24 May 2007 14:46:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 36ly1X00E1kojtg0000000; Thu, 24 May 2007 14:45:59 -0400
In-Reply-To: <alpine.LFD.0.98.0705241105210.26602@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 24 May 2007 11:09:36 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48291>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 24 May 2007, Sven Verdoolaege wrote:
>> ...
>> What if someone is working on his own branch of the superproject
>> that needs some changes in his own subproject?
>> He needs to modify .gitmodules, but when the changes go upstream,
>> this .gitmodules changes get merged as well.
>> Now imagine several developers doing this.
>> You end up continually having to modify .gitmodules.
>
> Ehh. What drugs are you on?
>
> That's the whole point of having local overrides. You use them for local 
> branches. You do _not_ use .gitmodules for those.
>
> So ".gitmodules" is the default for people who don't do anything special. 
> Only people who change the _default_ would ever change that.
>
> I really don't understand or see your objections at all. You are making 
> totally idiotic arguments BASED ON DOING OBVIOUSLY STUPID THINGS. That's 
> not an argument.

While I agree with the three-level thing that uses .gitmodules
and take the information from .git/config would solve the
problem, I do not think you need to shout.

While I disagree with some design decisions Sven's series made,
I am happy that the series is there for people to comment on.
It helps us identify the design issues by making the differences
of opinion people have on them stand out.

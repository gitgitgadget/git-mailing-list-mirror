From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-branch: show detached HEAD
Date: Tue, 02 Jan 2007 23:52:53 -0800
Message-ID: <7vslespmwa.fsf@assigned-by-dhcp.cox.net>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net>
	<1167780131528-git-send-email-hjemli@gmail.com>
	<20070103051811.GB23358@spearce.org>
	<7v7iw4r47e.fsf@assigned-by-dhcp.cox.net>
	<8c5c35580701022350n13742ec1n6f5fadcf1dfb18aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 03 08:53:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H20vp-0006qm-O9
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 08:53:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000AbXACHw4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 02:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755002AbXACHwz
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 02:52:55 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:41922 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754998AbXACHwz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 02:52:55 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070103075254.TCPZ20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Wed, 3 Jan 2007 02:52:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 6Xt81W00R1kojtg0000000; Wed, 03 Jan 2007 02:53:09 -0500
To: "Lars Hjemli" <hjemli@gmail.com>
In-Reply-To: <8c5c35580701022350n13742ec1n6f5fadcf1dfb18aa@mail.gmail.com>
	(Lars Hjemli's message of "Wed, 3 Jan 2007 08:50:50 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35851>

"Lars Hjemli" <hjemli@gmail.com> writes:

> On 1/3/07, Junio C Hamano <junkio@cox.net> wrote:
>> I would even make it stronger to say something like:
>>
>>         * You are not on ANY branch right now.
>>           master
>>           next
>>           pu
>>           ...
>>
>
> Hmm, that wouldn't be very nice for 'git-branch -v' (which suddenly
> got extra useful with detached head).

Ah, please scratch that.

I did not remember that option, since I do not use it myself.
Thanks for injecting sanity.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Makefile: add clean-obsolete-scripts target
Date: Wed, 10 Jan 2007 16:34:41 -0800
Message-ID: <7vy7oa765a.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0701101319480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vhcuyaaxq.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0701101326p11069c76w2873106cb2d46ebf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 01:35:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4nuG-0002JA-BZ
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 01:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965224AbXAKAe6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 19:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965245AbXAKAe6
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 19:34:58 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:35612 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965224AbXAKAe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 19:34:57 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070111003457.KTAU29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Wed, 10 Jan 2007 19:34:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9ca61W0081kojtg0000000; Wed, 10 Jan 2007 19:34:06 -0500
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0701101326p11069c76w2873106cb2d46ebf@mail.gmail.com>
	(Alex Riesen's message of "Wed, 10 Jan 2007 22:26:34 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36543>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> On 1/10/07, Junio C Hamano <junkio@cox.net> wrote:
>>
>> I would prefer it to be rather automatic -- how about this instead?
>>
> ...
>> +ifneq (,$X)
>
> Perfect! :)

Heh, you couldn't have tested -- I still had "echo rm -f" in the
patch ;-).

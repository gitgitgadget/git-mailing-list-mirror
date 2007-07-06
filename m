From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Email address from username and hostname preferred over $EMAIL
Date: Thu, 05 Jul 2007 18:17:38 -0700
Message-ID: <7vir8yib4d.fsf@assigned-by-dhcp.cox.net>
References: <OF40A04FE5.AA34B1BF-ON8825730F.005D733A-8825730F.0062A716@beck
	man.com>
	<alpine.LFD.0.98.0707051357360.9434@woody.linux-foundation.org>
	<468D917F.9090707@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, mkraai@beckman.com,
	git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Jul 06 03:17:43 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6cS7-0002Wk-0U
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 03:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761271AbXGFBRk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 21:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761028AbXGFBRk
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 21:17:40 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:65390 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760926AbXGFBRj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 21:17:39 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070706011740.PJME3098.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Jul 2007 21:17:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id L1He1X00a1kojtg0000000; Thu, 05 Jul 2007 21:17:39 -0400
In-Reply-To: <468D917F.9090707@nrlssc.navy.mil> (Brandon Casey's message of
	"Thu, 05 Jul 2007 19:49:03 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51710>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Linus Torvalds wrote:
>
>> If you want it to prefer $EMAIL, you'd need to change the
>> initialization of git_default_email, methinks.
>>
>> 		Linus
>
> I just sent an email to the list, and not in reply to this thread
> because I thought I read a comment about not posting a patch deep in
> a thread.
>
> But, I'm thinking I should have just posted it as a reply to the thread
> since I quoted a portion of your message.

Are Brandon Casey and Matt Kraai the same person?

I do not mind threadedness of the patch too much, but the patch
recently posted by the latter does not have any description
other than the title.

Other than that, I think the change itself seems sane.

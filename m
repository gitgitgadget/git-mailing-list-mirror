From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn rebase screwing up commit messages
Date: Sat, 28 Jul 2007 06:38:19 -0700
Message-ID: <7vk5skps1g.fsf@assigned-by-dhcp.cox.net>
References: <724DFB31-0471-4A5E-95DF-F5F74876AC77@lrde.epita.fr>
	<7v8x90sp25.fsf@assigned-by-dhcp.cox.net>
	<20070728083536.540e471d.seanlkml@sympatico.ca>
	<7vodhwptba.fsf@assigned-by-dhcp.cox.net>
	<20070728092914.48f6305c.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benoit SIGOURE <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sat Jul 28 15:38:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEmV9-0002YR-IA
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 15:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbXG1NiV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 09:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbXG1NiV
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 09:38:21 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:43057 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbXG1NiU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 09:38:20 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070728133819.VPFA1393.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 28 Jul 2007 09:38:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id V1eK1X00B1kojtg0000000; Sat, 28 Jul 2007 09:38:20 -0400
In-Reply-To: <20070728092914.48f6305c.seanlkml@sympatico.ca>
	(seanlkml@sympatico.ca's message of "Sat, 28 Jul 2007 09:29:14 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54033>

Sean <seanlkml@sympatico.ca> writes:

>> Having said all that, so that the readers understand the
>> background, here is a not-so-heavily-tested patch, which might
>> help.  It passes all the test suite as before, but that tells
>> how existing git-svn tests do not test many things.
>> 
>> I am not considering this for inclusion right now, by the way.
>
> FWIW your patch fixed my test case here.

Actually the patched behaviour actively encourages a bad (not in
the sense that those oneline tools will not work well, but in
the sense that these messages are reader unfriendly) practice; I
do not think what the patch did deserves to be called "fixed".

And that is one of the reasons, other than that we are in -rc
freeze that we do not add anything but unarguable fixes, that I
am not considering the patch for inclusion right now.

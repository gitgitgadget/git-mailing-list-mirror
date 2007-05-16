From: Junio C Hamano <junkio@cox.net>
Subject: Re: Losing branches (whee, data loss)
Date: Tue, 15 May 2007 23:43:07 -0700
Message-ID: <7viratfev8.fsf@assigned-by-dhcp.cox.net>
References: <464A940C.3080906@garzik.org>
	<8c5c35580705152248w254e4201w65da1e1ad229f6ee@mail.gmail.com>
	<464A9C9B.70904@garzik.org>
	<20070516061449.GA25273@artax.karlin.mff.cuni.cz>
	<464AA773.3090808@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Hudec <bulb@ucw.cz>, Lars Hjemli <hjemli@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Wed May 16 08:43:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoDEO-0002dE-Le
	for gcvg-git@gmane.org; Wed, 16 May 2007 08:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759899AbXEPGnL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 02:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759988AbXEPGnK
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 02:43:10 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:62927 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762275AbXEPGnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 02:43:09 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070516064309.UINS13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 16 May 2007 02:43:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id zij71W00R1kojtg0000000; Wed, 16 May 2007 02:43:08 -0400
In-Reply-To: <464AA773.3090808@garzik.org> (Jeff Garzik's message of "Wed, 16
	May 2007 02:40:51 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47421>

Jeff Garzik <jeff@garzik.org> writes:

> Jan Hudec wrote:
>> And does the .git/logs/refs/heads/upstream-fixes still exist?
>
> Nope.
>
>
>> If it does not, as last resort you'd have to git fsck --unreachable
>> (this gives you all things that are not reachable from any ref), filter
>> out only commit objects and than remember which one should have been on
>> that branch after reading it's log, date and changes.
>
> Yeah, that will probably recover it.  I wound up digging the emails
> out of the trash bin, and applying them again.

Ah, sorry to hear that.  Trying to rename and lost both old and
new -- that is bad.

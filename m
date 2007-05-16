From: Junio C Hamano <junkio@cox.net>
Subject: Re: Losing branches (whee, data loss)
Date: Wed, 16 May 2007 00:36:39 -0700
Message-ID: <7vejlhfce0.fsf@assigned-by-dhcp.cox.net>
References: <464A940C.3080906@garzik.org>
	<8c5c35580705152248w254e4201w65da1e1ad229f6ee@mail.gmail.com>
	<464A9C9B.70904@garzik.org>
	<20070516061449.GA25273@artax.karlin.mff.cuni.cz>
	<464AA773.3090808@garzik.org>
	<8c5c35580705160010s506b6f53y4209c1b541c3112a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeff Garzik" <jeff@garzik.org>, "Jan Hudec" <bulb@ucw.cz>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 16 09:36:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoE3z-0003KG-1H
	for gcvg-git@gmane.org; Wed, 16 May 2007 09:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756065AbXEPHgl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 03:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756595AbXEPHgl
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 03:36:41 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:63216 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756065AbXEPHgk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 03:36:40 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070516073639.WEBP2758.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 16 May 2007 03:36:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id zjcf1W0081kojtg0000000; Wed, 16 May 2007 03:36:39 -0400
In-Reply-To: <8c5c35580705160010s506b6f53y4209c1b541c3112a@mail.gmail.com>
	(Lars Hjemli's message of "Wed, 16 May 2007 09:10:28 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47426>

"Lars Hjemli" <hjemli@gmail.com> writes:

> On 5/16/07, Jeff Garzik <jeff@garzik.org> wrote:
>> Jan Hudec wrote:
>> > And does the .git/logs/refs/heads/upstream-fixes still exist?
>>
>> Nope.
>>
>>
>> > If it does not, as last resort you'd have to git fsck --unreachable
>> > (this gives you all things that are not reachable from any ref), filter
>> > out only commit objects and than remember which one should have been on
>> > that branch after reading it's log, date and changes.
>>
>> Yeah, that will probably recover it.  I wound up digging the emails out
>> of the trash bin, and applying them again.
>>
>
> That's bad.
>
> Just out of curiosity: do you get any output from 'git log RENAMED-REF'?

Another probably easier way to recover them would be 'git
lost-found'.

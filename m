From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-p4import.py robustness changes
Date: Sat, 02 Jun 2007 16:52:58 -0700
Message-ID: <7vr6otoqw5.fsf@assigned-by-dhcp.cox.net>
References: <4ACE2ABC-8D73-4097-87AC-F3B27EDA97DE@slamb.org>
	<7vbqg01reo.fsf@assigned-by-dhcp.cox.net>
	<0EDF1E14-3682-4B1E-A7D2-F82388F752AA@slamb.org>
	<7vzm3inisa.fsf@assigned-by-dhcp.cox.net>
	<87F9A283-C51F-49FB-9A13-40E850AC0474@slamb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Scott Lamb <slamb@slamb.org>
X-From: git-owner@vger.kernel.org Sun Jun 03 01:53:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HudP8-0003vA-9Y
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 01:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760064AbXFBXxC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 19:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760616AbXFBXxB
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 19:53:01 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:33851 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760064AbXFBXxA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 19:53:00 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070602235259.NHNA5800.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 2 Jun 2007 19:52:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 6nsy1X00Z1kojtg0000000; Sat, 02 Jun 2007 19:52:59 -0400
In-Reply-To: <87F9A283-C51F-49FB-9A13-40E850AC0474@slamb.org> (Scott Lamb's
	message of "Sat, 2 Jun 2007 16:21:34 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48960>

Scott Lamb <slamb@slamb.org> writes:

> On Jun 2, 2007, at 2:33 PM, Junio C Hamano wrote:
>
>> A much more preferable alternative is for you to say "Hey, don't
>> say you want to demote it.  I'll keep it maintained, I regularly
>> use p4 and have a strong incentive to keep it working".  Then we
>> do not have to do the "patch 0" ;-)
>
> Hmm. I'd like to say that, but keep in mind that I'd never even used
> git before Wednesday, and I'm not sure yet how well git-p4import.py
> will work out for me.

Oh, you do not have to worry so much.  There certainly are
people who are familiar enough with git on this list to help
improving p4import from the git side.

The thing to me personally is that I am p4 illiterate.  However,
as you might be aware, a few people posted their own version of
"better than p4import" scripts to the list in the past few
months, so there should also be enough people with p4 expertise
and motivation to help you with it.

It _might_ turn out that one of their scripts might be better
than the p4import we have in-tree and we would end up replacing
it with it.  I won't be able to judge that myself, but if people
who need to interoperate with p4 on the list can join forces it
would be good.

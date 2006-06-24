From: Junio C Hamano <junkio@cox.net>
Subject: PPC SHA-1 Updates in "pu"
Date: Sat, 24 Jun 2006 03:03:02 -0700
Message-ID: <7vwtb6yip5.fsf@assigned-by-dhcp.cox.net>
References: <7vzmg376ee.fsf@assigned-by-dhcp.cox.net>
	<20060624012202.4822.qmail@science.horizon.com>
	<7vfyhv11ej.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jun 24 12:03:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu4yv-0000bx-0V
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 12:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933026AbWFXKDE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 06:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933377AbWFXKDE
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 06:03:04 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:41654 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S933026AbWFXKDD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 06:03:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060624100303.SZLP11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Jun 2006 06:03:03 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22497>

Junio C Hamano <junkio@cox.net> writes:

> linux@horizon.com writes:
>
>> Well, I'm not sure it's worth this much trouble.  Both of my PPC
>> implementations are smaller and faster than the current one,
>> so that's a pretty easy decision.  The difference between them
>> is 2-3%, which is, I think, not enough to be worth the maintenance
>> burden of a run-time decision infrastructure.  Just pick either one
>> and call it a day.
>>...
>> Not that numbers are bad, but I think that until there's a real
>> need for more than a single good-enough version per instruction set,
>> this is excessive.
>
> OK.  I somehow got an impression that your two versions had
> quite different performance characteristics on G4 and G5 and
> there was a real choice.  If they are between a few per-cent,
> then I agree it is not worth doing at all.

If somebody has time and inclination, please try updated PPC SHA-1
from linux@horizon.com that is in "pu" (say make check-sha1) and
report impressions.

The first line from ./test-sha1.sh is the time output to hash 100MB
and there should be bunch of OK output to verify the code hashes
things correctly for inputs of various sizes.

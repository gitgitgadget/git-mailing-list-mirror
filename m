From: Miles Bader <miles@gnu.org>
Subject: Re: way to automatically add untracked files?
Date: Sun, 05 Aug 2007 14:17:47 +0900
Message-ID: <87y7gqk1ac.fsf@catnip.gol.com>
References: <873ayymzc1.fsf@catnip.gol.com>
	<fc339e4a0708042100jdf0a0f1jd1fddfb5dc1c1052@mail.gmail.com>
	<20070805041320.GH9527@spearce.org> <87lkcqlif2.fsf@catnip.gol.com>
	<7v8x8qip7n.fsf@assigned-by-dhcp.cox.net>
	<87d4y2li2c.fsf@catnip.gol.com>
	<7v4pjeioi6.fsf@assigned-by-dhcp.cox.net>
	<874pjelgyz.fsf@catnip.gol.com>
	<7vzm16h8qw.fsf@assigned-by-dhcp.cox.net>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 07:17:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHYUf-00079x-9N
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 07:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbXHEFRa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 01:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbXHEFRa
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 01:17:30 -0400
Received: from smtp02.dentaku.gol.com ([203.216.5.72]:38069 "EHLO
	smtp02.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbXHEFR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 01:17:29 -0400
Received: from 203-216-96-074.dsl.gol.ne.jp ([203.216.96.74] helo=catnip.gol.com)
	by smtp02.dentaku.gol.com with esmtpa (Dentaku)
	id 1IHYUa-0007IV-Bz; Sun, 05 Aug 2007 14:17:28 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id DCE30300F; Sun,  5 Aug 2007 14:17:47 +0900 (JST)
System-Type: i686-pc-linux-gnu
In-Reply-To: <7vzm16h8qw.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sat\, 04 Aug 2007 22\:04\:55 -0700")
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54951>

Junio C Hamano <gitster@pobox.com> writes:
> I highly suspect that we will be hated by most of our users if we
> changed "git add -u" to add everything in sight for this reason, and I
> also suspect they will feel that "git add-remove --all" will be code
> bloat for little gain.

I agree that a change to "git-add -u" would be silly... :-)

I was just looking for a convenient way to reduce my typing on those
occasions when I do have a bunch of added/removed/renamed files;
"git-add -u; git add ." seems to do the trick (of course I always
check what git-status says first!).

Thanks,

-Miles

-- 
The automobile has not merely taken over the street, it has dissolved the
living tissue of the city.  Its appetite for space is absolutely insatiable;
moving and parked, it devours urban land, leaving the buildings as mere islands
of habitable space in a sea of dangerous and ugly traffic.
[James Marston Fitch, New York Times, 1 May 1960]

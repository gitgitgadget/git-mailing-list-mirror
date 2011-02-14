From: Miles Bader <miles@gnu.org>
Subject: Re: Consistent terminology: cached/staged/index
Date: Mon, 14 Feb 2011 11:05:12 +0900
Message-ID: <87k4h34bhj.fsf@catnip.gol.com>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
	<20110213193738.GA26868@elie>
	<7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 03:05:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ponoi-0002H6-Pi
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 03:05:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755197Ab1BNCFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 21:05:24 -0500
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:42737 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754721Ab1BNCFV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 21:05:21 -0500
Received: from 218.33.195.219.eo.eaccess.ne.jp ([218.33.195.219] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	(envelope-from <miles@gnu.org>)
	id 1PonoP-0006Tp-1J; Mon, 14 Feb 2011 11:05:13 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 0C791DF8A; Mon, 14 Feb 2011 11:05:12 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <7v8vxjwnhj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 13 Feb 2011 14:58:32 -0800")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166685>

Junio C Hamano <gitster@pobox.com> writes:
> Some people may find it a good idea to introduce new synonyms --index-only
> vs --index-and-working-tree. I personally am not opposed to such a change,

Those are so long that nobody will ever use them though...

One of my big peeves is simply that "git diff --cached" is too long, as
it's an extremely common command (the name isn't exactly intuitive, even
after many years of use, but it's just one of those things you
memorize).

Is there a reason a short version of --cached couldn't be added to
git-diff...?  E.g. "git diff -c"?

Thanks,

-Miles

-- 
Ocean, n. A body of water covering seven-tenths of a world designed for Man -
who has no gills.

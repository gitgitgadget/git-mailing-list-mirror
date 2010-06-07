From: Miles Bader <miles@gnu.org>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz origin/frotz"
Date: Mon, 07 Jun 2010 15:41:58 +0900
Message-ID: <buobpbnz6mh.fsf@dhlpc061.dev.necel.com>
References: <20100605110930.GA10526@localhost>
	<vpqljas5e33.fsf@bauges.imag.fr> <20100606164642.GA10104@localhost>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Peter Rabbitson <ribasushi@cpan.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Jun 07 08:42:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLW2U-00033d-H9
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 08:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754Ab0FGGmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 02:42:21 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:60743 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466Ab0FGGmV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 02:42:21 -0400
Received: from mailgate3.nec.co.jp ([10.7.69.197])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id o576g08R029287;
	Mon, 7 Jun 2010 15:42:00 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id o576g0o18062; Mon, 7 Jun 2010 15:42:00 +0900 (JST)
Received: from relay51.aps.necel.com ([10.29.19.60]) by vgate01.nec.co.jp (8.11.7/3.7W-MAILSV-NEC) with ESMTP
	id o576fx405073; Mon, 7 Jun 2010 15:41:59 +0900 (JST)
Received: from relay51.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay51.aps.necel.com with ESMTP; Mon, 7 Jun 2010 15:41:59 +0900
Received: from dhlpc061 ([10.114.113.131] [10.114.113.131]) by relay51.aps.necel.com with ESMTP; Mon, 7 Jun 2010 15:41:59 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id B90AD52E1B4; Mon,  7 Jun 2010 15:41:58 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <20100606164642.GA10104@localhost> (Clemens Buchacher's message
	of "Sun, 6 Jun 2010 18:46:42 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148580>

Clemens Buchacher <drizzd@aon.at> writes:
> The suggestion above would be perfect. It is an easy and obvious
> solution, and the user is even educated about their mistake.

Of course, having been educated as to what's going on, the user would
then be annoyed that they had to type all those boilerplate args when
git clearly knew what they wanted to do... and that would be the case
every time from then on...

I think this DWIM is actually pretty convenient, and very often does
reflect what the user intuitively is trying to do when giving such args.

Given that git _does_ tell you what it's doing, and that it's easy
enough to delete the new branch if it wasn't really wanted, it seems
pretty harmless as well.  A campaign to delete this feature seems kind
of silly...

-Miles

-- 
I'm beginning to think that life is just one long Yoko Ono album; no rhyme
or reason, just a lot of incoherent shrieks and then it's over.  --Ian Wolff

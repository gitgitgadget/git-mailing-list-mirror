From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH v2 1/2] Add diff --porcelain option for --color-words
Date: Sun, 04 Apr 2010 07:38:50 +0900
Message-ID: <87wrwoma9x.fsf@catnip.gol.com>
References: <cover.1270317502.git.trast@student.ethz.ch>
	<f5741e49b2c09ec76def2d21a84a7da6ff7b8368.1270317502.git.trast@student.ethz.ch>
	<7vmxxk8i01.fsf@alter.siamese.dyndns.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 04 00:46:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyC73-0002XG-5E
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 00:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617Ab0DCWq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Apr 2010 18:46:28 -0400
Received: from smtp11.dentaku.gol.com ([203.216.5.73]:39414 "EHLO
	smtp11.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979Ab0DCWq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Apr 2010 18:46:27 -0400
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Apr 2010 18:46:27 EDT
Received: from 218.231.154.39.eo.eaccess.ne.jp ([218.231.154.39] helo=catnip.gol.com)
	by smtp11.dentaku.gol.com with esmtpa (Dentaku)
	id 1NyBzP-0004xL-3c; Sun, 04 Apr 2010 07:38:51 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 7B93CDF6E; Sun,  4 Apr 2010 07:38:50 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <7vmxxk8i01.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 03 Apr 2010 12:15:42 -0700")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143907>

Junio C Hamano <gitster@pobox.com> writes:
> How readable can you make this for human consumption while still keeping
> it machine readable?  The answer could be it already is human readble.
>
> Two reasons I ask the above question are that I find the feature quite
> interesting, and would want to see if it can be also fed to humans, and
> that the combination of this new option and the existing --color-words is
> misnamed.

There's the format used by the "wdiff" program, which is more like
traditional diff output in that it doesn't use color, but is human
friendly, and also seems to be somewhat machine-parseable:

   $ echo 'This is a test' > /tmp/a
   $ echo 'This is funky test' > /tmp/b
   $ wdiff /tmp/a /tmp/b
   This is [-a-] {+funky+} test

[I say "somewhat" because wdiff itself doesn't appear to escape potentially
ambiguous content, e.g., if there's actually a "{+" in the file....]

-Miles

-- 
Marriage, n. The state or condition of a community consisting of a master, a
mistress and two slaves, making in all, two.

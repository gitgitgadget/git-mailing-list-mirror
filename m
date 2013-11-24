From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] git-svn: Support svn:global-ignores property
Date: Sun, 24 Nov 2013 09:42:20 +0100
Message-ID: <87d2lqgphv.fsf@linux-k42r.v.cablecom.net>
References: <528DE354.1050804@ya.ru>
	<1385036908-10392-1-git-send-email-margtu-fivt@ya.ru>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Benoit Sigoure <tsuna@lrde.epita.fr>,
	Eric Wong <normalperson@yhbt.net>
To: Aleksey Vasenev <margtu-fivt@ya.ru>
X-From: git-owner@vger.kernel.org Sun Nov 24 09:42:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkVHB-0008E6-2r
	for gcvg-git-2@plane.gmane.org; Sun, 24 Nov 2013 09:42:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695Ab3KXImh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Nov 2013 03:42:37 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:53231 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754602Ab3KXIme (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 03:42:34 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 623554D6532;
	Sun, 24 Nov 2013 09:42:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id dukD7FPwfcfg; Sun, 24 Nov 2013 09:42:21 +0100 (CET)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (dslb-188-107-175-007.pools.arcor-ip.net [188.107.175.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 1E19D4D6414;
	Sun, 24 Nov 2013 09:42:21 +0100 (CET)
In-Reply-To: <1385036908-10392-1-git-send-email-margtu-fivt@ya.ru> (Aleksey
	Vasenev's message of "Thu, 21 Nov 2013 16:28:28 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238251>

Hi Aleksey

Thanks for your patch.  I added Eric Wong to the Cc list; all git-svn
patches should go to him.

Aleksey Vasenev <margtu-fivt@ya.ru> writes:

> ---

Can you write a commit message?  If you need a guideline for what to
write there, consider this snippet from Documentation/SubmittingPatches:

  The body should provide a meaningful commit message, which:

  . explains the problem the change tries to solve, iow, what is wrong
    with the current code without the change.

  . justifies the way the change solves the problem, iow, why the
    result with the change is better.

  . alternate solutions considered but discarded, if any.

In particular, I'm curious about how global-ignores are different from
ordinary ignores.  After reading

  http://svnbook.red-bean.com/en/1.7/svn.advanced.props.special.ignore.html

I don't understand why the above document speaks of a "config area" that
holds the global-ignores configuration, while your patch seems to treat
them as "just another property" set in the same way as existing
svn:ignore.  How does this work?


>  Documentation/git-svn.txt | 12 ++++++------
>  git-svn.perl              | 46 ++++++++++++++++++++++++++++++++--------------
>  2 files changed, 38 insertions(+), 20 deletions(-)

Can you add a test or two?

-- 
Thomas Rast
tr@thomasrast.ch

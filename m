From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Unresolved issues, "log --graph"
Date: Sun, 20 Apr 2008 18:48:48 +0300
Message-ID: <20080420154848.GA8647@mithlond.arda.local>
References: <7vbq46fe9h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Sun Apr 20 17:49:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jnbnf-00086t-Un
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 17:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735AbYDTPs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 11:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754794AbYDTPs4
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 11:48:56 -0400
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:36170 "EHLO
	pne-smtpout4-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754286AbYDTPsz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Apr 2008 11:48:55 -0400
Received: from mithlond.arda.local (80.220.180.181) by pne-smtpout4-sn1.fre.skanova.net (7.3.129)
        id 47A7970A00455FD2; Sun, 20 Apr 2008 17:48:50 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1Jnbma-0003HA-TH; Sun, 20 Apr 2008 18:48:48 +0300
Content-Disposition: inline
In-Reply-To: <7vbq46fe9h.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79959>

Junio C Hamano wrote (2008-04-19 01:19 -0700):

> Here is an "issues" list I am keeping track of on the back of my head
> (and in "TODO" file on 'todo' branch, which is not updated often
> enough).

> * log --graph (Adam Simpkins)

Hi Adam, any changes for modifying the "log --graph" patch series to
make it apply to the current development version of git? It would just
feel wrong if this apparently well-designed tool was left behind. Of
course it's up to you.

Some thoughts on the graph functionality: I have understood that many
Bazaar people like the way "bzr log" indents the log entries which
originate from other branches. This way Bazaar users can easily think in
terms of commits in the mainline and commits originating from feature
branches. I think this is useful distinction sometimes.

I just realised that Adam's "git log --graph" offers the same
functionality as "bzr log" but much better. With "git log --graph" user
can see the history the way "bzr log" displays it: the current branch is
on the leftmost graph line and can be seen as the "mainline" (if
wanted); commits coming from other branches are indented and appear in
separate graph lines. Yes, there is, and have been, "gitk" of course.
"log --graph" is just much closer to "bzr log" view. I think "git log"
is quite superiour as it allows many ways of viewing history.

From: "Philipp Marek" <philipp@marek.priv.at>
Subject: Feature request: show branches in interactive commit
Date: Thu, 28 Jun 2012 09:54:24 +0200
Message-ID: <fd93774cb5ed6d4dee090eb2b0be952e.squirrel@webmail.hitco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 28 10:00:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sk9em-0003VS-LT
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jun 2012 10:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754743Ab2F1IAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jun 2012 04:00:39 -0400
Received: from vps.hitco.at ([84.200.20.238]:34004 "EHLO vps.hitco.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753410Ab2F1IAi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2012 04:00:38 -0400
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jun 2012 04:00:38 EDT
Received: from localhost (localhost [127.0.0.1])
	by vps.hitco.at (Postfix) with ESMTP id D0DEA250AD0
	for <git@vger.kernel.org>; Thu, 28 Jun 2012 09:54:32 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at vps.hitco.at
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, FSL_RCVD_USER=0.001]
	autolearn=ham
Received: from vps.hitco.at ([127.0.0.1])
	by localhost (vps.hitco.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7ujLU9gKoFpm for <git@vger.kernel.org>;
	Thu, 28 Jun 2012 09:54:24 +0200 (CEST)
Received: from webmail.hitco.org (localhost [127.0.0.1])
	by vps.hitco.at (Postfix) with ESMTP id 087E5250A9A
	for <git@vger.kernel.org>; Thu, 28 Jun 2012 09:54:24 +0200 (CEST)
Received: from 86.59.100.100
        (SquirrelMail authenticated user flip)
        by webmail.hitco.org with HTTP;
        Thu, 28 Jun 2012 09:54:24 +0200
User-Agent: SquirrelMail/1.4.21
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200781>

Hello everyone,

I'd like to get a bit of additional output in "git rebase".

Say that "123458" is a commit with "branch1" associated; then I'd hope for output like

    pick 123456 ...
    pick 123457 ...
    pick 123458 ...
    #x git branch "branch1" --force # move the branch?
    pick 123459 ...
    pick 12345a ...

I have a few feature branches that are stacked upon each other; when moving a commit
"down" to the release-branch I'd like to have the other branches at the matching "new"
commit.

Of course I can simply fix up the "rebase" output in my editor - but I guess that might
help a few people, that's why I'm proposing it here.


[ Yes, perhaps I'm doing it wrong, and should be using merge or something else instead;
but it's the way I work, and I think it's a small enough change that won't cause
problems, so I'm asking for it. ]


Best regards,

Phil

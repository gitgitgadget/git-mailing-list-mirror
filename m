From: Scott Parish <sRp@srparish.net>
Subject: how to deal with conflicts after "git stash apply"?
Date: Sun, 21 Oct 2007 15:32:07 -0700
Message-ID: <20071021223206.GJ16291@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 22 00:32:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjjLM-0001NA-Ic
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 00:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbXJUWcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 18:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbXJUWcL
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 18:32:11 -0400
Received: from smtp-gw6.mailanyone.net ([208.70.128.57]:34560 "EHLO
	smtp-gw6.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbXJUWcK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 18:32:10 -0400
Received: from mailanyone.net
	by smtp-gw6.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP srp)
	id 1IjjL6-0004KQ-Of
	for git@vger.kernel.org; Sun, 21 Oct 2007 17:32:09 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 502
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Sun, 21 Oct 2007 15:32:08 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61919>

How is the intended way to deal with "git stash apply" conflicts?
If i just edit the file and remove the conflict, "git diff" gives
some really messed up output. Documentation for other commands and
conflicts suggest "git commit" after cleaning up the conflict, or
"git add", but in the case of "stash apply" i'm not ready for a
commit yet, and "git add" keeps "git diff" from showing any output.

Thanks for any clarification
sRp

-- 
Scott Parish
http://srparish.net/

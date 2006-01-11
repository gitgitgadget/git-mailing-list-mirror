From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: merging initial part of a branch?
Date: Wed, 11 Jan 2006 18:04:51 -0500
Message-ID: <20060111230451.GH8618@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 12 00:05:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewp1T-00020f-9D
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 00:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbWAKXEw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 18:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbWAKXEw
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 18:04:52 -0500
Received: from mail.fieldses.org ([66.93.2.214]:46217 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S932512AbWAKXEw
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 18:04:52 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1Ewp1P-00031x-5r
	for git@vger.kernel.org; Wed, 11 Jan 2006 18:04:51 -0500
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14522>

External kernel projects sometimes work only against major
releases--it's easier for their users/testers to find a major release
than a random git version, and at least in the early prototype stage, it
isn't critical to be working on the tip all the time.

Is there a simple way to say, for example, "merge in all the upstream
changes up to v2.6.15"?

It looks like git pull will only update me to the very tip of a branch.
I could create a new local branch that stops at v2.6.15, then pull from
that.  Can I accomplish the same thing somehow with just one git pull?
Or is there some other convenient shorthand that I've missed?

--b.

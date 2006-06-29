From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: rebasing trouble
Date: Thu, 29 Jun 2006 15:47:23 -0400
Message-ID: <20060629194723.GD14287@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jun 29 21:47:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw2U4-0005TY-FT
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 21:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWF2TrZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 15:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWF2TrZ
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 15:47:25 -0400
Received: from mail.fieldses.org ([66.93.2.214]:63972 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S932350AbWF2TrY
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 15:47:24 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.62)
	(envelope-from <bfields@fieldses.org>)
	id 1Fw2Tz-0007Sv-PG
	for git@vger.kernel.org; Thu, 29 Jun 2006 15:47:23 -0400
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22894>

I must be missing something obvious:

bfields@puzzle:linux-2.6$ git checkout -b TMP nfs-client-stable^^^
bfields@puzzle:linux-2.6$ git-describe
v2.6.17-rc6-g28df955
bfields@puzzle:linux-2.6$ git-rebase --onto v2.6.17 origin
Nothing to do.
bfields@puzzle:linux-2.6$ git-describe
v2.6.17

So the git-rebase just reset TMP to v2.6.17.  But I know that nfs-client-stable
isn't a subset of origin, so this doesn't make sense to me.

The tree in question is actually at git://linux-nfs.org/~bfields/linux.git, if
it matters.

--b.

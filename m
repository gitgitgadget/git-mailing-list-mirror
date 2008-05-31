From: Teemu Likonen <tlikonen@iki.fi>
Subject: Why does "git log --reverse -1" print the HEAD commit?
Date: Sat, 31 May 2008 17:11:02 +0300
Message-ID: <20080531141102.GA3035@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 31 16:12:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2RoM-0004S4-TU
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 16:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564AbYEaOLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 10:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752553AbYEaOLG
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 10:11:06 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:45320 "EHLO
	jenni2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752513AbYEaOLF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 10:11:05 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni2.rokki.sonera.fi (8.5.014)
        id 483E832F001AFA48 for git@vger.kernel.org; Sat, 31 May 2008 17:10:59 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1K2RnS-00013c-Ld
	for git@vger.kernel.org; Sat, 31 May 2008 17:11:02 +0300
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83385>

It feels wrong that "git log -1" and "git log --reverse -1" both print
the same commit: HEAD. Why is that?

Since "git log --reverse" starts from the bottom I'd have expected "-1"
to print one commit from the bottom.

From: Matthias Lederhofer <matled@gmx.net>
Subject: [BUG] git -p status does not use colors
Date: Fri, 16 Feb 2007 16:19:25 +0100
Message-ID: <20070216151925.GA28974@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 16 16:19:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI4sQ-0005WH-6f
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 16:19:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945912AbXBPPT3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 10:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945913AbXBPPT3
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 10:19:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:38333 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1945912AbXBPPT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 10:19:28 -0500
Received: (qmail invoked by alias); 16 Feb 2007 15:19:26 -0000
X-Provags-ID: V01U2FsdGVkX18jycoX9Y8jZcG73TWayG6rP+UQGTMjWlripCcZG7
	YLtg==
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39919>

git -p status starts the pager, then runs git-commit.sh (named
git-status) which in turn runs git-runstatus.  I guess the problem is
that git-runstatus cannot check that the pager was started and just
knows that stdout is no terminal.  Has anyone an idea how to fix
this?

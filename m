From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Tue, 30 Jan 2007 23:33:49 +0100
Message-ID: <20070130223349.GA30623@moooo.ath.cx>
References: <87odognuhl.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Tue Jan 30 23:34:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HC1Y6-0004VX-IC
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 23:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbXA3Wdy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 17:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbXA3Wdy
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 17:33:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:56430 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751859AbXA3Wdx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 17:33:53 -0500
Received: (qmail invoked by alias); 30 Jan 2007 22:33:52 -0000
Received: from pD9EB9796.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.151.150]
  by mail.gmx.net (mp030) with SMTP; 30 Jan 2007 23:33:52 +0100
X-Authenticated: #5358227
Mail-Followup-To: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <87odognuhl.wl%cworth@cworth.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38210>

How about this:

Create a directory, change into it and run git-init-db.
Get the latest version:
$ git fetch --force URL branch:origin
$ git reset --hard origin
Warning: this will overwrite changes you made to files in the
repository (e.g. the Makefile).

You can also drop the --force if you're sure your branch will always
fast-forward.

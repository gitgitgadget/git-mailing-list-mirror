From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: "git clone" executed as root on solaris 10 shreds UFS (it is
	possible to create hardlinks for directories as root under solaris)
Date: Mon, 16 Jul 2007 19:17:32 +0200
Message-ID: <20070716171732.GE6134@cip.informatik.uni-erlangen.de>
References: <20070716100803.GA24036@cip.informatik.uni-erlangen.de> <20070716133602.GB26675@cip.informatik.uni-erlangen.de> <alpine.LFD.0.999.0707161001300.20061@woody.linux-foundation.org> <alpine.LFD.0.999.0707161004550.20061@woody.linux-foundation.org> <20070716100803.GA24036@cip.informatik.uni-erlangen.de> <20070716133602.GB26675@cip.informatik.uni-erlangen.de> <alpine.LFD.0.999.0707161001300.20061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 19:17:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAUCW-00049w-AM
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 19:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbXGPRRd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 13:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752836AbXGPRRd
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 13:17:33 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:44890 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750980AbXGPRRc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 13:17:32 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 33C453F434; Mon, 16 Jul 2007 19:17:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707161004550.20061@woody.linux-foundation.org> <alpine.LFD.0.999.0707161001300.20061@woody.linux-foundation.org>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52692>

Hello Linus,

> I'd suggest making a bug-report. ENOTEMPTY is not an optional error.
> Posix says "Shall fail".  The "unlink directories" is so old-fashioned
> that it's not even funny. The whole reason "rmdir()" was created was
> to *not* have that behaviour in the OS. 

I asked the UFS maintainer to reconsider to fix this.

        Thomas

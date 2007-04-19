From: Eric Wong <normalperson@yhbt.net>
Subject: [RFH] Re: Segmentation fault in git-svn
Date: Thu, 19 Apr 2007 14:31:12 -0700
Message-ID: <20070419213112.GA24780@muzzle>
References: <4623F613.5010108@midwinter.com> <20070417093743.GA9222@muzzle> <20070417095509.GA24800@muzzle> <20070418090143.GA11894@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 23:31:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeeEH-0005na-FL
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 23:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767001AbXDSVbP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 17:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767002AbXDSVbP
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 17:31:15 -0400
Received: from hand.yhbt.net ([66.150.188.102]:56892 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422667AbXDSVbO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 17:31:14 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 492CC2DC01A;
	Thu, 19 Apr 2007 14:31:12 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 19 Apr 2007 14:31:12 -0700
Content-Disposition: inline
In-Reply-To: <20070418090143.GA11894@muzzle>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45046>

Eric Wong <normalperson@yhbt.net> wrote:
> Eric Wong <normalperson@yhbt.net> wrote:
> The verdict is still out on all patches and attempts I've posted
> to fix the segfault.  I'm quite busy at the moment and won't
> be attending to git-svn things for another few days.

Ok, those didn't work.  I'm still preoccupied with another project
that has a higher priority; and I've come down with a cold so
if anybody else wants to step up to the plate, please take a stab
at it.

This issue has NOT been known to cause data corruption from any
users that experienced it[1].  It seems to be happening
in between when changesets are actually fetched.

[1] - if there is any corruption to a particular file, it'll
 trigger an MD5 mismatch the next time that file is updated.

-- 
Eric Wong

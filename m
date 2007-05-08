From: Paul Mackerras <paulus@samba.org>
Subject: Re: FFmpeg considering GIT
Date: Tue, 8 May 2007 14:06:57 +1000
Message-ID: <17983.63329.314321.305860@cargo.ozlabs.ibm.com>
References: <57600.59393.qm@web38909.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Karl Hasselstr?m <kha@treskal.com>,
	Junio C Hamano <junkio@cox.net>,
	Carl Worth <cworth@cworth.org>,
	Michael Niedermayer <michaelni@gmx.at>,
	Git Mailing List <git@vger.kernel.org>
To: Brett Schwarz <brett_schwarz@yahoo.com>
X-From: git-owner@vger.kernel.org Tue May 08 06:07:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlGyy-0005Jb-Jd
	for gcvg-git@gmane.org; Tue, 08 May 2007 06:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967735AbXEHEHR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 00:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967763AbXEHEHR
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 00:07:17 -0400
Received: from ozlabs.org ([203.10.76.45]:34533 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967735AbXEHEHP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 00:07:15 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 8EC79DDDFE; Tue,  8 May 2007 14:07:14 +1000 (EST)
In-Reply-To: <57600.59393.qm@web38909.mail.mud.yahoo.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46533>

Brett Schwarz writes:

> What is the real issue? Is it that there isn't enough people to

The real issue is that I would like, if possible, to make it easier
for people like Linus to hack on gitk and add cool features that I
wouldn't necessarily think of.

> maintain gitk? I've been hiding in the bushes, mostly because of
> time issues, but if there's a real need, I'd be willing to help. I'm
> a seasoned Tcl/Tk coder, and wouldn't have any problems helping
> out.

That could be very useful, thanks.

> As Shawn mentions below, he started using namespaces for git-gui. I
> think gitk could benefit from that as well, along with a few other
> changes.

Gitk ends up handling pretty significant amounts of data.  In
particular the per-commit data can get to gigabytes, and processing it
is pretty cpu-intensive.  I did try using namespaces for the
per-commit data but I found that the performance hit to be more than I
was willing to tolerate.

Paul.

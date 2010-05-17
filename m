From: Jeff King <peff@peff.net>
Subject: Re: Question: start mergetool with trivial differences already
 handled?
Date: Mon, 17 May 2010 18:41:17 -0400
Message-ID: <20100517224117.GA12092@coredump.intra.peff.net>
References: <AANLkTinYq5LKcY8EDzfCGRoEYXftcd15Dviww749uBUC@mail.gmail.com>
 <AANLkTiliNtjh6FsGW_S2BRN_C_WjDzdlMxMg90Kekb5G@mail.gmail.com>
 <AANLkTilLX8fWto-xL261Bkj_2fhRDqBPakP7l83QNDBj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	The Git Mailing List <git@vger.kernel.org>
To: Uri Okrent <uokrent@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 18 00:41:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OE903-0004B6-Rv
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 00:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756582Ab0EQWlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 18:41:18 -0400
Received: from peff.net ([208.65.91.99]:42853 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756532Ab0EQWlP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 18:41:15 -0400
Received: (qmail 8559 invoked by uid 107); 17 May 2010 22:41:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 17 May 2010 18:41:41 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 17 May 2010 18:41:17 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTilLX8fWto-xL261Bkj_2fhRDqBPakP7l83QNDBj@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147263>

On Mon, May 17, 2010 at 03:23:11PM -0700, Uri Okrent wrote:

> I haven't found this to be the case.  Is there a merge tool that can
> do this?  I had assumed that git used some magic using the project's
> history in order to resolve conflicts in a smart way.  Will a merge tool
> that only has $THEIRS, $OURS, and $BASE have enough information to
> resolve conflicts as smart as git itself does when it produces the
> unmerged file in your working tree?

Git uses only $THEIRS, $OURS, and $BASE to do the merge. It doesn't look
at the interim history at all.

> > Most of the tools that mergetool supports out-of-the-box perform 3-way
> > diffs, so I guess I'm curious what merge tool you're using.
> I use xxdiff or diffuse (or more frequently, vim ;))

If you're using xxdiff, try "Global > Merge" from the menu (or the
Ctrl-Alt-M shortcut) to have it automatically merge any non-contentious
bits.

-Peff

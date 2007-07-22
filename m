From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Add to gitk an --argscmd flag to get the list of refs to draw
	at refresh time.
Date: Sun, 22 Jul 2007 22:24:55 +1000
Message-ID: <18083.19607.236048.797818@cargo.ozlabs.ibm.com>
References: <20070712220411.31743.83101.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sun Jul 22 14:29:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICaYa-00075w-Fv
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 14:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763353AbXGVM3B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 08:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764457AbXGVM3B
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 08:29:01 -0400
Received: from ozlabs.org ([203.10.76.45]:57804 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762718AbXGVM3A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 08:29:00 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 2748FDDEF2; Sun, 22 Jul 2007 22:28:59 +1000 (EST)
In-Reply-To: <20070712220411.31743.83101.stgit@gandelf.nowhere.earth>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53261>

Yann Dirson writes:

> This new version causes the command to add its revs to the litteral
> ones from command-line instead of overriding them, and allows to
> edit the command in the view editor.

Is it actually useful to use both the --argscmd flag and some literal
revisions on the command line?  Why would you use both?

Instead of the --argscmd flag, maybe we could have a convention that
an argument starting with "|" is a command to run rather than a
literal revision.  Would that suit?  It would seem to simplify the
patch by eliminating the requirement for an extra entry field, as well
as removing the need for the separate viewargscmd array.

> Disclaimer: I'm no tcl/tk expert, feel free to flame my style :)

There are a couple of things I think should be done differently, in
fact. :)

Paul.

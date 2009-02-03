From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git gtk+/GNOME gui application: gitg
Date: Tue, 03 Feb 2009 17:58:15 +0100
Message-ID: <498877A7.3050308@drmicha.warpmail.net>
References: <1233432317.26364.5.camel@wren>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jesse van den Kieboom <jesse@icecrew.nl>
X-From: git-owner@vger.kernel.org Tue Feb 03 17:59:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUOcn-0000oM-I9
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 17:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754928AbZBCQ6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 11:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754635AbZBCQ6W
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 11:58:22 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:47734 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754116AbZBCQ6W (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Feb 2009 11:58:22 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id C74B727DF7F;
	Tue,  3 Feb 2009 11:58:19 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 03 Feb 2009 11:58:19 -0500
X-Sasl-enc: huZVQs9s95NnxgLfN4U5X0hM3lpEPPXI78A9Mbzt0lJP 1233680299
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 354CFC550;
	Tue,  3 Feb 2009 11:58:19 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <1233432317.26364.5.camel@wren>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108214>

Jesse van den Kieboom venit, vidit, dixit 31.01.2009 21:05:
> Hi,
> 
> I have been developing a gui application for git for gtk+/GNOME based on
> GitX (which in turn is based on gitk). I feel that it's reaching the
> point where it might potentially be useful for other people to use. It
> currently features:
> 
> - Loading large repositories very fast
> - Show/browse repository history
> - Show highlighted revision diff
> - Browse file tree of a revision and export by drag and drop
> - Search in the revision history on subject, author or hash
> - Switch between history view of branches easily
> - Commit view providing per hunk stage/unstage and commit
> 
> The project is currently hosted on github:
> http://github.com/jessevdk/gitg
> 
> clone: git://github.com/jessevdk/gitg.git
> 
> Please let me know what you think,

Not yet another one, please!

I'm sorry, but that was my first thought. I lost count of how many
half-finished GUIs we have, using tcl/tk, gtk, qt, you-name-it-tk. I
still don't see any which provide a consistent, "modern", stable GUI for
viewing *and* committing, i.e. a replacement for gitk and git-gui.

The latter two still seem to be the most feature rich choices, but they
suffer somewhat from their implementation language. Just look at the git
survey and you know why nobody wants to work on them.

So, while any effort in enhancing the git environment is appreciated (I
do appreciate yours), we recently see an increased splitting of efforts
(web site, doc, lib, gui,...) rather than collaborative work. Maybe we
can create a "git-gui-ng community", or even two for gtk and qt if it
must be, but not more? A new "standard" gui which focusses most talents
and efforts?

Cheers,
Michael

The current tk high score list according to git.or.cz, including yours:

Qt3/4 : ******
GTK+  : ***
Tcl/Tk: **
Cocoa : **
MFC   : **
curses: *

Of the more modern tks, qt should be the most cross-platform solution.
Do we have a winner here?

From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] user-manual: Explain what submodules are good for.
Date: Mon, 24 Sep 2007 17:33:42 -0400
Message-ID: <20070924213342.GL26387@fieldses.org>
References: <20070923172702.GA5916@fieldses.org> <11906036491118-git-send-email-msmith@cbnco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>
To: Michael Smith <msmith@cbnco.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 23:34:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZvYx-0006x4-Cx
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 23:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756231AbXIXVds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 17:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756121AbXIXVds
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 17:33:48 -0400
Received: from mail.fieldses.org ([66.93.2.214]:59644 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755992AbXIXVdr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 17:33:47 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IZvYk-0001ky-MF; Mon, 24 Sep 2007 17:33:42 -0400
Content-Disposition: inline
In-Reply-To: <11906036491118-git-send-email-msmith@cbnco.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59077>

On Sun, Sep 23, 2007 at 11:14:09PM -0400, Michael Smith wrote:
> Rework the introduction to the Submodules section to explain why
> someone would use them, and fix up submodule references from the
> tree-object and todo sections.

Thanks!

> +Some large projects are composed of smaller, self-contained parts.  For
> +example, an embedded Linux distribution's source tree would include every
> +piece of software in the distribution; a movie player might need to build
> +against a specific, known-working version of a decompression library;
> +several independent programs might all share the same build scripts.
...
> +Git's submodule support allows a repository to contain, as a subdirectory, a
> +checkout of an external project.  Submodules maintain their own identity;
> +the submodule support just stores the submodule repository location and
> +commit ID, so other developers who clone the superproject can easily clone
> +all the submodules at the same revision.  The gitlink:git-submodule[1]
> +command manages submodules.

That looks helpful, thanks, but a little more detail might be nice.

Imagining myself as a reader trying to decide whether to use submodules
in a given case, I'm not sure this would tell me everything I need to
know.  For example, how does this compare to just importing a snapshot
of the library into your tree?  (Or possibly using the subtree merge
strategy?)

Some issues that pop to mind are scalability (when does a monolithic
tree get too large to work with?) and backwards compatibility (what
version does everybody working on your project need to have for it to
work?  What problems will you see if a few people are stuck with an
older git?)  I haven't followed submodule development, though, so may
have missed more important issues.

--b.

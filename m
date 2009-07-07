From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git fast-import file format question
Date: Tue, 7 Jul 2009 12:10:55 -0700
Message-ID: <20090707191055.GA11191@spearce.org>
References: <1e30a6d10907071206u21ecd9d8wb53441a3bf7b64c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Troy Telford <ttelford.groups@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 21:11:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOG4E-0003fa-Kn
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 21:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754794AbZGGTK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 15:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754379AbZGGTK4
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 15:10:56 -0400
Received: from george.spearce.org ([209.20.77.23]:41760 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753781AbZGGTKz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 15:10:55 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3065C38195; Tue,  7 Jul 2009 19:10:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1e30a6d10907071206u21ecd9d8wb53441a3bf7b64c4@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122859>

Troy Telford <ttelford.groups@gmail.com> wrote:
> When I was looking at the man page for git-fast-import (and looking at
> the output of git-fast-export for a valid git repo), I noted the
> "from" directive.  There's a clip there that tells me that "Omitting
> the from command on existing branches is usually desired, as the
> current commit on that branch is automatically assumed to be the first
> ancestor of the new commit."

That section meant "existing branches within this import session".

To restart an import, you need to use the from command in the
first commit of that session, e.g. to restart an import on
refs/heads/master use:

  from refs/heads/master^0

-- 
Shawn.

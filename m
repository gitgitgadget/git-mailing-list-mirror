From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Getting a file revision
Date: Sat, 18 Aug 2007 20:52:29 -0400
Message-ID: <20070819005229.GA12095@fieldses.org>
References: <7ac1e90c0708181742w531dab4asc7c90835cc56e8a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bahadir Balban <bahadir.balban@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 19 02:53:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMZ2Q-0002fH-W8
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 02:53:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753629AbXHSAw5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Aug 2007 20:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754151AbXHSAw5
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Aug 2007 20:52:57 -0400
Received: from mail.fieldses.org ([66.93.2.214]:54835 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753618AbXHSAwa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2007 20:52:30 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IMZ1p-0003jS-4w; Sat, 18 Aug 2007 20:52:29 -0400
Content-Disposition: inline
In-Reply-To: <7ac1e90c0708181742w531dab4asc7c90835cc56e8a1@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56121>

On Sun, Aug 19, 2007 at 01:42:30AM +0100, Bahadir Balban wrote:
> This might sound like a novice question but anyway: I sometimes have a
> need to quickly recover an old revision of a file just to check
> something or copy some code from it. I would imagine having a command
> like:
> 
> git-getrev <filename> <commit> or something, and the file would appear
> in its path, or the git root directory as <filename>.<commit>
> 
> Is there an existing way to achieve a similar result? I can certainly
> checkout a branch, revert to that commit I want, copy the file, and
> come back to HEAD, but its not as quick.

Easiest is probably to use git-show together with the
<commit>:<filename> syntax, so e.g.:

	git show v1.4:src/main.c
	git show 74ace5df:Makefile >Makefile.tmp

--b.

From: Frank Lichtenheld <djpig@debian.org>
Subject: Re: [PATCH] Create a new manpage for the gitignore format, and reference it elsewhere
Date: Sat, 2 Jun 2007 01:47:10 +0200
Message-ID: <20070601234710.GW3242@planck.djpig.de>
References: <46609BC4.9000508@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, 427078@bugs.debian.org
To: Josh Triplett <josh@freedesktop.org>
X-From: git-owner@vger.kernel.org Sat Jun 02 01:47:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuGqP-00006q-CZ
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 01:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756112AbXFAXrS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 19:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757345AbXFAXrS
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 19:47:18 -0400
Received: from planck.djpig.de ([85.10.192.180]:2759 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756112AbXFAXrR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 19:47:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id E6E2E881B4;
	Sat,  2 Jun 2007 01:47:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UsZeQZ3x5jQq; Sat,  2 Jun 2007 01:47:11 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 16D1F881B5; Sat,  2 Jun 2007 01:47:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46609BC4.9000508@freedesktop.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48899>

Cool :)

Some remarks below.

On Fri, Jun 01, 2007 at 03:20:52PM -0700, Josh Triplett wrote:
> Signed-off-by: Josh Triplett <josh@freedesktop.org>
> Signed-off-by: Josh Triplett <josh@freedesktop.org>

:) (Wanted to make some funny remark, but its too late here to be funny
in a foreign language...)

>  Documentation
>  --------------
> -Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
> +Documentation by David Greaves, Junio C Hamano, Josh Triplett, and the git-list <git@vger.kernel.org>.

No offence, but adding your name here for removing content? ;)

> +Some git plumbing tools, such as git-ls-files(1) and
> +git-read-tree(1), read `gitignore` patterns specified by
> +command-line options, or from files specified by command-line
> +options.

Missing gitlink:

Also I don't like the paragraph. It should probably mention that
these programs actually implement the behaviour described, that
they aren't hardcoded to the mentioned filenames and that
all git porcelain just happens to call them with them.

But, as said, too late here for proper English ;)

> +Patterns have the following format:
> +
> + - A blank line matches no files, so it can serve as a separator
> +   for readability.
> +
> + - A line starting with # 

Is here missing something?

> + - Otherwise, git treats the pattern as a shell glob suitable
> +   for consumption by fnmatch(3) with the FNM_PATHNAME flag: any
> +   slash in the pattern must match a slash in the pathname.  For
> +   example, "Documentation/\*.html" matches
> +   "Documentation/git.html" but not "ppc/ppc.html".  A leading
> +   slash matches the beginning of the pathname; for example,
> +   "/*.c" matches "cat-file.c" but not "mozilla-sha1/sha1.c".

I realise this is copy&paste but shouldn't that read:
"Documentation/\*.html" matches "Documentation/git.html"
but not "Documentation/ppc/ppc.html"
?

> +Documentation
> +-------------
> +Documentation by Josh Triplett.

No offence again, but given the amount of copy&paste, maybe the names from
git-ls-files should also be added here.

Gruesse,
-- 
Frank Lichtenheld <djpig@debian.org>
www: http://www.djpig.de/

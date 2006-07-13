From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: Fix ssh:// URLs in generated documentation
Date: Wed, 12 Jul 2006 21:58:50 -0700
Message-ID: <7vpsgaw16d.fsf@assigned-by-dhcp.cox.net>
References: <11527413212127-git-send-email-alp@atoker.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 06:58:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0tHt-0005ty-1L
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 06:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbWGME6x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 00:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbWGME6x
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 00:58:53 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:33971 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932505AbWGME6w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 00:58:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060713045851.MRUC12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Jul 2006 00:58:51 -0400
To: Alp Toker <alp@atoker.com>
In-Reply-To: <11527413212127-git-send-email-alp@atoker.com> (Alp Toker's
	message of "Wed, 12 Jul 2006 22:55:21 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23812>

Alp Toker <alp@atoker.com> writes:

> Commit c3f17061be95de3498449a548e93883aebff23d6 was causing warnings
> during doc generation due to bad asciidoc markup.
>
> This resulted in "ssh://[user@]host.xz/path/to/repo.git/" being rendered
> as "host.xz/path/to/repo.git/" in the man pages and html output.

I wonder if this is with less formatting impact then.

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 9abec80..93378d2 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -10,9 +10,9 @@ to name the remote repository:
 - https://host.xz/path/to/repo.git/
 - git://host.xz/path/to/repo.git/
 - git://host.xz/~user/path/to/repo.git/
-- ssh://[user@]host.xz/path/to/repo.git/
-- ssh://[user@]host.xz/~user/path/to/repo.git/
-- ssh://[user@]host.xz/~/path/to/repo.git
+- ssh://+++[user@+++]host.xz/path/to/repo.git/
+- ssh://+++[user@+++]host.xz/~user/path/to/repo.git/
+- ssh://+++[user@+++]host.xz/~/path/to/repo.git
 ===============================================================
 
 SSH Is the default transport protocol and also supports an

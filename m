From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Mention html doc location http://www.kernel.org in DESCRIPTION
Date: Mon, 30 Apr 2007 16:44:15 -0700
Message-ID: <7v8xc9bf74.fsf@assigned-by-dhcp.cox.net>
References: <mz0qxg3h.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Tue May 01 01:44:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HifXZ-0001ay-6U
	for gcvg-git@gmane.org; Tue, 01 May 2007 01:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946122AbXD3XoR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 19:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946126AbXD3XoR
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 19:44:17 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:35900 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946122AbXD3XoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 19:44:16 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070430234415.JHTP22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Mon, 30 Apr 2007 19:44:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id tbkE1W00b1kojtg0000000; Mon, 30 Apr 2007 19:44:15 -0400
In-Reply-To: <mz0qxg3h.fsf@cante.net> (Jari Aalto's message of "Mon, 30 Apr
	2007 14:21:38 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45901>

Jari Aalto <jari.aalto@cante.net> writes:

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index c5d02da..c3e1afe 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -18,7 +18,7 @@ Git is a fast, scalable, distributed revision control system with an
>  unusually rich command set that provides both high-level operations
>  and full access to internals.
>  
> -See this link:tutorial.html[tutorial] to get started, then see
> +See[*] link:tutorial.html[tutorial] to get started, then see
>  link:everyday.html[Everyday Git] for a useful minimum set of commands, and
>  "man git-commandname" for documentation of each command.  CVS users may
>  also want to read link:cvs-migration.html[CVS migration].
> @@ -29,6 +29,8 @@ in a coherent way to git enlightenment ;-).
>  The COMMAND is either a name of a Git command (see below) or an alias
>  as defined in the configuration file (see gitlink:git-config[1]).
>  
> +[*] http://www.kernel.org/pub/software/scm/git/docs/
> +

This may look Ok in ascii version of the manpage, but looks
quite suboptimal in its HTML rendition.  I do not know how bad
it would be if the manpage is printed (i.e. troff).

I'll replace with this.

-- >8 --
From: Jari Aalto <jari.aalto@cante.net>
Date: Mon, 30 Apr 2007 14:21:38 +0300
Subject: [PATCH] git.7: Mention preformatted html doc location

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index c81162e..aa65802 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -29,6 +29,10 @@ in a coherent way to git enlightenment ;-).
 The COMMAND is either a name of a Git command (see below) or an alias
 as defined in the configuration file (see gitlink:git-config[1]).
 
+Formatted and hyperlinked version of the latest git
+documentation can be viewed at
+`http://www.kernel.org/pub/software/scm/git/docs/`.
+
 ifdef::stalenotes[]
 [NOTE]
 ============
-- 
1.5.2.rc0.781.g5868

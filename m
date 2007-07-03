From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Remove obsolete commit-walkers
Date: Mon, 02 Jul 2007 23:22:05 -0700
Message-ID: <7vwsxiroqa.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707030128110.14638@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Jul 03 08:22:13 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5bm8-0006LF-KW
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 08:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072AbXGCGWI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 02:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753016AbXGCGWH
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 02:22:07 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:62839 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072AbXGCGWG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 02:22:06 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070703062206.CWNX1257.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Jul 2007 02:22:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JuN51X0061kojtg0000000; Tue, 03 Jul 2007 02:22:06 -0400
In-Reply-To: <Pine.LNX.4.64.0707030128110.14638@iabervon.org> (Daniel
	Barkalow's message of "Tue, 3 Jul 2007 01:28:16 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51461>

I'll apply this after 1.5.3.  In the meantime, I'll do this for 1.5.3.

diff --git a/Documentation/git-local-fetch.txt b/Documentation/git-local-fetch.txt
index 19b5f88..141b767 100644
--- a/Documentation/git-local-fetch.txt
+++ b/Documentation/git-local-fetch.txt
@@ -14,6 +14,8 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
+THIS COMMAND IS DEPRECATED.
+
 Duplicates another git repository on a local system.
 
 OPTIONS
diff --git a/Documentation/git-ssh-fetch.txt b/Documentation/git-ssh-fetch.txt
index aaf3db0..8d3e2ff 100644
--- a/Documentation/git-ssh-fetch.txt
+++ b/Documentation/git-ssh-fetch.txt
@@ -13,6 +13,8 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
+THIS COMMAND IS DEPRECATED.
+
 Pulls from a remote repository over ssh connection, invoking
 git-ssh-upload on the other end. It functions identically to
 git-ssh-upload, aside from which end you run it on.
diff --git a/Documentation/git-ssh-upload.txt b/Documentation/git-ssh-upload.txt
index 4796224..5e2ca8d 100644
--- a/Documentation/git-ssh-upload.txt
+++ b/Documentation/git-ssh-upload.txt
@@ -12,6 +12,8 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
+THIS COMMAND IS DEPRECATED.
+
 Pushes from a remote repository over ssh connection, invoking
 git-ssh-fetch on the other end. It functions identically to
 git-ssh-fetch, aside from which end you run it on.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] rev-list: make --max- and --min-age a bit more usable.
Date: Wed, 02 Nov 2005 23:40:21 -0800
Message-ID: <7v64ranpqy.fsf@assigned-by-dhcp.cox.net>
References: <7vd5lnztav.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510301838110.27915@g5.osdl.org>
	<7vbr12swj3.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511021908220.27915@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 08:41:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXZi3-0003nv-2k
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 08:40:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbVKCHkY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 02:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbVKCHkY
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 02:40:24 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:38827 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750811AbVKCHkX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 02:40:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051103073958.ZEPG9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 3 Nov 2005 02:39:58 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511021908220.27915@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 2 Nov 2005 19:11:00 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11066>

Linus Torvalds <torvalds@osdl.org> writes:

> All the magic is in "git-rev-parse". Try it.

Ahhhh.  I missed that.  Thanks.

-- >8 -- cut here -- >8 --
Document --since and --until options to rev-parse.

The usability magic were hidden in the source code without being
documented, and even the maintainer did not know about them ;-).

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 099db29..8b8068c 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -72,6 +72,14 @@ OPTIONS
 	path of the current directory relative to the top-level
 	directory.
 
+--since=datestring, --after=datestring::
+	Parses the date string, and outputs corresponding
+	--max-age= parameter for git-rev-list command.
+
+--until=datestring, --before=datestring::
+	Parses the date string, and outputs corresponding
+	--min-age= parameter for git-rev-list command.
+
 <args>...::
 	Flags and parameters to be parsed.
 

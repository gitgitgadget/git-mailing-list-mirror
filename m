From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff.c: respect diff.renames config option
Date: Fri, 07 Jul 2006 05:29:52 -0700
Message-ID: <7vwtapy4vz.fsf@assigned-by-dhcp.cox.net>
References: <11522670452824-git-send-email-normalperson@yhbt.net>
	<11522670473116-git-send-email-normalperson@yhbt.net>
	<7v7j2p3eac.fsf@assigned-by-dhcp.cox.net>
	<20060707110123.GA23400@soma>
	<7vpsghzmr1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 07 14:30:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FypT3-0001g9-EG
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 14:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWGGM3y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 08:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWGGM3y
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 08:29:54 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:19179 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932140AbWGGM3x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jul 2006 08:29:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060707122953.PHAY12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Jul 2006 08:29:53 -0400
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <7vpsghzmr1.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 07 Jul 2006 04:18:42 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23437>

In the same spirit...

From: Junio C Hamano <junkio@cox.net>
Date: Fri, 7 Jul 2006 05:27:24 -0700
Subject: [PATCH] diff.c: --no-color to defeat diff.color configuration.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 diff.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 2534fce..39e608f 100644
--- a/diff.c
+++ b/diff.c
@@ -1622,6 +1622,8 @@ int diff_opt_parse(struct diff_options *
 	}
 	else if (!strcmp(arg, "--color"))
 		options->color_diff = 1;
+	else if (!strcmp(arg, "--no-color"))
+		options->color_diff = 0;
 	else if (!strcmp(arg, "-w") || !strcmp(arg, "--ignore-all-space"))
 		options->xdl_opts |= XDF_IGNORE_WHITESPACE;
 	else if (!strcmp(arg, "-b") || !strcmp(arg, "--ignore-space-change"))
-- 
1.4.1.gfff4c

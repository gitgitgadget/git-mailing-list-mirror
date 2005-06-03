From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/4] Fix -B "very-different" logic.
Date: Fri, 03 Jun 2005 01:32:00 -0700
Message-ID: <7vis0vq1rz.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
	<m1psv7bjb6.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0505312002160.1876@ppc970.osdl.org>
	<7vmzqau3es.fsf@assigned-by-dhcp.cox.net>
	<7vll5sz54z.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506021716140.1876@ppc970.osdl.org>
	<7vis0wusv5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 10:30:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1De7Y3-00071M-Sp
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 10:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVFCIcF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 04:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVFCIcF
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 04:32:05 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:60553 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261178AbVFCIcC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2005 04:32:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050603083200.PBBI20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Jun 2005 04:32:00 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vis0wusv5.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Thu, 02 Jun 2005 18:33:18 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I am sending the following four patch series:

        [PATCH 1/4] Tweak count-delta interface
        [PATCH 2/4] diff: Fix docs and add -O to diff-helper.
        [PATCH 3/4] diff: Clean up diff_scoreopt_parse().
        [PATCH 4/4] diff: Update -B heuristics.

The first three are preparations and cleanups I found necessary
while I was working on the last one, which is the gem of this
series.  It addresses the concerns you raised in your message
"Careful." while keeping the semantics I wanted to have "if you
keep 97 lines out of original 100-line document, it does not
matter if the end result is a 110-line or 1000-line document.
You did not do a rewrite."

You may have to remove the warning about git-status with this
change, though.


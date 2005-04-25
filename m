From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/2] diff-tree/diff-cache helper
Date: Sun, 24 Apr 2005 22:12:16 -0700
Message-ID: <7v1x8zsamn.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504232202340.19877@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 07:07:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPvow-0004Lq-O1
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 07:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262537AbVDYFMo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 01:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbVDYFMo
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 01:12:44 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:50337 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262537AbVDYFMn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 01:12:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050425051216.DHID22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 25 Apr 2005 01:12:16 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504232202340.19877@ppc970.osdl.org> (Linus
 Torvalds's message of "Sat, 23 Apr 2005 22:09:02 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I use a set of small scripts [*1*] directly on top of the core
git, which needed to make patches out of diff-tree and
diff-cache output.  Its output is compatible with what show-diff
produces.

Since this helper program would be generally useful for other
wrapper layer programs like Cogito, I am submitting it in two
parts.  The first part is to rip out the external diff program
interface part out of show-diff.c and moving it into a common
library.  The second part introduces the diff-tree-helper
program.

[Footnotes]

*1* This is found at http://members.cox.net/junkio/


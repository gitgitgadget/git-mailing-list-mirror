From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/2] Introducing git-run-with-user-path program.
Date: Sun, 15 May 2005 23:04:19 -0700
Message-ID: <7vu0l3puzg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Mon May 16 08:04:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXYi9-0000F6-9z
	for gcvg-git@gmane.org; Mon, 16 May 2005 08:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVEPGE2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 May 2005 02:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVEPGE2
	(ORCPT <rfc822;git-outgoing>); Mon, 16 May 2005 02:04:28 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:47068 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261230AbVEPGEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2005 02:04:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050516060421.HRIL12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 16 May 2005 02:04:21 -0400
To: pasky@ucw.cz
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a new series I've mentioned earlier today.

 [PATCH 1/2] Introduce git-run-with-user-path helper program.
 [PATCH 2/2] Add sample ignore logic to git-run-with-user-path command.

The first one adds a path canonicalization helper with path
ignore hooks but no ignore logic implementation (it passes
everything that passes verify_path()).  The second one adds a
sample ignore logic implementation using PCRE.

Although the second one is done primarily as an example and to
start a mailing list discussion, it should be also safe to merge
if you decide to take patch 1, because the logic is used only by
git-run-with-user-path which is a new program. no Porcelain uses
right now.



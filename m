From: Junio C Hamano <junkio@cox.net>
Subject: GIT 0.99.8c
Date: Mon, 10 Oct 2005 17:38:36 -0700
Message-ID: <7vfyr828hf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Oct 11 02:39:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP8AD-0005rw-Id
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 02:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbVJKAii (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 20:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbVJKAii
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 20:38:38 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:5345 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751317AbVJKAii (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 20:38:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051011003838.BUSM9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Oct 2005 20:38:38 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9950>

Among some cosmetic fixes, contains one important fix by Robert
Fitzsimmons to unconfuse git-ls-tree.  When two identical blobs
or trees were contained in a tree, the earlier code mislabeled
them in the output.

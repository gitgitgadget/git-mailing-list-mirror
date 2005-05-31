From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] allow pathspec to end with a slash
Date: Tue, 31 May 2005 13:08:37 -0700
Message-ID: <7vll5vxinu.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505310827330.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 22:08:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdD1n-0003fT-3E
	for gcvg-git@gmane.org; Tue, 31 May 2005 22:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVEaUKH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 16:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVEaUKH
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 16:10:07 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:52902 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261420AbVEaUIm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2005 16:08:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050531200838.PSQB20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 31 May 2005 16:08:38 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505310827330.1876@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 31 May 2005 08:32:15 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Do you want the same for git-ls-tree as well?  That is, when
you have drivers/char as a blob in the tree, should

	git-ls-tree $tree drivers/char/

show nothing?



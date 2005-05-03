From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add exclude file support to cg-status
Date: Mon, 02 May 2005 18:09:19 -0700
Message-ID: <7vd5s9nmio.fsf@assigned-by-dhcp.cox.net>
References: <20050502171042.A24299@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 03:04:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSlox-0004OF-EX
	for gcvg-git@gmane.org; Tue, 03 May 2005 03:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVECBJY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 21:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVECBJY
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 21:09:24 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:10225 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261264AbVECBJV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2005 21:09:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050503010918.JSZW550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 2 May 2005 21:09:18 -0400
To: Matt Porter <mporter@kernel.crashing.org>
In-Reply-To: <20050502171042.A24299@cox.net> (Matt Porter's message of "Mon,
 2 May 2005 17:10:42 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "MP" == Matt Porter <mporter@kernel.crashing.org> writes:

MP> Adds a trivial per-repository exclude file implementation for
MP> cg-status on top of the new git-ls-files option.

 
MP> +EXCLUDEFILE=.git/exclude

Good intentions, but shouldn't the file be .git/info/exclude
(i.e. under .git/info)?


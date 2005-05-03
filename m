From: Junio C Hamano <junkio@cox.net>
Subject: Re: PATCH: diff-cache.c:51: `return' with a value, in function
 returning void
Date: Tue, 03 May 2005 14:33:22 -0700
Message-ID: <7vmzrct2ot.fsf@assigned-by-dhcp.cox.net>
References: <20050503195601.GA4165@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 23:28:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT4v7-0004BE-1z
	for gcvg-git@gmane.org; Tue, 03 May 2005 23:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVECVd1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 17:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVECVd0
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 17:33:26 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:24240 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261790AbVECVdY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 17:33:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050503213324.HBFB1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 3 May 2005 17:33:24 -0400
To: Alex Riesen <fork0@users.sourceforge.net>
In-Reply-To: <20050503195601.GA4165@steel.home> (Alex Riesen's message of
 "Tue, 3 May 2005 21:56:01 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "AR" == Alex Riesen <fork0@users.sourceforge.net> writes:

AR> gcc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' -o git-diff-cache diff-cache.c libgit.a -lz -lssl
AR> diff-cache.c: In function `show_new_file':
AR> diff-cache.c:51: warning: `return' with a value, in function returning void

This one was fixed in the Linus tree long time ago.


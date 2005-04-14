From: Junio C Hamano <junkio@cox.net>
Subject: Re: teach ls-tree how to handle names with embedded LF
Date: Wed, 13 Apr 2005 17:15:58 -0700
Message-ID: <7v7jj6tdq9.fsf@assigned-by-dhcp.cox.net>
References: <7vd5sytf94.fsf@assigned-by-dhcp.cox.net>
	<20050413235018.GQ25711@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 02:17:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLs27-0004b5-VR
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 02:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVDNATQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Apr 2005 20:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVDNAQk
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Apr 2005 20:16:40 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:30174 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261236AbVDNAQB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2005 20:16:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050414001558.KLGU13819.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 13 Apr 2005 20:15:58 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050413235018.GQ25711@pasky.ji.cz> (Petr Baudis's message of
 "Thu, 14 Apr 2005 01:50:18 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> Actually, what about just making it consistent with diff-tree and making
PB> it always terminate the records with '\0'?

Sounds good to me.  I need '-z' for a script I am working on to
generate data for incremental updates of object database.


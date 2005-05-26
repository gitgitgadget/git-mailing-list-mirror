From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH Cogito] Fix cg-log -f behavior
Date: Thu, 26 May 2005 13:18:32 -0700
Message-ID: <7vk6llbv1j.fsf@assigned-by-dhcp.cox.net>
References: <1117137826.12036.57.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 22:19:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbOn2-0000hM-GO
	for gcvg-git@gmane.org; Thu, 26 May 2005 22:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbVEZUSn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 16:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVEZUSn
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 16:18:43 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:47604 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261616AbVEZUSh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 16:18:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050526201834.HXUF1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 26 May 2005 16:18:34 -0400
To: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1117137826.12036.57.camel@pegasus> (Marcel Holtmann's message
 of "Thu, 26 May 2005 22:03:46 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Doesn't that still break one-tree case (i.e. [ -z $tree2 ])?



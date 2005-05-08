From: Junio C Hamano <junkio@cox.net>
Subject: Re: Broken adding of cache entries
Date: Sun, 08 May 2005 15:22:09 -0700
Message-ID: <7v3bsx4aum.fsf@assigned-by-dhcp.cox.net>
References: <20050507001409.GP32629@pasky.ji.cz>
	<1115431767.32065.182.camel@localhost.localdomain>
	<20050507152849.GD9495@pasky.ji.cz>
	<7vhdhealjm.fsf@assigned-by-dhcp.cox.net>
	<20050507224116.GF9495@pasky.ji.cz>
	<7vll6q8s4o.fsf@assigned-by-dhcp.cox.net>
	<7vbr7m8p05.fsf@assigned-by-dhcp.cox.net>
	<7vll6q70mg.fsf@assigned-by-dhcp.cox.net>
	<20050508165915.GW9495@pasky.ji.cz>
	<7v3bsx5sxx.fsf@assigned-by-dhcp.cox.net>
	<20050508212202.GM9495@pasky.ji.cz>
	<7v7ji94b1d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 00:15:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUu3I-0003x6-VS
	for gcvg-git@gmane.org; Mon, 09 May 2005 00:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262992AbVEHWWO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 18:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262995AbVEHWWO
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 18:22:14 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:34232 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262992AbVEHWWL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2005 18:22:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050508222209.YTAQ550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 8 May 2005 18:22:09 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <7v7ji94b1d.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 08 May 2005 15:18:06 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:
>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:
PB> Still, I'd like to know why the checking in write-tree is necessary.

Ok, having thought about it a bit more, I think we can yank it
out.  I'd rather keep ourselves cautious, though; there may be
some other ways we haven't thought of to create such nonsense,
and it would not hurt to be cautious before writing a tree out.


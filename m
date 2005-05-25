From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb wishlist
Date: Wed, 25 May 2005 12:01:39 -0700
Message-ID: <7vu0krku3w.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org>
	<20050524184612.GA23637@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505241236020.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505241259250.2307@ppc970.osdl.org>
	<20050524202846.GC25606@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505241410380.2307@ppc970.osdl.org>
	<20050524213102.GB19180@vrfy.org>
	<7vu0ksoxg4.fsf@assigned-by-dhcp.cox.net>
	<20050525123544.GA1420@vrfy.org> <20050525125143.GB1481@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 21:08:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db1Cs-0000l2-6Z
	for gcvg-git@gmane.org; Wed, 25 May 2005 21:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbVEYTDo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 15:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbVEYTDO
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 15:03:14 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:18596 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S262383AbVEYTBl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2005 15:01:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050525190141.IXWX20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 25 May 2005 15:01:41 -0400
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050525125143.GB1481@vrfy.org> (Kay Sievers's message of
 "Wed, 25 May 2005 14:51:43 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Stupidly, I use "%d" without precision to output score, and
worse yet the score is not scaled (meaning it would change when
definition of MAX_SCORE changes, exposing internal scale that
rename/copy uses).

For the sake of parsability, I think I should make that number
always 3 digit and per-cent; so 86% hit would be "C086" and the
bogus R10000 you pointed out would become "R100".



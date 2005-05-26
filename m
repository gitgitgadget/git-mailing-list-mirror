From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] ls-tree matching a prefix
Date: Wed, 25 May 2005 21:44:31 -0700
Message-ID: <7vsm0aeguo.fsf@assigned-by-dhcp.cox.net>
References: <20050526034756.GA1488@port.evillabs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 06:43:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbACj-0000Y5-Er
	for gcvg-git@gmane.org; Thu, 26 May 2005 06:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVEZEog (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 00:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVEZEog
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 00:44:36 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:9947 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261201AbVEZEod (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 00:44:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050526044431.BHKI12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 26 May 2005 00:44:31 -0400
To: Jason McMullan <jason.mcmullan@timesys.com>
In-Reply-To: <20050526034756.GA1488@port.evillabs.net> (Jason McMullan's
 message of "Wed, 25 May 2005 23:47:56 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JM" == Jason McMullan <jason.mcmullan@timesys.com> writes:

JM> For this purpose, I've enhanced git-ls-tree to allow the
JM> specification of an optional 'match path' that restricts
JM> that output of git-ls-tree to just the path requested.

JM> If the patch has a '/' in it, it implies -r.

I'd rather see the behaviour match existing commands with path
restriction, like diff-tree, diff-cache, and diff-files.  That
is, to take a list of paths and limit your output to those that
match one of them.  I do not think this enhancement would
negatively affect your stated use of getting one entry with the
exact match.


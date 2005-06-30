From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/1] Add a topological sort procedure to commit.c
Date: Thu, 30 Jun 2005 00:13:38 -0700
Message-ID: <7vwtoc48rh.fsf@assigned-by-dhcp.cox.net>
References: <20050630055821.1329.qmail@blackcubes.dyndns.org>
	<7v1x6k5oau.fsf@assigned-by-dhcp.cox.net>
	<2cfc403205063000009d149f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 09:07:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dnt8L-0004H3-ME
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 09:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbVF3HOJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 03:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262885AbVF3HOJ
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 03:14:09 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:19924 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262884AbVF3HOF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 03:14:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050630071339.HXFD22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 30 Jun 2005 03:13:39 -0400
To: jon@blackcubes.dyndns.org
In-Reply-To: <2cfc403205063000009d149f5@mail.gmail.com> (Jon Seymour's message of "Thu, 30 Jun 2005 17:00:40 +1000")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JS" == Jon Seymour <jon.seymour@gmail.com> writes:

>> By the way, you seem to be using "git format-patch".  Do you
>> want to help me pushing it upstream ;-)?

JS> Yep, but can you fix the PATCH 1/1 thing first :-)

Fix how?  Only special case 1/1?

That is easy to do, so I would do it, but on the other hand I
always end up editing the line anyway (my [PATCH 2/3] is often
originally [PATCH 4/7] because I have more than one series since
forked from upstream, and I would need to move it to Subject:
line), so it would not help very much, at least in my case.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Really *do* nothing in while loop
Date: Sun, 08 May 2005 14:08:58 -0700
Message-ID: <7vy8ap4e8l.fsf@assigned-by-dhcp.cox.net>
References: <20050508093440.GA9873@cip.informatik.uni-erlangen.de>
	<427DE086.40307@tls.msk.ru> <1115551204.3085.0.camel@kryten>
	<12e801c553c1$c454ea20$1225a8c0@kittycat>
	<427DFAB8.5050000@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jdow <jdow@earthlink.net>,
	James Purser <purserj@ksit.dynalias.com>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	LKML <linux-kernel@vger.kernel.org>, GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 23:02:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUsui-0005e4-AA
	for gcvg-git@gmane.org; Sun, 08 May 2005 23:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262967AbVEHVJG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 17:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbVEHVJG
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 17:09:06 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:20909 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262934AbVEHVJB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2005 17:09:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050508210900.HWQT1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 8 May 2005 17:09:00 -0400
To: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <427DFAB8.5050000@tls.msk.ru> (Michael Tokarev's message of
 "Sun, 08 May 2005 15:40:40 +0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "MT" == Michael Tokarev <mjt@tls.msk.ru> writes:

MT> As I already said, deflate() in this case does only ONE iteration.
MT> stream.avail_in is NOT changed in the loop (except of the deflate()
MT> itself, where it will be set to 0 - provided out buffer have enouth
MT> room)....

Just a stupid question, but what happens when we do not have
enough room in the buffer?


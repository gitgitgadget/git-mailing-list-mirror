From: Junio C Hamano <junkio@cox.net>
Subject: Re: git clone rsync:... ?
Date: Mon, 11 Jul 2005 15:36:53 -0700
Message-ID: <7vwtnxnf5m.fsf@assigned-by-dhcp.cox.net>
References: <20050711213050.GA18693@buici.com>
	<7v4qb1ouwk.fsf@assigned-by-dhcp.cox.net>
	<20050711222112.GA21248@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 00:41:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds6xB-0008Jh-La
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 00:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbVGKWkA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 18:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbVGKWh1
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 18:37:27 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:29359 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262976AbVGKWhH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 18:37:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050711223654.PRBL1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 11 Jul 2005 18:36:54 -0400
To: Marc Singer <elf@buici.com>
In-Reply-To: <20050711222112.GA21248@buici.com> (Marc Singer's message of "Mon, 11 Jul 2005 15:21:12 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Marc Singer <elf@buici.com> writes:

> Looks like something's borked.

Cogito I slurped about half hour ago has a quite different
git-clone-script from your 4-line version.  It is not surprising
"git clone -l" would not work with it ;-).

I just checked.  Are you using Cogito 0.12 by any chance?

Unfortunately it is ancient in this area.  Selected diffstat
between 0.12 and Pasky head I think relevant is this:

 git-clone-script                       |   97 ++++

From: Junio C Hamano <junkio@cox.net>
Subject: Re: git fsck messages - what to do about it?
Date: Sun, 18 Sep 2005 15:13:41 -0700
Message-ID: <7vfys210tm.fsf@assigned-by-dhcp.cox.net>
References: <20050916101138.99906352682@atlas.denx.de>
	<Pine.LNX.4.58.0509161114540.26803@g5.osdl.org>
	<Pine.LNX.4.58.0509181435190.9106@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 00:14:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH7Pu-0006IL-K0
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 00:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbVIRWNo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 18:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbVIRWNo
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 18:13:44 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:58876 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932229AbVIRWNn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2005 18:13:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050918221343.EUI29184.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 18 Sep 2005 18:13:43 -0400
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <Pine.LNX.4.58.0509181435190.9106@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 18 Sep 2005 14:43:33 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8816>

Linus Torvalds <torvalds@osdl.org> writes:

> So using "--unreachable" gives much more raw data, but it usually tends to
> hide the real _information_, and the end result is thus much harder to
> understand.

Yup.  That's exactly why the 'git-lost-found' sample script
given in <7vll1xndxi.fsf@assigned-by-dhcp.cox.net> runs
git-fsck-objects output without --unreachable.

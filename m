From: Junio C Hamano <junkio@cox.net>
Subject: Re: Make time-based commit filtering work with topological ordering
Date: Tue, 20 Sep 2005 15:28:32 -0700
Message-ID: <7vpsr31ii7.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0509201358200.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 21 00:30:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHqbN-0001SG-GL
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 00:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbVITW2f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 18:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965174AbVITW2f
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 18:28:35 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:1496 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S965171AbVITW2e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2005 18:28:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050920222832.KDPE26890.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 20 Sep 2005 18:28:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9024>

This seems to break t6001 merge-order with max-age test.

* FAIL 23: --max-age=c3, --merge-order

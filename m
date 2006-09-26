From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: "raw" links to blobs at HEAD
Date: Mon, 25 Sep 2006 23:46:48 -0700
Message-ID: <7v8xk7rup3.fsf@assigned-by-dhcp.cox.net>
References: <20060926053920.47709.qmail@web31802.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 26 08:47:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS6iW-0006ir-Pe
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 08:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWIZGqu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 02:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWIZGqu
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 02:46:50 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:7623 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750885AbWIZGqt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 02:46:49 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060926064649.LZFZ16798.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Tue, 26 Sep 2006 02:46:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Summ1V00G1kojtg0000000
	Tue, 26 Sep 2006 02:46:46 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20060926053920.47709.qmail@web31802.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Mon, 25 Sep 2006 22:39:20 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27780>

This does not feel right.  Go to summary view, pick the tree
link of a non-head commit from the shortlog list, and the raw
links on the resulting page all say hb=HEAD.

Doesn't this make clicking the entry itself (blob view) and
clicking on the raw link (blob-plain view) inconsistent?  The
former goes to the blob from that revision while the latter
always goes to the HEAD.

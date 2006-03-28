From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add ALL_LDFLAGS to the git target.
Date: Mon, 27 Mar 2006 17:25:58 -0800
Message-ID: <7v1wwnnyvt.fsf@assigned-by-dhcp.cox.net>
References: <7v64lzo1j7.fsf@assigned-by-dhcp.cox.net>
	<13226.1143508524@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 28 03:26:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FO2yD-0002qr-B7
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 03:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWC1B0B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 20:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWC1B0A
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 20:26:00 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:20934 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751187AbWC1B0A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Mar 2006 20:26:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060328012559.PLLI17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 27 Mar 2006 20:25:59 -0500
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <13226.1143508524@lotus.CS.Berkeley.EDU> (Jason Riedy's message
	of "Mon, 27 Mar 2006 17:15:24 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18099>

Jason Riedy <ejr@EECS.Berkeley.EDU> writes:

> For some reason, I need ALL_LDFLAGS in the git target only on
> AIX.

I wonder what the dependency is, since ALL_LDFLAGS is not
modified on AIX, but you are right.  That is the only binary
that does not link with ALL_LDFLAGS which can include whatever
user passes via LDFLAGS.

> Once it builds, only one test "fails" on AIX 5.1 with 
> 1.3.0.rc1, t5500-fetch-pack.sh, but it looks like it's some
> odd tool problem in the tester + my setup and not a real bug.

Curious and would appreciate more details.

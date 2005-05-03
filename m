From: Junio C Hamano <junkio@cox.net>
Subject: Re: More problems...
Date: Tue, 03 May 2005 12:18:03 -0700
Message-ID: <7v7jigw238.fsf@assigned-by-dhcp.cox.net>
References: <20050429170127.A30010@flint.arm.linux.org.uk>
	<20050429182708.GB14202@pasky.ji.cz>
	<20050429195055.GE1233@mythryan2.michonline.com>
	<Pine.LNX.4.58.0504291311320.18901@ppc970.osdl.org>
	<7vhdhp47hq.fsf@assigned-by-dhcp.cox.net>
	<20050429221903.F30010@flint.arm.linux.org.uk>
	<Pine.LNX.4.60.0504292254430.25700@hermes-1.csi.cam.ac.uk>
	<20050502193327.GB20818@pasky.ji.cz>
	<Pine.LNX.4.60.0505022258150.27741@hermes-1.csi.cam.ac.uk>
	<Pine.LNX.4.58.0505021509530.3594@ppc970.osdl.org>
	<20050503014816.GQ20818@pasky.ji.cz>
	<Pine.LNX.4.58.0505030757440.29716@sam.ics.uci.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Linus Torvalds <torvalds@osdl.org>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	Russell King <rmk@arm.linux.org.uk>,
	Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 21:12:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT2oB-0007FH-8V
	for gcvg-git@gmane.org; Tue, 03 May 2005 21:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVECTSH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 15:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVECTSH
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 15:18:07 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:35474 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261623AbVECTSF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 15:18:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050503191805.OILK16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 3 May 2005 15:18:05 -0400
To: Andreas Gal <gal@uci.edu>
In-Reply-To: <Pine.LNX.4.58.0505030757440.29716@sam.ics.uci.edu> (Andreas
 Gal's message of "Tue, 3 May 2005 08:00:42 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "AG" == Andreas Gal <gal@uci.edu> writes:

AG> I am just soft-linking objects/ in the branched tree. I can live with 
AG> dangling objects, branching is extremly fast, and diskspace is cheap 
AG> anyway. The only downside is that it doesn't work too well with rsync as 
AG> network protocol,...

I usually do not symlinks myself, but doesn't "rsync -L" work
for you?


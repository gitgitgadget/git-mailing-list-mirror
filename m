From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] "sleep 1" sleeps too little on cygwin
Date: Thu, 19 Jan 2006 17:13:28 -0800
Message-ID: <7v64of8zwn.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0601170325y60094b4w693ac37490c67410@mail.gmail.com>
	<7vmzhtzzlf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0601181233460.8678@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v4q41zd1t.fsf@assigned-by-dhcp.cox.net>
	<20060118185229.GA3001@steel.home>
	<7vmzhtqakl.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0601190701g2696b1a9l14f3d288875e11ab@mail.gmail.com>
	<7vr774dqjo.fsf@assigned-by-dhcp.cox.net>
	<20060119221346.GC3601@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 20 02:13:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzkqS-0001R3-C0
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 02:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422712AbWATBNc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 20:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422711AbWATBNc
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 20:13:32 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:16362 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030438AbWATBNb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 20:13:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060120011335.TEX25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 Jan 2006 20:13:35 -0500
To: Alex Riesen <raa.lkml@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14945>

Alex Riesen <raa.lkml@gmail.com> writes:

> Maybe just wait for 3 (three) seconds? It should guarantee the change
> in mtime.

That is certainly an easy way out.  Unless somebody comes up
with more simple and elegant solution I'd opt for this.

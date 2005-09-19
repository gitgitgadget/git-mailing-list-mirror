From: Junio C Hamano <junkio@cox.net>
Subject: Re: Why does git-core 0.99.7 require python 2.4?
Date: Mon, 19 Sep 2005 13:55:18 -0700
Message-ID: <7vslw0lqvd.fsf@assigned-by-dhcp.cox.net>
References: <432F0C66.7060402@zytor.com>
	<20050919200222.GA11322@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 19 22:57:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHSfe-000148-LI
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 22:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbVISUzV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 16:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbVISUzV
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 16:55:21 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:10150 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932426AbVISUzU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 16:55:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050919205520.OOOX28889.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Sep 2005 16:55:20 -0400
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20050919200222.GA11322@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Mon, 19 Sep 2005 22:02:23 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8906>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> Not supporting one of the major Linux distributions isn't ideal
> though, so maybe we should do something about this. I will have a look
> at rewriting the code to not use subprocess.

Thanks -- I personally feel that it would be best to just let FC
catch up, solving this problem for us, while you spend your time
on other things first.

Peter, if you feel strongly about it I'd do 0.99.7.1 removing
the 'requires python >=2.4', but as Fredrik says the only thing
that uses Python 2.4 is his recursive merge, and it is not
something we use without the user explicitly asking for it.  We
can consider it as the same status as send-email or archimport
which cannot work without Perl modules necessary for their
operation, so if you can install bypassing requires- check that
would work equally well.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-daemon --inetd
Date: Thu, 15 Sep 2005 23:23:55 -0700
Message-ID: <7vbr2tsf7o.fsf@assigned-by-dhcp.cox.net>
References: <43290EFF.3070604@zytor.com>
	<Pine.LNX.4.58.0509150829090.26803@g5.osdl.org>
	<4329BDD9.4010507@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 16 08:24:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EG9dg-0002zx-MM
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 08:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161053AbVIPGX6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 02:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161054AbVIPGX6
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 02:23:58 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:16305 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1161053AbVIPGX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 02:23:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050916062357.VOHC3588.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Sep 2005 02:23:57 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4329BDD9.4010507@zytor.com> (H. Peter Anvin's message of "Thu,
	15 Sep 2005 11:30:49 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8665>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Wrapping it in chroot() would mean having enough things in the chroot 
> environment to support starting up programs, which is ugly.  I'll test 
> the patch when I get a chance.

I'd appreciate a forward of the patch with your acked by if you
find it acceptable for kernel.org use.

I'd apply Linus' patch myself and push it out in the proposed
updates branch, if you prefer.

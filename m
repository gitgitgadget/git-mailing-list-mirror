From: Junio C Hamano <junkio@cox.net>
Subject: Re: Producing tar file with 666/777 permissions
Date: Fri, 03 Mar 2006 21:03:57 -0800
Message-ID: <7v7j7ax0le.fsf@assigned-by-dhcp.cox.net>
References: <1141446331.3171.4.camel@mattlaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 04 06:04:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFOvz-0007Br-Ul
	for gcvg-git@gmane.org; Sat, 04 Mar 2006 06:04:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbWCDFEA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Mar 2006 00:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWCDFEA
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Mar 2006 00:04:00 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:38093 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751061AbWCDFD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Mar 2006 00:03:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060304050110.GMUV17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Mar 2006 00:01:10 -0500
To: Matt McCutchen <hashproduct@verizon.net>
In-Reply-To: <1141446331.3171.4.camel@mattlaptop> (Matt McCutchen's message of
	"Fri, 03 Mar 2006 23:25:31 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17172>

Matt McCutchen <hashproduct@verizon.net> writes:

> Dear GIT people,
>
> How do I package a git repository in a tar file with 666 and 777
> embedded permissions?  There's evidently some way to do it because the
> Linux kernel source packages have 666 and 777 embedded permissions, but
> git-tar-tree gives me a tar file with 644 and 755 permissions and
> there's no obvious way to tell it to do otherwise.

Ouch, thanks for reporting this.  You have spotted a recent
regression.

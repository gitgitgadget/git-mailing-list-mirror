From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] delta micro optimization
Date: Fri, 10 Feb 2006 12:00:51 -0800
Message-ID: <7vhd77vv9o.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602101335160.5397@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 11 00:32:59 2006
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1F7eRt-0005Yv-00
	for <gcvg-git@gmane.org>; Fri, 10 Feb 2006 21:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWBJUAy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 15:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWBJUAy
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 15:00:54 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:48813 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751047AbWBJUAx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 15:00:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060210195948.DVZW3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 10 Feb 2006 14:59:48 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0602101335160.5397@localhost.localdomain> (Nicolas
	Pitre's message of "Fri, 10 Feb 2006 13:42:05 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15902>

That looks obviously correct but it really is micro.  Have you
benched it?  On which architectures?  Does it help everywhere or
register starved ones benefit more than others?

From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cygwin test failure in t6021-merge-criss-cross.sh
Date: Tue, 06 Dec 2005 08:51:36 -0800
Message-ID: <7v1x0q419j.fsf@assigned-by-dhcp.cox.net>
References: <20051206124032.GC2364@ELSAMSW37164>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 17:56:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ejg2X-00084u-ID
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 17:51:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbVLFQvi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 11:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbVLFQvi
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 11:51:38 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:47825 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932323AbVLFQvi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 11:51:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051206165024.IDER17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Dec 2005 11:50:24 -0500
To: Tim O'Callaghan <timo@dspsrv.com>
In-Reply-To: <20051206124032.GC2364@ELSAMSW37164> (Tim O'Callaghan's message
	of "Tue, 6 Dec 2005 13:40:32 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13279>

I have this strange feeling that you do not have "merge"
installed on your cygwin box.  It is part of "rcs".

When you see a test failure, it sometimes useful to try running:

    $ cd t
    $ sh ./t6021-*.sh -i -v

manually.

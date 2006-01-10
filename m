From: Junio C Hamano <junkio@cox.net>
Subject: Re: undoing changes with git-checkout -f
Date: Mon, 09 Jan 2006 23:42:24 -0800
Message-ID: <7vy81o8r6n.fsf@assigned-by-dhcp.cox.net>
References: <43C2D2C4.2010904@cc.jyu.fi>
	<7vmzi5hy69.fsf@assigned-by-dhcp.cox.net>
	<20060110045533.GO18439@ca-server1.us.oracle.com>
	<7vk6d8aaln.fsf@assigned-by-dhcp.cox.net>
	<20060110063247.GP18439@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 08:42:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwE9G-0003Nh-Nf
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 08:42:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWAJHm1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 02:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWAJHm0
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 02:42:26 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:28633 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750990AbWAJHm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 02:42:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060110074125.YQNF20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 10 Jan 2006 02:41:25 -0500
To: Joel Becker <Joel.Becker@oracle.com>
In-Reply-To: <20060110063247.GP18439@ca-server1.us.oracle.com> (Joel Becker's
	message of "Mon, 9 Jan 2006 22:32:47 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14412>

Joel Becker <Joel.Becker@oracle.com> writes:

> ...  I'd really rather have the tunneling
> code be part of connect.c,...

For the record, I was pushing for that, but that approach was
interrupted primarily by what this message implies:

    http://article.gmane.org/gmane.comp.version-control.git/10985

The thread that originally introduced the current proxy is here:

    http://thread.gmane.org/gmane.comp.version-control.git/11074

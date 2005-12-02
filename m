From: Junio C Hamano <junkio@cox.net>
Subject: Re: resolve (merge) problems
Date: Thu, 01 Dec 2005 21:09:43 -0800
Message-ID: <7vk6eo9jag.fsf@assigned-by-dhcp.cox.net>
References: <20051202020512.99856.qmail@web31811.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 06:33:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ei3Wq-0001sM-FE
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 06:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbVLBFcN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 00:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbVLBFcN
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 00:32:13 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:26108 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750845AbVLBFcM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2005 00:32:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051202050822.QSDN17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 2 Dec 2005 00:08:22 -0500
To: ltuikov@yahoo.com
In-Reply-To: <20051202020512.99856.qmail@web31811.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Thu, 1 Dec 2005 18:05:12 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13100>

Luben Tuikov <ltuikov@yahoo.com> writes:

> $python -V
> Python 2.4.2
> $which python
> /usr/local/bin/python

Since you do not want to use /usr/bin/python but from your own
location /usr/local/bin/python, I presume you built git with

	$ make PYTHON_PATH=/usr/local/bin/python

among other installation specific override needed on your
machine?

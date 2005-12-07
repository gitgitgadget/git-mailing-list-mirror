From: Junio C Hamano <junkio@cox.net>
Subject: Re: Failure in t6021 on Red Hat Enterprise Linux 4
Date: Wed, 07 Dec 2005 10:54:24 -0800
Message-ID: <7vslt4rb4v.fsf@assigned-by-dhcp.cox.net>
References: <20051207181225.67737.qmail@web34304.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 19:55:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ek4R3-0002XN-2a
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 19:54:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbVLGSyc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 13:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751752AbVLGSyc
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 13:54:32 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:36525 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751750AbVLGSyc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2005 13:54:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051207185302.GJC26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 7 Dec 2005 13:53:02 -0500
To: Mark Allen <mrallen1@yahoo.com>
In-Reply-To: <20051207181225.67737.qmail@web34304.mail.mud.yahoo.com> (Mark
	Allen's message of "Wed, 7 Dec 2005 10:12:24 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13337>


Mark Allen <mrallen1@yahoo.com> writes:

> So, basically the problem is that the subprocess.py module is
> in the compat directory, and by default (I think)..

Ah, you are right.

Just like we fix PATH and GIT_EXEC_PATH during the test
execution, we need to do something with PYTHONPATH environment
variable (this one is _without_ underscore), I think.

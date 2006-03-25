From: Eric Wong <normalperson@yhbt.net>
Subject: send-email: dependency removal, cleanup, + small feature
Date: Sat, 25 Mar 2006 02:43:30 -0800
Message-ID: <11432834101430-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: git <git@vger.kernel.org>, Ryan Anderson <ryan@michonline.com>,
	Greg KH <greg@kroah.com>
X-From: git-owner@vger.kernel.org Sat Mar 25 11:44:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FN6Fv-00016M-01
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 11:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWCYKn6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 05:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWCYKn6
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 05:43:58 -0500
Received: from hand.yhbt.net ([66.150.188.102]:19080 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751160AbWCYKn6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 05:43:58 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 7494C7DC005;
	Sat, 25 Mar 2006 02:43:57 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17973>


1 - Change from Mail::Sendmail to Net::SMTP
2 - use built-in time() instead of /bin/date '+%s'
3 - lazy-load Email::Valid and make it optional
4 - add support for mutt aliases files

Patches 1 and 3 make git-send-email easily runnable with any
reasonable Perl installation.  2 is just a good idea.  4 makes
my life a lot easier.

-- 
Eric Wong

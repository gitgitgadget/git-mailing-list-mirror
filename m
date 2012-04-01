From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: gitk: Failure of new tabbed preferences dialog
Date: Sun,  1 Apr 2012 23:00:50 +0100
Message-ID: <1333317652-1464-1-git-send-email-patthoyts@users.sourceforge.net>
References: <4F749C71.7050201@ramsay1.demon.co.uk>
Cc: <git@vger.kernel.org>, Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Apr 02 01:04:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SETp9-0000Es-Cc
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 01:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692Ab2DAXD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Apr 2012 19:03:59 -0400
Received: from queueout04-winn.ispmail.ntl.com ([81.103.221.58]:28644 "EHLO
	queueout04-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752753Ab2DAXD6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Apr 2012 19:03:58 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.1])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120401220313.VVKZ18388.mtaout03-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Sun, 1 Apr 2012 23:03:13 +0100
Received: from [94.171.229.22] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1SESrh-0000vb-Tq; Sun, 01 Apr 2012 23:03:13 +0100
Received: from localhost.localdomain (frog.patthoyts.tk [192.168.0.25])
	by fox.patthoyts.tk (Postfix) with ESMTP id 29FE520054;
	Sun,  1 Apr 2012 23:03:13 +0100 (BST)
X-Mailer: git-send-email 1.7.9.msysgit.0
In-Reply-To: <4F749C71.7050201@ramsay1.demon.co.uk>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=5QlXIjQiwvYA:10 a=p6EI7cEqvC_8qBLjlDYA:9 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194491>


> I just tried the new gitk (master @fae9d76) and, since I don't have
> themed widgets, the preferences menu item uses the emulated tabbed
> dialog code, which fails like so:
>
>     can't read "col": no such variable
>

The issue here is that the incr command has changed between tcl 8.4
and 8.5 and in more recent versions automatically creates the named
variable if it did not exist. The fix you suggest is correct. I've
also included another that I realised had been applied to msysGit and
was not posted upstream.

Pat Thoyts.

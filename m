From: Mark Jason Dominus <mjd@plover.com>
Subject: Re: git-push sent too many objects
Date: Thu, 26 Apr 2012 20:41:53 -0400
Organization: P.D.Q. Bernoulli Institute of Lower Mathematics
Message-ID: <5097.1335487313@plover.com>
References: <20120426130717.GB27785@sigill.intra.peff.net>
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 03:42:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNaCE-0002rv-Vv
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 03:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757758Ab2D0BmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 21:42:00 -0400
Received: from vms173007pub.verizon.net ([206.46.173.7]:43814 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754243Ab2D0Bl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 21:41:59 -0400
X-Greylist: delayed 3604 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Apr 2012 21:41:59 EDT
Received: from plover.com ([unknown] [72.92.15.69]) by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M34006UQ4LUVZ30@vms173007.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 26 Apr 2012 19:41:54 -0500 (CDT)
Received: (qmail 5099 invoked by uid 1000); Fri, 27 Apr 2012 00:41:53 +0000
Received: from localhost (HELO plover.com) (sendmail-bs@127.0.0.1)
 by localhost with SMTP; Fri, 27 Apr 2012 00:41:53 +0000
In-reply-to: Your message of "Thu, 26 Apr 2012 09:07:17 EDT."
 <20120426130717.GB27785@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196448>

Jeff King:
> Is the repository public? I can't reproduce the issue on a trivial test
> case, but it might be possible to create the original state of the
> client and server repos with judicious use of "reset" and "prune".

The repository has been heavily used since I made the report. If I
notice the same behavior againb, I will try to capture the repo state
for investigation.

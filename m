From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH 0/3] git-daemon hacking
Date: Fri, 03 Feb 2006 20:23:30 +0000
Message-ID: <20060203202330.1895.60474.stgit@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Fri Feb 03 21:27:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F57WU-0005RV-Eh
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 21:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWBCU1F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 15:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWBCU1E
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 15:27:04 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:8244 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1751397AbWBCU1B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2006 15:27:01 -0500
Received: (qmail 2083 invoked from network); 3 Feb 2006 20:27:00 -0000
Received: from localhost (HELO metalzone.distorted.org.uk) (?/EO+6sxEOaHffg2i69cLw82kDxyOsRZs?@127.0.0.1)
  by localhost with SMTP; 3 Feb 2006 20:27:00 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15548>

I've just been playing around a bit with the git-daemon.  My main
objective was to implement the feature in the third patch, namely to
allow users to publish their own repositories even though the daemon was
mainly locked down to serving from a particular central tree.  This is
the same idea as allowing a web server to serve files in a user's
~/public_html directory.

But I also fixed a couple of bugs I found on the way.

-- [mdw]

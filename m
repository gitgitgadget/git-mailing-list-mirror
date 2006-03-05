From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH 0/3] Build fixes for v1.2.4-gc9e9f1a
Date: Sun, 05 Mar 2006 09:33:51 +0000
Message-ID: <20060305093351.26650.84677.stgit@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Sun Mar 05 10:36:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFpfI-0001zP-TR
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 10:36:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbWCEJga (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 04:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752151AbWCEJga
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 04:36:30 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:62618 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1752008AbWCEJga (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 04:36:30 -0500
Received: (qmail 26921 invoked from network); 5 Mar 2006 09:36:28 -0000
Received: from localhost (HELO metalzone.distorted.org.uk) (127.0.0.1)
  by localhost with SMTP; 5 Mar 2006 09:36:28 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17212>

The master branch, as of c9e9f1ad8aae4bd49791d53cc0cd501120884850,
doesn't build cleanly for me.  There's a warning about git.c, warnings
about Documentation/git-cvsserver.txt, and an abject failure to process
Documentation/git-tools.txt.

The following patches fix these problems, at least for me.

For reference, I'm running

  * gcc (GCC) 4.0.3 20060212 (prerelease) (Debian 4.0.2-9)
  * asciidoc 7.0.2

-- [mdw]

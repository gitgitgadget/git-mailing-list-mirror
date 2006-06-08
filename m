From: Jon Loeliger <jdl@jdl.com>
Subject: git-cvsservr questions
Date: Wed, 07 Jun 2006 23:33:06 -0500
Message-ID: <E1FoCCg-0002vH-FX@jdl.com>
X-From: git-owner@vger.kernel.org Thu Jun 08 06:33:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoCCm-0007bn-T9
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 06:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbWFHEdJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 00:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWFHEdJ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 00:33:09 -0400
Received: from colo.jdl.com ([66.118.10.122]:61332 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S932502AbWFHEdI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jun 2006 00:33:08 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1FoCCg-0002vH-FX
	for git@vger.kernel.org; Wed, 07 Jun 2006 23:33:07 -0500
To: git@vger.kernel.org
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21470>

Mart{i,y}n et al,

I'm having a bit of a problem setting up my git-cvsserver.
I think I have followed the man page, but this is the
only real response I get:

    $ setenv CVSROOT :pserver:anonymous@jdl.com:/pub/..../foo.git
    $ cvs co master cvs [checkout aborted]: unrecognized auth response
      from jdl.com: Unknown command BEGIN AUTH REQUEST at
      /usr/bin/git-cvsserver line 132, <STDIN> line 1.

I've installed DBD:SQLite, but I don't know if it is working
or not.  Not sure what file it would create in my repo if it
was working properly.  I've made the bare repo directory be
mode 777 just to be sure it is writable by "nobody."

My client is 1.12.9.

I have enabled it the config file, and set a log file, but
I get no output.  Do I need to enable the output somehow?
Other debug enabling bits to turn on for more help here?

Have I missed some obvious step?  You know, intuit my problem
from my sparse description! :-)  Well, or tell me what else
you need to know...

Thanks,
jdl

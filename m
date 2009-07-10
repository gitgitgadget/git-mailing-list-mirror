From: layer <layer@known.net>
Subject: How can I tell if a tag has been pushed, or not?
Date: Fri, 10 Jul 2009 10:43:27 -0700
Message-ID: <14563.1247247807@relay.known.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 10 19:49:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPKE8-0003Oq-BF
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 19:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337AbZGJRtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 13:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbZGJRtc
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 13:49:32 -0400
Received: from relay.known.net ([67.121.255.169]:52918 "EHLO relay.known.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751458AbZGJRtc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 13:49:32 -0400
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Jul 2009 13:49:31 EDT
Received: from localhost (127.0.0.1) by relay.known.net
    (Allegro Maild v1.2.19) id 000000046934; Fri, 10 Jul 2009 10:43:27 -0700
X-Mailer: MH-E 8.1; nmh 1.3; GNU Emacs 22.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123074>

Here's the problem:

I expect that users, in their own private repos, will from time to
time create tags that should not be pushed.  Sometimes, tags that
should be pushed will be created.

I could require that the "public" tags follow a specific convention
(start with "release", or something).  Then, the scripts all my
developers use could use that and push only certain tags.  However,
over time there could be a large number of them.  It seems undesirable
to push each tag each time a push is done.  So, how can I tell if a
tag has already been pushed?  Is there a way?

Thanks.

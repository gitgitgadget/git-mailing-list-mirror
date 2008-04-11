From: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
Subject: how to use two bare repositories?
Date: Fri, 11 Apr 2008 23:22:05 +0100
Message-ID: <20080411222205.GN29940@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 00:55:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkS9i-0002n5-39
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 00:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759086AbYDKWyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 18:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759067AbYDKWyb
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 18:54:31 -0400
Received: from mhs.swan.ac.uk ([137.44.1.33]:44952 "EHLO mhs.swan.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757139AbYDKWyH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 18:54:07 -0400
X-Greylist: delayed 1921 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Apr 2008 18:54:07 EDT
Received: from [137.44.2.59] (helo=cs-svr1.swan.ac.uk)
	by mhs.swan.ac.uk with esmtp (Exim 4.69)
	(envelope-from <O.Kullmann@swansea.ac.uk>)
	id 1JkRdF-0003Zw-LT; Fri, 11 Apr 2008 23:22:05 +0100
Received: from cs-wsok.swansea.ac.uk (cs-wsok [137.44.2.227])
	by cs-svr1.swan.ac.uk (Postfix) with ESMTP id 59E76DAE20;
	Fri, 11 Apr 2008 23:22:05 +0100 (BST)
Received: by cs-wsok.swansea.ac.uk (Postfix, from userid 3579)
	id 49C24741BB; Fri, 11 Apr 2008 23:22:05 +0100 (BST)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79306>

Hi,

I have the following problem:

We use a public repository, a bare repository A,
used with push and pull via ssh.
A is only to be used by the core developer group.

Now I want to create another public repository B,
from which anonymous pull is possible via http.
So B should be another bare repository.

The problem is now that it seems not to be possible
to update B:

1. pulling from A is not possible since B is bare;
2. fetching from A seems to work, checking the content of
   B via gitk seems to indicate that B has been updated
 --- however pulling from B doesn't work: The newly
 fetched changes are not transported to a repository
 which pulls from B ???

Hope somebody can shed light on this behaviour.

Thanks!

Oliver

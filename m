From: Jean-Marie Gaillourdet <jmg@gaillourdet.net>
Subject: fatal: unable to run 'git-svn'
Date: Fri, 17 Apr 2009 08:08:16 +0000 (UTC)
Message-ID: <loom.20090417T075701-666@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 17 10:16:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LujFe-0002FM-3O
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 10:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685AbZDQIPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 04:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754066AbZDQIPK
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 04:15:10 -0400
Received: from main.gmane.org ([80.91.229.2]:49246 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753831AbZDQIPI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 04:15:08 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LujDy-0007Uj-Rc
	for git@vger.kernel.org; Fri, 17 Apr 2009 08:15:02 +0000
Received: from goedel.informatik.uni-kl.de ([131.246.92.38])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 08:15:02 +0000
Received: from jmg by goedel.informatik.uni-kl.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 08:15:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 131.246.92.38 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_6; en-us) AppleWebKit/528.16 (KHTML, like Gecko) Version/4.0 Safari/528.16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116727>

Hi,

I am not sure whether this is right place to post such question. 

I've been using git svn with different svn repositories for some time now. 
But I have one  repository with which a git svn clone always fails at the 
same revision. There  is no problem when using svn checkout on that 
repository. I do the following:

$ git svn clone https://....some_pivate_server:2443/svn/Foo/trunk/bar/

...
several hundered revisions are imported
...
r896 = 6a91d0d15864c174fe8d001e03c579d1968ab926 (git-svn)
	A	Uebungen/uebung08/README
r897 = c2d0e0f317b54575598c8d3067f26a558b202745 (git-svn)
fatal: unable to run 'git-svn'
$

This is on OX 10.5.6 with
$svn --version
svn, version 1.6.1 (r37116)
   compiled Apr 13 2009, 18:48:29

Copyright (C) 2000-2009 CollabNet.
Subversion is open source software, see http://subversion.tigris.org/
This product includes software developed by CollabNet (http://www.Collab.Net/).

The following repository access (RA) modules are available:

* ra_neon : Module for accessing a repository via WebDAV protocol using Neon.
  - handles 'http' scheme
  - handles 'https' scheme
* ra_svn : Module for accessing a repository using the svn network protocol.
  - with Cyrus SASL authentication
  - handles 'svn' scheme
* ra_local : Module for accessing a repository on local disk.
  - handles 'file' scheme
* ra_serf : Module for accessing a repository via WebDAV protocol using serf.
  - handles 'http' scheme
  - handles 'https' scheme

$git --version
git version 1.6.2.2

I tried raising limits for the number of open files and user processes. But 
that did not change anything, it still fails at the same revision. Any 
pointer where to search  for the reason would be great.

Please CC to me any answer since I am not registered with this mailinglist.

Best regards,

Jean

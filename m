From: Donald Brady <dbrady010@me.com>
Subject: git newbie - cloning / check out help
Date: Thu, 24 Jul 2008 21:24:34 +0000 (UTC)
Message-ID: <loom.20080724T211609-298@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 00:26:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM9GC-0007Q8-Vd
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 00:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbYGXWZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 18:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbYGXWZH
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 18:25:07 -0400
Received: from main.gmane.org ([80.91.229.2]:55666 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716AbYGXWZG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 18:25:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KM9F8-0008Q8-EU
	for git@vger.kernel.org; Thu, 24 Jul 2008 22:25:02 +0000
Received: from c-24-16-107-4.hsd1.ca.comcast.net ([24.16.107.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 22:25:02 +0000
Received: from dbrady010 by c-24-16-107-4.hsd1.ca.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 22:25:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.16.107.4 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_4; en-us) AppleWebKit/525.18 (KHTML, like Gecko) Version/3.1.2 Safari/525.20.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89966>

I am just ramping up on git and have the following scenario / issue:

  I have a git repository on server A.

  I clone it onto my machine B.

  In my local copy/repository on machine B I clone a repository on some 
third party server C.

  I commit my changes into B and push them to A.

  Now if I clone my repository from Server A onto my local machine
 in a different location I see all the source as normal but only the top
 level directory of C. Any source under that is not present. 

What is the magic git incantation to make sure that I check out 
not only the code from my repository but  any repositories that
are cloned into it (recursive clone?)

Thanks

Donald

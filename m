From: Yann Dirson <dirson@bertin.fr>
Subject: [DOCBUG] git subtree synopsis needs updating
Date: Fri, 19 Oct 2012 15:21:58 +0200
Organization: Bertin Technologies
Message-ID: <20121019152158.4297707b@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 15:22:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPCWf-0003Q6-M0
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 15:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757229Ab2JSNV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 09:21:58 -0400
Received: from cabourg.bertin.fr ([195.68.26.10]:35608 "EHLO cabourg.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751855Ab2JSNV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 09:21:57 -0400
Received: from cabourg.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 855DDA0FDB
	for <git@vger.kernel.org>; Fri, 19 Oct 2012 15:21:55 +0200 (CEST)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by cabourg.bertin.fr (Postfix) with ESMTP id 5E0A0A0FD8
	for <git@vger.kernel.org>; Fri, 19 Oct 2012 15:21:55 +0200 (CEST)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0MC500ERO6GJ2B70@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Fri, 19 Oct 2012 15:21:55 +0200 (CEST)
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8220-6.8.0.1017-19288.002
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208046>


As the examples in git-subtree.txt show, the synopsis in the same file should
surely get a patch along the lines of:

-'git subtree' add   -P <prefix> <commit>
+'git subtree' add   -P <prefix> <repository> <commit>

Failure to specify the repository (by just specifying a local commit) fails with
the cryptic:

 warning: read-tree: emptying the index with no arguments is deprecated; use --empty
 fatal: just how do you expect me to merge 0 trees?


Furthermore, the doc paragraph for add, aside from mentionning <repository>, also
mentions a <refspec> which the synopsis does not show either.


As a sidenote it someone wants to do some maintainance, using "." as repository when
the branch to subtree-add is already locally available does not work well either
(fails with "could not find ref myremote/myhead").

-- 
Yann Dirson - Bertin Technologies

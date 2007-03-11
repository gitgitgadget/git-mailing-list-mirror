From: Xavier Maillard <zedek@gnu.org>
Subject: Re: git merge and merge message
Date: Sun, 11 Mar 2007 19:15:17 +0100
Organization: GNU's Not UNIX!
Message-ID: <200703111815.l2BIFHbq010315@localhost.localdomain>
References: <200703111505.l2BF54Kq006625@localhost.localdomain> <20070311160424.GA629@fieldses.org>
Reply-To: Xavier Maillard <zedek@gnu.org>
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sun Mar 11 19:18:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQScT-00089A-3c
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 19:18:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933961AbXCKSSF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 14:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933965AbXCKSSF
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 14:18:05 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:59548 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933961AbXCKSSE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 14:18:04 -0400
Received: from zogzog.home (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp5-g19.free.fr (Postfix) with ESMTP id BCF137E08;
	Sun, 11 Mar 2007 19:18:01 +0100 (CET)
Received: from localhost.localdomain (IDENT:1001@localhost [127.0.0.1])
	by zogzog.home (8.13.8/8.13.8) with ESMTP id l2BIFIKe010318;
	Sun, 11 Mar 2007 19:15:18 +0100
Received: (from zedek@localhost)
	by localhost.localdomain (8.13.8/8.13.8/Submit) id l2BIFHbq010315;
	Sun, 11 Mar 2007 19:15:17 +0100
X-Authentication-Warning: localhost.localdomain: zedek set sender to zedek@gnu.org using -f
In-reply-to: <20070311160424.GA629@fieldses.org> (bfields@fieldses.org)
Jabber-ID: zedek@im.lolica.org
User-Agent: Rmail in GNU Emacs 23.0.51.1 on GNU/Linux
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41961>

   From: "J. Bruce Fields" <bfields@fieldses.org>

   On Sun, Mar 11, 2007 at 04:05:04PM +0100, Xavier Maillard wrote:

   > The merge is correct but there is not merge message when I do a
   > git log.

   Have you done any work on the master branch since you branched the topic
   branch off from it?  If not, the merge is just a "fast forward"--no
   merge commit is created, and instead the head of the master branch is
   just updated to point at the same commit as the head of the topic
   branch.

No I did not touch master before. It could explain that behaviour
then :)

I am still in my baby-learn phase but git really rocks (I am
still lost with branches and tags but I am trying hard to
understand.).

Thank you.
-- 
Xavier

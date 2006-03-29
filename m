From: Matt McCutchen <hashproduct@verizon.net>
Subject: How to switch kernel customizations from 2.6.15.6 to 2.6.16?
Date: Tue, 28 Mar 2006 20:43:42 -0500
Message-ID: <1143596622.2481.10.camel@mattlaptop.metaesthetics.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Mar 29 03:44:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOPj4-0001tf-Ui
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 03:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWC2Bnr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 20:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWC2Bnr
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 20:43:47 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:24990 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750766AbWC2Bnp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Mar 2006 20:43:45 -0500
Received: from [192.168.1.5] ([151.200.44.96])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-4.02 (built Sep
 9 2005)) with ESMTPA id <0IWV00DSD8SVD507@vms044.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 28 Mar 2006 19:43:44 -0600 (CST)
To: git@vger.kernel.org
X-Mailer: Evolution 2.6.0 (2.6.0-1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18153>

Dear git people,

I made a customized Linux kernel based on 2.6.15.6 by cloning the stable
2.6.15 kernel repository (which was then at version 2.6.15.6) and making
several commits.  Now I would like a Linux kernel based on 2.6.16 with
the same customizations.  This seems to be a very simple task, but I
have been trying various combinations of git commands for several days
and have not figured out how to do it.

I believe that means I should pull the 2.6.16 kernel into the "origin"
branch and then rebase the "master" branch, merging my customizations
with 2.6.16.  To this end, I switched my remote file to point to the
2.6.16 stable repository and tried to pull.  The result was not what I
wanted.  The situation is complicated by the fact that 2.6.15.6 is not
an ancestor of 2.6.16.  The warning in the man page about branches that
are modified nonlinearly seems to apply.

How do I make my customized 2.6.16 kernel?

-- 
Matt McCutchen
hashproduct@verizon.net
http://hashproduct.metaesthetics.net/

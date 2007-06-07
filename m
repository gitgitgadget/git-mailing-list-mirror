From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: git-svn removes merge
Date: Thu, 07 Jun 2007 19:08:16 +0200
Organization: Transmode AB
Message-ID: <1181236096.30670.66.camel@gentoo-jocke.transmode.se>
Reply-To: joakim.tjernlund@transmode.se
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 07 19:08:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwLTH-00026m-7h
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 19:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764515AbXFGRIV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 13:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933675AbXFGRIU
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 13:08:20 -0400
Received: from mail.transmode.se ([83.241.175.147]:43634 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1764486AbXFGRIT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 13:08:19 -0400
Received: mail.transmode.se 192.168.46.15 from 192.168.1.15 192.168.1.15 via HTTP with MS-WebStorage 6.0.6249
Received: from gentoo-jocke by mail.transmode.se; 07 Jun 2007 19:08:16 +0200
X-Mailer: Evolution 2.8.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49376>

If I do this:

git checkout --track -b svn remotes/trunk
git checkout -b merge
git-am ../mbox
git checkout svn
#edit Makefile and commit
git-svn dcommit #Note 1
git pull . merge
git-svn dcommit

then git-svn dcommit removes the merge beteen svn and merge.
git log svn..merge shows all the commits that git-am ../mbox added.

How do I avoid this?

 Jocke

Note 1:
  If I skip this step then the last git-svn dcommit fails, why is that?

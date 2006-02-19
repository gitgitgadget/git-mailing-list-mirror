From: Paul Mackerras <paulus@samba.org>
Subject: New shiny gitk
Date: Sun, 19 Feb 2006 22:50:34 +1100
Message-ID: <17400.23434.724188.649656@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Feb 19 12:51:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAn63-0001HJ-Ob
	for gcvg-git@gmane.org; Sun, 19 Feb 2006 12:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWBSLun (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Feb 2006 06:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWBSLun
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 06:50:43 -0500
Received: from ozlabs.org ([203.10.76.45]:16811 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932402AbWBSLum (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Feb 2006 06:50:42 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id E8196679F2; Sun, 19 Feb 2006 22:50:40 +1100 (EST)
To: git@vger.kernel.org
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16432>

I just created a branch called "new" in my gitk repository at

git://git.kernel.org/pub/scm/gitk/gitk.git

which has a new improved version of gitk which is much faster than the
old one and has a better graph layout algorithm.  I'd like people to
try it out and tell me how they like it and if I broke anything (I'm
pretty sure I broke the "Update" function, for instance).

If you use -d to get commits ordered by date, you will need the latest
version of git-rev-list, which has the --date-order option.

Paul.

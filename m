From: Stephen Bannasch <stephen.bannasch@deanbrook.org>
Subject: svn svn returning 'fatal: Not a valid object name' on sourceforge svn repo
Date: Thu, 3 Dec 2009 16:00:41 -0500
Message-ID: <p0624081ac73dd6a1aaff@[63.138.152.192]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 03 22:10:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGIw6-0008PF-Rv
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 22:10:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755087AbZLCVJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 16:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbZLCVJk
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 16:09:40 -0500
Received: from deanbrook.org ([72.52.70.192]:39728 "HELO deanbrook.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755087AbZLCVJj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 16:09:39 -0500
X-Greylist: delayed 541 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Dec 2009 16:09:39 EST
Received: from ::ffff:71.123.118.50 ([71.123.118.50]) by deanbrook.org for <git@vger.kernel.org>; Thu, 3 Dec 2009 13:00:44 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134478>

I use git svn often and normally it works fine.

I getting a fatal error trying to clone the asciimathm svn repo at sourceforge:

$ git svn clone --trunk=trunk --branches=branches http://asciimathml.svn.sourceforge.net/svnroot/asciimathml asciimathml-svn-git
fatal: Not a valid object name
ls-tree -z  ./: command returned error: 128

Anybody seen this kind of problem before.

A svn co works fine.

I'm using git version 1.6.5.1 on mac os 10.5.8.

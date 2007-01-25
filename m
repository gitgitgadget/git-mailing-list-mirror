From: Larry Streepy <larry@lightspeed.com>
Subject: Question about fsck-objects output
Date: Thu, 25 Jan 2007 12:22:45 -0600
Message-ID: <45B8F575.5050106@lightspeed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 25 20:23:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAABg-0008Qp-Ag
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 20:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030517AbXAYTXF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 14:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030518AbXAYTXF
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 14:23:05 -0500
Received: from mailhost.lightspeed.com ([12.44.179.187]:48221 "EHLO
	lightspeed.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030517AbXAYTXE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 14:23:04 -0500
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Jan 2007 14:23:04 EST
Received: from [192.168.10.13] (account larry [192.168.10.13] verified)
  by lightspeed.com (CommuniGate Pro SMTP 5.0.9)
  with ESMTPA id 3575794 for git@vger.kernel.org; Thu, 25 Jan 2007 10:21:39 -0800
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37752>

Sorry to ask such a basic question, but I can't quite decipher the output 
of fsck-objects.  When I run it, I get this:

  git fsck-objects
dangling commit 2213f6d4dd39ca8baebd0427723723e63208521b
dangling commit f0d4e00196bd5ee54463e9ea7a0f0e8303da767f
dangling blob 6a6d0b01b3e96d49a8f2c7addd4ef8c3bd1f5761


Even after a "repack -a -d" they still exist.  The man page has a short 
explanation, but, at least for me, it wasn't fully enlightening. :-)

The man page says that dangling commits could be "root" commits, but since 
my repo started as a clone of another repo, I don't see how I could have 
any root commits.  Also, the page doesn't really describe what a dangling 
blob is.

So, can someone explain what these artifacts are and if they are a problem 
that I should be worried about?

Thanks,
Larry.

From: Rich Pixley <rich.pixley@palm.com>
Subject: Newbie grief
Date: Mon, 30 Apr 2012 15:30:36 -0700
Message-ID: <4F9F128C.5020304@palm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 01 00:40:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOzGR-0008R1-JH
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 00:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756773Ab2D3WkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 18:40:09 -0400
Received: from smtp-relay2.palm.com ([64.28.152.243]:15034 "EHLO
	smtp-relay2.palm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756383Ab2D3WkI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 18:40:08 -0400
X-Greylist: delayed 570 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Apr 2012 18:40:08 EDT
X-IronPort-AV: E=Sophos;i="4.75,507,1330934400"; 
   d="scan'208";a="13227076"
Received: from unknown (HELO ushqusdns3.palm.com) ([148.92.223.90])
  by smtp-relay2.palm.com with ESMTP; 30 Apr 2012 15:30:37 -0700
Received: from fuji.noir.com ([10.100.2.13])
	by ushqusdns3.palm.com (8.14.4/8.14.4) with ESMTP id q3UMUaQS018093;
	Mon, 30 Apr 2012 15:30:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:12.0) Gecko/20120420 Thunderbird/12.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196622>

Hey.  I'm a newbie struggling to understand git.

I'm trying to do what seems like a simple thing in darcs, monotone, 
mecurial, gnu arch, etc, but seems nearly impossible in git.  There's a 
central repository, a long ways away on the other side of the internet.  
So I want a local repository cache.  I'm going to be working on a number 
of different features and different machines all simultaneously so I 
really don't want them all to be pulling from the central repository.

In other systems, this is a simple star network.  Clone a repository, 
use, push, pull, etc.  But with git, I can't push unless the cache 
repository is bare, but if the cache repository is bare, then a change 
to the central repository will cause the two to become wedged since 
neither can push or fetch the other.  It seems that git is allergic to 
the dual head branch solution or something, which is surprising and 
disappointing.

How do other people address these situations in git?

--rich

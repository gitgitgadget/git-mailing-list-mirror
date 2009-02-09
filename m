From: agent59624285 <agent59624285@spamcorptastic.com>
Subject: Is Git Scalable?
Date: Mon, 9 Feb 2009 08:29:47 -0800 (PST)
Message-ID: <21916359.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 17:31:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWZ2U-0002Xv-7f
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 17:31:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623AbZBIQ3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 11:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753510AbZBIQ3v
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 11:29:51 -0500
Received: from kuber.nabble.com ([216.139.236.158]:37230 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbZBIQ3u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 11:29:50 -0500
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1LWZ11-00021F-4F
	for git@vger.kernel.org; Mon, 09 Feb 2009 08:29:47 -0800
X-Nabble-From: agent59624285@spamcorptastic.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109092>


I'm thinking on use Git in my projects. But I have a doubt I couldn't resolve
in the Git Docs or Wiki.
My organization has really big projects that we split in sub-projects, like
this:

Big Project
  \---> Project A
  \---> Project B
     \---> Project B1
     \---> Project B2
     \---> Project B3
  \---> Project C
     \---> Project C1

and so on...

Now it's possible to work in each "small" project independently (like "git
clone ProjectB3") or you can work with a big project inheriting its
sub-projects (like "git clone ProjectB" that automatically makes a "git
clone ProjectB1",  "git clone ProjectB2" and  "git clone ProjectB3", putting
each sub-project in the right place).

The question is: does Git support something like this?

-- 
View this message in context: http://www.nabble.com/Is-Git-Scalable--tp21916359p21916359.html
Sent from the git mailing list archive at Nabble.com.

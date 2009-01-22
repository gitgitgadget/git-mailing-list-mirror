From: outre <spoony.sob@hotmail.com>
Subject: lineups with GIT
Date: Wed, 21 Jan 2009 23:54:42 -0800 (PST)
Message-ID: <1232610882661-2196604.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 22 08:56:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPuQ3-0003wd-Nn
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 08:56:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbZAVHyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 02:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753149AbZAVHyo
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 02:54:44 -0500
Received: from kuber.nabble.com ([216.139.236.158]:46511 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120AbZAVHyn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 02:54:43 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1LPuOg-0000T7-SU
	for git@vger.kernel.org; Wed, 21 Jan 2009 23:54:42 -0800
X-Nabble-From: spoony.sob@hotmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106734>


I am trying to set up two different line-ups for a project (development and
testing).

The development line-up is the master, and test line-up pulls data from it.
The code is the same in both.
But since the line-ups are served from two different domains one folder in
the development line-up is called
iWeb.local, and in the test line-up it is called iWeb.test. That is the only
difference between the two.

I tried using "git mv" command and it somewhat solved the problem. After I
cloned the devel line-up, I used "git rm iWeb.local iWeb.test".
And now if I edit a file in iWeb.local and do a pull to iWeb.test this file
gets properly updated while preserving the difference between
the folder names. But if I add a new file to iWeb.local, and then do a pull
I get  iWeb.local folder added together with the 
new file to the testing line-up.

I was wondering if it is intended behaviour for GIT. And if it is may be
someone can point me to a better way to setup two line-ups using
GIT.

Thanks
-- 
View this message in context: http://n2.nabble.com/lineups-with-GIT-tp2196604p2196604.html
Sent from the git mailing list archive at Nabble.com.

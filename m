From: adamantium84 <adamkurjewicz@yahoo.com>
Subject: git repository setup
Date: Mon, 5 Jul 2010 12:19:08 -0700 (PDT)
Message-ID: <29078904.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 05 21:19:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVrCH-0004hF-CS
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 21:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740Ab0GETTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 15:19:10 -0400
Received: from kuber.nabble.com ([216.139.236.158]:54302 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299Ab0GETTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 15:19:09 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1OVrC8-0007JE-9W
	for git@vger.kernel.org; Mon, 05 Jul 2010 12:19:08 -0700
X-Nabble-From: adamkurjewicz@yahoo.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150287>


Hi, my company is looking to move away from cvs and git was one of the
options. The problem that we have is that our file structure looks like
follows, each of these directories have hundreds of programs some which
would be modified by various programming units.

/x1/system/
/x1/config_apps/
/x1/drivers/
/x1/web/apps/

What we were hoping to have was one repository for "x1" and then have
separate sub repositories for each of the extra areas. So that if there are
any developers needing to change a sub repository then they could without
affected the other sub-repositories and without having to have a copy of the
x1 repository on their systems. From what I have read most of the
documentation suggests that there be one repository and then it gets cloned
to a developers repository, this would be a challenge as the storage
requirements to do this would be rather large.

Would anyone have any suggestions on what to do? or if this would be
possible?

Thanks,
Adam
-- 
View this message in context: http://old.nabble.com/git-repository-setup-tp29078904p29078904.html
Sent from the git mailing list archive at Nabble.com.

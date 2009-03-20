From: andholt <andholt@gmail.com>
Subject: How to commit changes if remote repository changed directory
 structure?
Date: Thu, 19 Mar 2009 18:17:15 -0700 (PDT)
Message-ID: <22612715.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 02:19:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkTNw-0002D8-Re
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 02:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbZCTBRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 21:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbZCTBRS
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 21:17:18 -0400
Received: from kuber.nabble.com ([216.139.236.158]:52312 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbZCTBRR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 21:17:17 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1LkTMJ-0002Sn-HF
	for git@vger.kernel.org; Thu, 19 Mar 2009 18:17:15 -0700
X-Nabble-From: andholt@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113882>


I have a lot of local changes to add, commit, and push. Right now our
directory structure is 1/2/3. Another developer decided to move everything
up one level, so used git move to move 3 to 2, and removed 3, so now the
level is 1/2. However, locally, all of my changes are in 1/2/3. 

I want to commit my changes and merge them into the new directory structure.
How would I go about doing that?

Thanks!
-- 
View this message in context: http://www.nabble.com/How-to-commit-changes-if-remote-repository-changed-directory-structure--tp22612715p22612715.html
Sent from the git mailing list archive at Nabble.com.

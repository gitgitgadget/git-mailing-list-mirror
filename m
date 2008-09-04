From: Joshua Williams <joshua.williams@qlogic.com>
Subject: prepare-commit-msg hook and git gui
Date: Thu, 04 Sep 2008 13:06:56 -0500
Message-ID: <48C023C0.10306@qlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 20:23:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbJUj-00060g-19
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 20:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbYIDSWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 14:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752725AbYIDSWM
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 14:22:12 -0400
Received: from eppat.qlogic.com ([198.186.5.11]:39735 "EHLO EPEXCH1.qlogic.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752241AbYIDSWL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 14:22:11 -0400
X-Greylist: delayed 914 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Sep 2008 14:22:11 EDT
Received: from Enki2.local ([10.20.32.63]) by EPEXCH1.qlogic.org with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 4 Sep 2008 13:06:56 -0500
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
X-OriginalArrivalTime: 04 Sep 2008 18:06:56.0102 (UTC) FILETIME=[04527060:01C90EB9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94943>

I've created a prepare-commit-msg hook that composes a basic
template needed to be filled out by users doing a commit.  When
I issue a 'git commit' it works great.  However, if I use 'git gui'/
'git citool' then the template never appears in the "commit
message".  It appears that the prepare-commit-msg hook is
either not run while invoking git gui or git gui is not properly
displaying the generated commit message in the commit
message pain.  Is there some git gui configuration that needs to
be done to accomplish this?  Is this a git gui bug?  Or is it
simply some kind of driver error?

The commit-msg hook does appear to be run after hitting the
commit button in git gui and git gui does display the proper
output from the commit-msg hook.  It appears that this is a
prepare-commit-msg only issue...

Thanks for any info!

- Josh

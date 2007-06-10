From: Adam Piatyszek <ediap@users.sourceforge.net>
Subject: git-svn - creating a tag in a cloned SVN repository
Date: Sun, 10 Jun 2007 22:42:55 +0200
Message-ID: <466C624F.70303@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 10 23:20:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxUpe-0003gk-Pe
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 23:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754974AbXFJVUM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 17:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756069AbXFJVUM
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 17:20:12 -0400
Received: from corvus.et.put.poznan.pl ([150.254.11.130]:45112 "EHLO
	corvus.et.put.poznan.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755112AbXFJVUK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 17:20:10 -0400
X-Greylist: delayed 2151 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Jun 2007 17:20:10 EDT
Received: from corvus (corvus.et.put.poznan.pl [150.254.11.130])
	by corvus.et.put.poznan.pl (8.11.7p1+Sun/8.11.6) with ESMTP id l5AKiHA13346
	for <git@vger.kernel.org>; Sun, 10 Jun 2007 22:44:18 +0200 (MET DST)
Received: from hydrus.et.put.poznan.pl ([150.254.11.145])
	by corvus.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Sun, 10 Jun 2007 22:44:16 +0200 (MET DST)
Received: from [192.168.1.3] (era7.neoplus.adsl.tpnet.pl [83.20.94.7])
	by hydrus.et.put.poznan.pl (8.11.7p1+Sun/8.11.6) with ESMTP id l5AKiFZ11369
	for <git@vger.kernel.org>; Sun, 10 Jun 2007 22:44:15 +0200 (MET DST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49767>

Hi!

I recently switched to git for my projects, even for these which are
tracked in remote SVN repositories (thanks to git-svn tool).
However, I did not find anywhere an answer to one question:

Is it possible to create a subversion-like tag in the remote SVN
repository using git-svn?

In more detail: is it possible to emulate the following SVN command:
  svn copy http://svn.project.server/project/trunk \
           http://svn.project.server/project/tags/release-1.0
using git-svn?

SVN branches and tags are properly imported into separate remote git
branches (by using -T -t and -b switches).

Thanks for your help!
BR,
/ediap

-- 
.:.  Adam Piatyszek - "ediap"       .:.  JID: ediap(at)jabber.org .:.
.:.  ediap(at)users.sourceforge.net .:.  PGP key ID: 0x1F115CCB   .:.

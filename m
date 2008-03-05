From: Teemu Likonen <tlikonen@iki.fi>
Subject: error: refs/remotes/origin/HEAD points nowhere!
Date: Wed, 5 Mar 2008 13:38:44 +0200
Message-ID: <200803051338.44938.tlikonen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 12:39:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWry1-00022H-LF
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 12:39:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757843AbYCELir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 06:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756799AbYCELir
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 06:38:47 -0500
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:37263 "EHLO
	pne-smtpout4-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753252AbYCELir (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2008 06:38:47 -0500
Received: from [192.168.0.2] (80.220.180.181) by pne-smtpout4-sn1.fre.skanova.net (7.3.129)
        id 47A7970A001975BC for git@vger.kernel.org; Wed, 5 Mar 2008 12:38:45 +0100
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76211>

Hi,

Very annoying error "error: refs/remotes/origin/HEAD points nowhere!" 
keeps popping up almost all the time after user has removed remote 
repository "origin". Here's a kind of real-life example:

I have cloned some remote repository:

  git clone git://project/project.git

After a while I start tracking some other remote repository. I do this:

  git remote add ng git://project-ng/project.git

Then I do "git fetch ng" and probably also "git checkout --track -b 
master-ng ng/master". Then I find the old "origin" useless to me so I 
remove it with "git remote rm origin".

It seems that refs/remotes/origin/HEAD is still left in my repository 
and hence I keep getting these annoying error messages all the time. 
Well, I know how to delete this file, but I believe that git should 
have deleted it when I called "git remote rm origin". Am I right? What 
is the purpose of this refs/remotes/origin/HEAD in the first place?

Anyway, thank you guys for this excellent tool and VCS/SCM system. 
Generally git is really joy to use and very powerful. Thanks.

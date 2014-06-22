From: Stephen Kelly <steveire@gmail.com>
Subject: gitk with submodules does not show new commits on other branches
Date: Sun, 22 Jun 2014 16:09:22 +0200
Message-ID: <lo6o2h$vva$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 22 16:09:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WyiSk-0002B3-Q3
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jun 2014 16:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbaFVOJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2014 10:09:36 -0400
Received: from plane.gmane.org ([80.91.229.3]:59893 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751100AbaFVOJf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2014 10:09:35 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WyiSb-00026M-MD
	for git@vger.kernel.org; Sun, 22 Jun 2014 16:09:33 +0200
Received: from g226036065.adsl.alicedsl.de ([92.226.36.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Jun 2014 16:09:33 +0200
Received: from steveire by g226036065.adsl.alicedsl.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Jun 2014 16:09:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: g226036065.adsl.alicedsl.de
User-Agent: KNode/4.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252308>


Hello,

boost.git, is using submodules. 

If I run gitk after a pull, there are some messages along the lines of 


    Update preprocessor from develop.

  Submodule libs/preprocessor 9d2d1ff..1422fce:
    Merge branch 'master' into develop


That is, it shows only the merge. 

If I then run 

 git log --oneline 9d2d1ff..1422fce 

I can see the commits which were made on master and then merged into 
develop. Please show the same information (ie all commits newly reachable 
from develop) in the submodule gitk output.

Thanks,

Steve.

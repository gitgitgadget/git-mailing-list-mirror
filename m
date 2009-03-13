From: Peter Krefting <peter@softwolves.pp.se>
Subject: Not pushing all branches?
Date: Fri, 13 Mar 2009 08:48:55 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0903130846410.17450@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 13 08:51:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li2B6-0003WJ-AX
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 08:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613AbZCMHtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 03:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752591AbZCMHtZ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 03:49:25 -0400
Received: from smtp.getmail.no ([84.208.20.33]:51933 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbZCMHtY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 03:49:24 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0KGF00G2HPQ6QM00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 13 Mar 2009 08:49:18 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KGF00G3OPPROP00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 13 Mar 2009 08:49:03 +0100 (CET)
Received: from perkele ([84.215.142.63]) by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KGF00KHYPPRPQC0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 13 Mar 2009 08:49:03 +0100 (CET)
Received: by perkele (Postfix, from userid 501)	id C280E2FC0B; Fri,
 13 Mar 2009 08:48:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id BF41C2FBF7	for <git@vger.kernel.org>; Fri,
 13 Mar 2009 08:48:55 +0100 (CET)
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113152>

Hi!

Doing "git push remote" pushes all my local branches by default. Is there a 
way to set it to *not* do that, and (for this particular remote repository) 
just push the current branch? Or failing that, not allow me to run "git 
push" without specifying a branch?

The git-config manual page leads me to believe that I should recofigure 
"remote.<name>.push", but it points me to the "refspec" spec on git-push, 
which is a tad cryptic.

-- 
\\// Peter - http://www.softwolves.pp.se/

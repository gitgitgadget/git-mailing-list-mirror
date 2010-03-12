From: Pavel <paullus325@gmail.com>
Subject: Linking two remote repositories
Date: Fri, 12 Mar 2010 14:09:36 +0000 (UTC)
Message-ID: <loom.20100312T145901-192@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 12 15:15:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nq5e1-0005n7-4s
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 15:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932873Ab0CLOPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 09:15:10 -0500
Received: from lo.gmane.org ([80.91.229.12]:49936 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758196Ab0CLOPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 09:15:09 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nq5dn-0005ci-FX
	for git@vger.kernel.org; Fri, 12 Mar 2010 15:15:03 +0100
Received: from gate117.iba.by ([194.158.198.117])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 15:15:03 +0100
Received: from paullus325 by gate117.iba.by with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 15:15:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 194.158.198.117 (Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.9.1.8) Gecko/20100202 Firefox/3.5.8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142037>

Hi All,
I'm just investigating of using git for following:
We have two development teams in far direction from each other and very slow
network connection between them. Currently they are using one Subversion
repository on one side, but committing from other side is very-very slow. 

The idea is to setup two git repositories in two locations and developers will
commit in there local repository. But what I can't figure out it's how to
connect those repositories between each other, I do not want to have two
"special" people to push between remote repositories. 
Is there any ideas how to connect two repositories and have actual code versions
on both of them ?

Thanks, Pavel.

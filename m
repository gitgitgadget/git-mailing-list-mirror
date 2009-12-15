From: Mark Jerkovic <mjerkovic@aconex.com>
Subject: git svn clone just stops
Date: Wed, 16 Dec 2009 09:19:15 +1100
Message-ID: <1260915555.6475.8.camel@mark.engr.acx>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 15 23:34:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKfyF-0000Cf-63
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 23:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761184AbZLOWeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 17:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761141AbZLOWeN
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 17:34:13 -0500
Received: from mail.aconex.com ([203.89.202.182]:55983 "EHLO
	postoffice2.aconex.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760344AbZLOWeM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 17:34:12 -0500
X-Greylist: delayed 888 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Dec 2009 17:34:12 EST
X-ASG-Debug-ID: 1260915561-390a000f0000-QuoKaX
X-Barracuda-URL: http://postoffice2.aconex.com:8000/cgi-bin/mark.cgi
Received: from postoffice.aconex.com (localhost [127.0.0.1])
	by postoffice2.aconex.com (Spam & Virus Firewall) with ESMTP id 079EAA62A5
	for <git@vger.kernel.org>; Wed, 16 Dec 2009 09:19:21 +1100 (EST)
Received: from postoffice.aconex.com (postoffice.yarra.acx [192.168.102.1]) by postoffice2.aconex.com with ESMTP id dipikPy3zb7pq8vs for <git@vger.kernel.org>; Wed, 16 Dec 2009 09:19:21 +1100 (EST)
X-Barracuda-Envelope-From: mjerkovic@aconex.com
Received: from gatekeeper.aconex.com (gatekeeper.yarra.acx [192.168.102.10])
	by postoffice.aconex.com (Postfix) with ESMTP id 37A7EA50110
	for <git@vger.kernel.org>; Wed, 16 Dec 2009 09:17:25 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gatekeeper.aconex.com (Postfix) with ESMTP id D0D6F4892D5
	for <git@vger.kernel.org>; Wed, 16 Dec 2009 09:19:21 +1100 (EST)
X-Virus-Scanned: amavisd-new at aconex.com
Received: from gatekeeper.aconex.com ([127.0.0.1])
	by localhost (gatekeeper.aconex.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6lo53YL9FECk for <git@vger.kernel.org>;
	Wed, 16 Dec 2009 09:19:17 +1100 (EST)
Received: from [192.168.7.137] (melho0.aconex.com [203.89.192.141])
	by gatekeeper.aconex.com (Postfix) with ESMTP id 185134892DF
	for <git@vger.kernel.org>; Wed, 16 Dec 2009 09:19:17 +1100 (EST)
X-ASG-Orig-Subj: git svn clone just stops
X-Mailer: Evolution 2.26.1 
X-Barracuda-Connect: postoffice.yarra.acx[192.168.102.1]
X-Barracuda-Start-Time: 1260915562
X-Barracuda-Virus-Scanned: by Aconex Staff Email Spam Firewall at aconex.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135306>

Hi all,

I am new to Git and I am attempting to clone a SVN repository
(containing approximately 60,000 commits) to Git.

Using Git v1.6.0.4 with the following command:

git svn clone https://path/to/svn/repo/trunk project.git
--authors-file=svnauthors.txt --no-metadata

the process just ends without any messages and the Git repository is
empty.  I have attempted this four times already, and each time it has
stopped after a different revision, so I can't pin it down to a
particular commit.

Has anyone experienced this before?  Is there a log anywhere that
records what is happening during this process?

Thanks,
Mark.

From: Thomas Koch <thomas@koch.ro>
Subject: Merge conflicts with version numbers in release branches
Date: Sun, 7 Apr 2013 17:49:10 +0200
Message-ID: <201304071749.10912.thomas@koch.ro>
Reply-To: thomas@koch.ro
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 07 17:49:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOrqX-0007w8-I0
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 17:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933975Ab3DGPtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 11:49:19 -0400
Received: from koch.ro ([88.198.2.104]:55182 "EHLO koch.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932518Ab3DGPtS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 11:49:18 -0400
Received: from 44-25.106-92.cust.bluewin.ch ([92.106.25.44] helo=x121e.localnet)
	by koch.ro with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <thomas@koch.ro>)
	id 1UOrqC-0004Q6-EK
	for git@vger.kernel.org; Sun, 07 Apr 2013 17:49:12 +0200
User-Agent: KMail/1.13.7 (Linux/3.8-trunk-amd64; KDE/4.8.4; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220319>

Hi,

it's a common problem[1,2,3] in Maven (Java) projects and probably in other 
environments too: You have the version number of your project written in the 
pom.xml. When one merges changes upwards from the maint branche to master, the 
version numbers in maint and master are different and cause a merge conflict.

You might think of solutions for easy cases, but think about several releases 
from the maint branches and several major releases in the same time frame and 
you will run into merge conflicts.

Still, do you know any best practice how to deal with these? Do you know 
examples from other language environments that also keep the version numbers 
under version control and suffer from the same problem? Or is the version 
number somehow taken from the git tag in your environment?

[1] http://brettporter.wordpress.com/2012/02/02/automatically-resolving-
version-conflicts-in-maven-poms-when-merging/
[2] http://bxm-dev.blogspot.ch/2012/05/gitflow-and-maven.html
[3] http://stackoverflow.com/questions/3555160/merging-changes-from-a-maven-
relase-branch-yields-conflicts-due-to-changed-versi

Thank you,

Thomas Koch, http://www.koch.ro

From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: CVS import
Date: Mon, 16 Feb 2009 10:17:57 +0100 (CET)
Message-ID: <19651.77.61.241.211.1234775877.squirrel@hupie.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 10:19:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYzdS-00063Z-5I
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 10:19:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbZBPJSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 04:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbZBPJSB
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 04:18:01 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:35328 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751846AbZBPJSA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Feb 2009 04:18:00 -0500
Received: by Lighthouse.internal.Hupie.com (Postfix, from userid 48)
	id BB1CD58BDCE; Mon, 16 Feb 2009 10:17:57 +0100 (CET)
Received: from 77.61.241.211
        (SquirrelMail authenticated user ferry.huberts@pelagic.nl)
        by hupie.xs4all.nl with HTTP;
        Mon, 16 Feb 2009 10:17:57 +0100 (CET)
User-Agent: SquirrelMail/1.4.8-5.el5.centos.3
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110152>

Hi list,

when I try to import a CVS repo with:

git cvsimport -v -i \
  -d :pserver:anonymous@javagroups.cvs.sourceforge.net:/cvsroot/javagroups \
  JGroups

I'm getting the errors:

New tests/other/org/jgroups/tests/adapttcp/Test.java: 5914 bytes
Use of uninitialized value in concatenation (.) or string at /usr/bin/git-cvsimport line 674, <CVS> line 652.
Use of uninitialized value in concatenation (.) or string at /usr/bin/git-cvsimport line 674, <CVS> line 652.
fatal: malformed index info 100666 	src/org/jgroups/util/RWLock.java
unable to write to git-update-index:  at /usr/bin/git-cvsimport line 679, <CVS> line 652.


I've seen this before when trying to import other repositories.
And since I'm not good with Perl I was wondering whether this sounds familiar
and if there's a fix for it.

I'm on Fedora 10 with the following packages:
git.x86_64                                                      1.6.0.6-1.fc10
git-all.x86_64                                                  1.6.0.6-1.fc10
git-arch.x86_64                                                 1.6.0.6-1.fc10
git-cvs.x86_64                                                  1.6.0.6-1.fc10
git-daemon.x86_64                                               1.6.0.6-1.fc10
git-email.x86_64                                                1.6.0.6-1.fc10
git-gui.x86_64                                                  1.6.0.6-1.fc10
git-svn.x86_64                                                  1.6.0.6-1.fc10
gitk.x86_64                                                     1.6.0.6-1.fc10
gitosis.noarch                                                  0.2-6.20080825git.fc10
gitweb.x86_64                                                   1.6.0.6-1.fc10



Ferry

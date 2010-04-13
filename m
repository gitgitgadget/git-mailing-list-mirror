From: =?iso-8859-1?Q?Daniel_Lidstr=F6m?= <daniel.lidstrom@sbg.se>
Subject: Error doing git svn rebase
Date: Tue, 13 Apr 2010 14:54:12 +0200
Message-ID: <FE8B524F1BF0854187E434B85105AC694869F8@dorado.ad.sbg.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 13 15:18:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1g0o-0000kS-Le
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 15:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796Ab0DMNSg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Apr 2010 09:18:36 -0400
Received: from mail.sbg.se ([83.241.165.77]:1266 "EHLO mail.sbg.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751473Ab0DMNSf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Apr 2010 09:18:35 -0400
X-Greylist: delayed 1443 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Apr 2010 09:18:35 EDT
Received: from dorado.ad.sbg.se (dorado.sbg.se [10.213.3.103])
	by mail.sbg.se (Postfix) with ESMTP id F09033200C3
	for <git@vger.kernel.org>; Tue, 13 Apr 2010 14:54:16 +0200 (CEST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Error doing git svn rebase
Thread-Index: AcrbCGqEonx774h8QpWO1n8NpsS39w==
X-SBG-MailScanner: Found to be clean
X-SBG-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-1.184, required 5, autolearn=not spam, AWL 0.82,
	BAYES_00 -2.00)
X-SBG-MailScanner-From: daniel.lidstrom@sbg.se
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144817>

Hello,

I have cloned our subversion repository using git svn clone. Then I hav=
e made a few changes
and committed a few times. Now I would like to do git svn rebase before=
 I continue, to be
sure I don't get too much out-of-sync with the subversion repository. H=
owever, git-svn fails
like this:

luna:/home/daniel/projects/UMC3D-9.1.git(master)> git svn rebase
=46irst, rewinding head to replay your work on top of it...
Applying: - Doxygen fixes.
Applying: - Code cleanups.
Applying: - Logging fixes.
fatal: Unable to create '/home/daniel/projects/UMC3D-9.1.git/.git/index=
=2Elock': File exists.

If no other git process is currently running, this probably means a
git process crashed in this repository earlier. Make sure no other git
process is running and remove the file manually to continue.
rebase refs/remotes/git-svn: command returned error: 1

luna:/home/daniel/projects/UMC3D-9.1.git> git branch
* (no branch)
  master
luna:/home/daniel/projects/UMC3D-9.1.git> git checkout master
error: Entry 'GeoROG/Control/MikrofynAdvancedBladeController.cpp' would=
 be overwritten by merge. Cannot merge.

luna:/home/daniel/projects/UMC3D-9.1.git> dir .git/index.lock
ls: cannot access .git/index.lock: No such file or directory
luna:/home/daniel/projects/UMC3D-9.1.git> git --version
git version 1.6.3.3
luna:/home/daniel/projects/UMC3D-9.1.git> git svn --version
git-svn version 1.6.3.3 (svn 1.6.5)
luna:/home/daniel/projects/UMC3D-9.1.git>=20

At this point I am not sure how to best handle this problem. Any help w=
ould be much appreciated!

Regards,

Daniel Lidstr=F6m
Stockholm, Sweden=20

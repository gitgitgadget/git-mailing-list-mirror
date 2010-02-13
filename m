From: Daniel Black <daniel.subs@internode.on.net>
Subject: cvsimport error when modulename is '.'
Date: Sat, 13 Feb 2010 22:51:42 +1100
Message-ID: <201002132251.42070.daniel.subs@internode.on.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 13:08:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgGnR-0003pn-Ee
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 13:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162Ab0BMMIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 07:08:19 -0500
Received: from bld-mail19.adl2.internode.on.net ([150.101.137.104]:44375 "EHLO
	mail.internode.on.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752504Ab0BMMIT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 07:08:19 -0500
X-Greylist: delayed 916 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Feb 2010 07:08:18 EST
Received: from passivegrunt.localnet (unverified [121.45.205.47]) 
	by mail.internode.on.net (SurgeMail 3.8f2) with ESMTP id 13499141-1927428 
	for <git@vger.kernel.org>; Sat, 13 Feb 2010 22:23:01 +1030 (CDT)
User-Agent: KMail/1.13.0 (Linux/2.6.31-gentoo-r4; KDE/4.4.0; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139791>


in an empty directory I'm attempting the command:

git  cvsimport -A ../authcvs-conv -k -m -v -d:pserver:anonymous@opendkim.cvs.sourceforge.net:/cvsroot/opendkim .

this results in ...

Initialized empty Git repository in /home/dan/software_projects/opendkim-import4/.git/                                                
Running cvsps...                                                                                                                      
connect error: Network is unreachable                                                                                                 
cvs rlog: Logging .                                                                                                                   
NOTICE: used alternate strip path /cvsroot/opendkim/.c                                                                                
WARNING: file /cvsroot/opendkim/BRANCHES doesn't match strip_path /cvsroot/opendkim/.c. ignoring                                      
WARNING: file /cvsroot/opendkim/FEATURES doesn't match strip_path /cvsroot/opendkim/.c. ignoring                                      
....
for every file up until the end:
....
Fetching vsignore   v 1.1
Unknown: error

The resulting directory is empty apart from a empty initialised git repository.

git version 1.7.0.rc2.13.g8b233.dirty
cvsps version 2.1

numerous permutations of attempting this import have failed. Also fails with
 the CVS module aliases 'world -> .' and attempting to use "world" as an alias name.

I'm happy to assist in debugging this if required.

Daniel
OpenDKIM developer

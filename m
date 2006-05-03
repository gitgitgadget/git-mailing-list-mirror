From: Panagiotis Issaris <takis@lumumba.uhasselt.be>
Subject: Problem using GIT CVS-server
Date: Wed, 03 May 2006 10:11:17 +0200
Message-ID: <445865A5.5030700@lumumba.uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed May 03 10:12:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbCSV-00080h-3Q
	for gcvg-git@gmane.org; Wed, 03 May 2006 10:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965112AbWECILU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 04:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbWECILT
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 04:11:19 -0400
Received: from alpha.uhasselt.be ([193.190.2.30]:19684 "EHLO alpha.uhasselt.be")
	by vger.kernel.org with ESMTP id S965116AbWECILS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 04:11:18 -0400
Received: from localhost (datastorage.uhasselt.be [193.190.2.17])
	by alpha.uhasselt.be (Postfix) with ESMTP id E04821AB18B
	for <git@vger.kernel.org>; Wed,  3 May 2006 10:11:17 +0200 (CEST)
X-Virus-Scanned: by Amavisd antivirus & antispam cluster at uhasselt.be
Received: from [172.18.16.239] (edm-006.edm.uhasselt.be [193.190.10.6])
	by alpha.uhasselt.be (Postfix) with ESMTP id 262021AB137
	for <git@vger.kernel.org>; Wed,  3 May 2006 10:11:17 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19457>

Hi,

I've tried using git-cvsserver, but keep running into problems:
When doing a checkout, it only checks out a small subset of
the total amount of files in the repository and reports a warning/error.
When doing a subsequent update, it doesn't seem to do anything,
but reports two error messages/warnings.

I'm using yesterdays GIT and try to serve my local copy of the GIT
repository using git-cvsserver.

export CVSROOT=:ext:takis@localhost:/usr/local/src/git/.git
export CVS_SERVER=git-cvsserver

takis@issaris:/tmp/a/b$ cvs co -d project-master master
takis@localhost's password:
cvs checkout: Updating project-master
U project-master/Makefile
U project-master/README
U project-master/cache.h
U project-master/cat-file.c
U project-master/commit-tree.c
U project-master/init-db.c
U project-master/read-cache.c
U project-master/read-tree.c
U project-master/show-diff.c
U project-master/update-cache.c
U project-master/write-tree.c
closing dbh with active statement handles
takis@issaris:/tmp/a/b$ cd project-master/
takis@issaris:/tmp/a/b/project-master$ cvs -z3 update -PAd
takis@localhost's password:
server doesn't support gzip-file-contents
closing dbh with active statement handles
takis@issaris:/tmp/a/b/project-master$

With friendly regards,
Takis

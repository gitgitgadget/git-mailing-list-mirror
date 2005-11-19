From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: cg-commit doesn't like new repository
Date: Sat, 19 Nov 2005 22:43:10 +0000
Message-ID: <200511192243.10815.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Nov 19 23:44:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdbQL-0006W0-AP
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 23:43:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbVKSWnD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 17:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbVKSWnB
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 17:43:01 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:41133
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1751003AbVKSWnA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 17:43:00 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1EdbQB-0006HB-MS
	for git@vger.kernel.org; Sat, 19 Nov 2005 22:42:59 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12354>

I just decided to make a repository of /etc, but because I didn't want to load 
in all the files, I used git-init-db to create the repository rather than 
cg-init-db

I then did cg-add for fstab

followed up by cg-commit which then failed as shown below

As soon as I have done a git-commit, all is OK, and cg-commit works again.

I presume there is something that cg-init-db does which makes it suitable for 
cogito - but what, and shouldn't cg-commit notice and either do it 
automatically or give a different error message?


cg-commit
usage: git-diff-index [-m] [--cached] [<common diff options>] <tree-ish> 
[<path>...]
common diff options:
  -z            output diff-raw with lines terminated with NUL.
  -p            output patch format.
  -u            synonym for -p.
  --name-only   show only names of changed files.
  --name-status show names and status of changed files.
  -R            swap input file pairs.
  -B            detect complete rewrites.
  -M            detect renames.
  -C            detect copies.
  --find-copies-harder
                try unchanged files as candidate for copy detection.
  -l<n>         limit rename attempts up to <n> paths.
  -O<file>      reorder diffs according to the <file>.
  -S<string>    find filepair whose only one side contains the string.
  --pickaxe-all
                show all files diff when -S is used and hit is found.

cg-commit: Nothing to commit
root@kanger etc[master]#                                            
-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.

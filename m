From: Ben Clifford <benc@hawaga.org.uk>
Subject: stg refresh/conflict resolution helptext/reality inconsistency
Date: Mon, 13 Feb 2006 13:14:05 +1300 (NZDT)
Message-ID: <Pine.OSX.4.64.0602131305420.19080@piva.hawaga.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-From: git-owner@vger.kernel.org Mon Feb 13 02:44:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8Sky-0007rK-4Q
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 02:44:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWBMBn5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 20:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWBMBn5
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 20:43:57 -0500
Received: from mundungus.clifford.ac ([81.187.211.39]:55302 "EHLO
	mundungus.clifford.ac") by vger.kernel.org with ESMTP
	id S1751103AbWBMBn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 20:43:57 -0500
Received: from piva.hawaga.org.uk (localhost [127.0.0.1])
	by mundungus.clifford.ac (8.13.3/8.13.3) with ESMTP id k1D1gkPJ022828;
	Mon, 13 Feb 2006 01:42:48 GMT
Received: by piva.hawaga.org.uk (Postfix, from userid 501)
	id 4041CD4E49F; Mon, 13 Feb 2006 13:14:06 +1300 (NZDT)
Received: from localhost (localhost [127.0.0.1])
	by piva.hawaga.org.uk (Postfix) with ESMTP id 113E5D4E49B;
	Mon, 13 Feb 2006 13:14:06 +1300 (NZDT)
To: git@vger.kernel.org, catalin.marinas@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16034>


The following happens to me. The help text about using "refresh" doesn't 
seem to match up what I actually did. Am I doing something wrong?


$ stg push
Pushing patch "strcmp-ordering"...Error: three-way merge tool failed for 
file "imap/src/osdep/unix/maildir.c"
The merge failed during "push". Use "refresh" after fixing the conflicts
stg push: git-merge-index failed (possible conflicts)

[edit file to get rid of the <<< === >>> stuff]

$ stg refresh
stg refresh: Unsolved conflicts. Please resolve them first

$ rm .git/conflicts

$ stg refresh
Refreshing patch "strcmp-ordering"... done



This is the stg version I'm using:

$ stg --version
Stacked GIT 0.8
git version 1.1.6.gd19e
Python version 2.3.5 (#1, Mar 20 2005, 20:38:20)
[GCC 3.3 20030304 (Apple Computer, Inc. build 1809)]

$ cd ~/src/stgit 
$ cg status | grep master
    >master      0a01a6d0eaf0c6a70819da2f73fc659e7a83b569
